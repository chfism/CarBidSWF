package r1.deval.parser
{
   import r1.deval.rt.Block;
   import r1.deval.rt.EndBlock;
   import r1.deval.rt.ExprList;
   import r1.deval.rt.ForInCond;
   import r1.deval.rt.ForInPrologue;
   import r1.deval.rt.FunctionDef;
   import r1.deval.rt.IExpr;
   import r1.deval.rt.ImportStmt;
   import r1.deval.rt.UnaryStmt;
   
   public class BaseParser extends ExprParser
   {
      
      public static var debugDump:Boolean = false;
       
      
      private var functionList:Array;
      
      private var functionExitBlock:EndBlock = null;
      
      private var curBlock:Block;
      
      private var switchStack:Array;
      
      private var forCount:int = 0;
      
      private var doWhileCount:int = 0;
      
      private var whileCount:int = 0;
      
      private var forInCount:int = 0;
      
      private var anonLabelCount:int = 0;
      
      private var labelStack:Array;
      
      private var blockStack:Array;
      
      public function BaseParser()
      {
         blockStack = [];
         super();
      }
      
      private static function dumpProgram(header:String, block:Block, fxnList:Array) : void
      {
         var fd:FunctionDef = null;
         trace(header);
         var dumpMap:Object = {};
         for each(fd in fxnList)
         {
            fd.dump(dumpMap);
         }
         block.dump(dumpMap);
      }
      
      private static function getIgnoredKeyword(tt:int) : String
      {
         switch(tt)
         {
            case CLASS:
               return "class";
            case TRY:
               return "try";
            case CATCH:
               return "catch";
            case FINALLY:
               return "finally";
            default:
               return "";
         }
      }
      
      public function addStmt(stmt_or_expr:*, lineno:int) : void
      {
         if(curBlock.lastIsExit)
         {
            reportError("msg.unreachable.code","K51");
         }
         curBlock.addStmt(stmt_or_expr,lineno);
      }
      
      protected function statementAsBlock(blockName:String = null, inForInit:Boolean = false) : Array
      {
         var temp:Block = new Block(blockName);
         newBlock(temp);
         statement(null,inForInit);
         var ret:Array = [temp,curBlock];
         popBlock();
         return ret;
      }
      
      private function curSwitch() : Object
      {
         return switchStack[switchStack.length - 1];
      }
      
      protected function condition() : IExpr
      {
         mustMatchToken(LP,"msg.no.paren.cond","k51");
         var ret:IExpr = expression();
         mustMatchToken(RP,"msg.no.paren.after.cond","k52");
         return ret;
      }
      
      protected function enterLoop(label:Label, blk:Block, postfix:Block, typeName:String = null) : Label
      {
         if(label == null)
         {
            label = createLabel(typeName);
         }
         label.block = blk;
         label.postfix = postfix == null?blk:postfix;
         pushLabel(label);
         return label;
      }
      
      public function lastIsExit(blk:Block) : Boolean
      {
         return blk != null && blk.lastIsExit;
      }
      
      private function popLabel() : Label
      {
         return labelStack.pop() as Label;
      }
      
      private function forStatement(lineno:int, stmtLabel:Label) : void
      {
         var iterVar:String = null;
         var cond:IExpr = null;
         var isForEach:Boolean = false;
         if(matchToken(NAME))
         {
            if(ts.getString() == "each")
            {
               isForEach = true;
            }
            else
            {
               reportError("msg.no.paren.for","K55");
            }
         }
         mustMatchToken(LP,"msg.no.paren.for","k54");
         var tt:int = peekToken();
         if(tt != SEMI)
         {
            if(tt == VAR)
            {
               consumeToken();
               mustMatchToken(NAME,"msg.bad.var","k55");
               iterVar = ts.getString();
               if(peekToken() == IN)
               {
                  consumeToken();
                  exprFactory.createVarExpr(iterVar);
               }
               else
               {
                  variables(iterVar);
                  iterVar = null;
               }
            }
            else if(peekToken() == NAME)
            {
               iterVar = ts.getString();
               consumeToken();
               if(peekToken() == IN)
               {
                  consumeToken();
               }
               else
               {
                  pushbackLookahead();
                  iterVar = null;
                  statement(null,true);
               }
            }
            else
            {
               statement(null,true);
            }
         }
         var tempBlock:Block = null;
         if(iterVar)
         {
            cond = expression();
         }
         else
         {
            mustMatchToken(SEMI,"msg.no.semi.for","k56");
            cond = peekToken() == SEMI?null:expression();
            mustMatchToken(SEMI,"msg.no.semi.for.cond","k57");
            if(peekToken() != RP)
            {
               tempBlock = statementAsBlock(null,true)[0] as Block;
            }
         }
         mustMatchToken(RP,"msg.no.paren.for.ctrl","k58");
         var id:String = (!!isForEach?"@for_each_":Boolean(iterVar)?"@for_in_":"@for_") + forCount++;
         if(iterVar == null)
         {
            whileStatement(lineno,stmtLabel,id,cond,":for-body:",tempBlock);
         }
         else
         {
            forInStatement(lineno,stmtLabel,id,iterVar,cond,isForEach,tempBlock);
         }
      }
      
      private function doWhileStatement(stmtLabel:Label) : void
      {
         var label:Label = null;
         var nextBlock:Block = null;
         var arr:Array = statementAsBlock(":do-while-body");
         var tempBlock:Block = arr[0] as Block;
         curBlock.trueNext = tempBlock;
         if(!lastIsExit((arr[1] as Block).trueNext))
         {
            (arr[1] as Block).trueNext = tempBlock;
         }
         try
         {
            label = enterLoop(stmtLabel,tempBlock,null,"@do_while_");
            tempBlock.name = label.name;
            mustMatchToken(WHILE,"msg.no.while.do","k53");
            tempBlock.setCond(condition(),ts.getLineno());
            nextBlock = new Block();
            if(!lastIsExit((arr[1] as Block).trueNext))
            {
               (arr[1] as Block).falseNext = nextBlock;
            }
            popBlock();
            newBlock(nextBlock);
         }
         finally
         {
            exitLoop();
         }
      }
      
      override protected function parseFunction(isAnon:Boolean = false) : FunctionDef
      {
         var name:String = null;
         var tt:int = 0;
         if(!isAnon)
         {
            name = checkAndConsumeToken(NAME,"msg.missing.function.name","Kf1");
         }
         checkAndConsumeToken(LP,"msg.no.paren.parms","Kf2");
         var params:Array = [];
         loop0:
         while(true)
         {
            tt = peekToken();
            if(tt == RP)
            {
               break;
            }
            if(tt == NAME)
            {
               params.push(ts.getString());
               consumeToken();
               loop1:
               while(true)
               {
                  switch(peekToken())
                  {
                     case COLON:
                     case DOT:
                     case NAME:
                        consumeToken();
                        continue;
                     case COMMA:
                        break loop1;
                     case RP:
                        addr90:
                        continue loop0;
                     default:
                        reportError("msg.no.paren.after.parms","Kf3");
                        continue;
                  }
               }
               consumeToken();
               §§goto(addr90);
            }
            else
            {
               continue;
            }
         }
         consumeToken();
         loop2:
         while(true)
         {
            switch(peekToken())
            {
               case COLON:
               case DOT:
               case NAME:
                  consumeToken();
                  continue;
               case LC:
                  break loop2;
               default:
                  reportError("msg.no.brace.body","Kf4");
                  continue;
            }
         }
         consumeToken();
         var head:Block = newBlock();
         var tail:EndBlock = functionExitBlock = new EndBlock("[/" + name + "]");
         while(functionExitBlock != null)
         {
            statement();
         }
         var lastBlock:Block = popBlockTo(head);
         if(lastBlock.getRefCount() > 0)
         {
            if(lastBlock.trueNext == null)
            {
               lastBlock.trueNext = tail;
            }
            if(lastBlock.falseNext == null)
            {
               lastBlock.falseNext = tail;
            }
         }
         return new FunctionDef(name,params,head,tail);
      }
      
      private function checkAndConsumeToken(token:int, msgId:String, id:String) : String
      {
         if(peekToken() != token)
         {
            reportError(msgId,id);
         }
         var ret:String = ts.getString();
         consumeToken();
         return ret;
      }
      
      private function get inSwitch() : Boolean
      {
         return switchStack.length > 0;
      }
      
      private function enterSwitch(stmtLabel:Label, cond:IExpr, lineno:int) : void
      {
         checkAndConsumeToken(LC,"msg.no.brace.switch","Ksw5");
         var switchVarName:String = "_switch_" + switchDepth;
         addStmt(exprFactory.createVarExpr(switchVarName,cond),0);
         var branch:Block = curBlock;
         branch.trueNext = newBlock();
         if(stmtLabel == null)
         {
            stmtLabel = createLabel();
         }
         stmtLabel.isSwitch = true;
         stmtLabel.block = new Block();
         pushLabel(stmtLabel);
         var switchInfo:Object = {
            "switchVar":exprFactory.createAccessor(null,switchVarName),
            "type":0,
            "branchHead":curBlock,
            "branchCondition":branch,
            "label":stmtLabel
         };
         var depth:int = switchDepth;
         switchStack.push(switchInfo);
         do
         {
            statement();
         }
         while(switchDepth > depth);
         
      }
      
      protected function popBlock() : Block
      {
         var ret:Block = blockStack.pop() as Block;
         curBlock = blockStack[blockStack.length - 1] as Block;
         return ret;
      }
      
      private function getLabel(name:String) : Label
      {
         var label:Label = labelStack[name] as Label;
         if(label == null)
         {
            reportError("msg.undef.label","K53");
         }
         return label;
      }
      
      private function forInStatement(lineno:int, stmtLabel:Label, defaultLabelName:String, iterVar:String, coll:IExpr, isForEach:Boolean, increment:Block = null) : void
      {
         var begin_end:Array = null;
         var begin:Block = null;
         var nextBlock:Block = new Block();
         var forInLoopId:int = forInCount++;
         var fip:ForInPrologue = new ForInPrologue(forInLoopId,iterVar,coll,isForEach,lineno);
         addStmt(fip,lineno);
         var tempBlock:Block = new Block();
         curBlock.trueNext = tempBlock;
         tempBlock.falseNext = nextBlock;
         var label:Label = enterLoop(stmtLabel,tempBlock,increment,defaultLabelName);
         tempBlock.name = label.name;
         try
         {
            begin_end = statementAsBlock(":for-body:");
            begin = begin_end[0] as Block;
            if(increment != null)
            {
               increment.trueNext = begin.trueNext;
               begin.trueNext = increment;
            }
            tempBlock.setCond(new ForInCond(fip));
            tempBlock.trueNext = begin;
            tempBlock.falseNext = nextBlock;
            (begin_end[1] as Block).trueNext = tempBlock;
            popBlock();
            newBlock(nextBlock);
         }
         finally
         {
            exitLoop();
         }
      }
      
      private function whileStatement(lineno:int, stmtLabel:Label, defaultLabelName:String, cond:IExpr, bodyName:String = ":while_body:", increment:Block = null) : void
      {
         var begin_end:Array = null;
         var end:Block = null;
         var nextBlock:Block = new Block();
         var tempBlock:Block = new Block();
         curBlock.trueNext = tempBlock;
         tempBlock.setCond(cond,lineno);
         tempBlock.falseNext = nextBlock;
         var label:Label = enterLoop(stmtLabel,tempBlock,increment,defaultLabelName);
         tempBlock.name = label.name;
         try
         {
            begin_end = statementAsBlock(bodyName);
            end = begin_end[1] as Block;
            if(increment != null && !end.lastIsExit)
            {
               increment.trueNext = end.trueNext;
               end.trueNext = increment;
               end = increment;
            }
            tempBlock.trueNext = begin_end[0] as Block;
            if(!end.lastIsExit)
            {
               end.trueNext = tempBlock;
            }
            popBlock();
            newBlock(nextBlock);
         }
         finally
         {
            exitLoop();
         }
      }
      
      private function matchJumpLabelName() : Label
      {
         if(peekTokenOrEOL() != NAME)
         {
            return null;
         }
         consumeToken();
         return getLabel(ts.getString());
      }
      
      protected function newBlock(blk:* = null) : Block
      {
         if(blk == null)
         {
            blk = new Block();
         }
         else if(blk is String)
         {
            blk = new Block(String(blk));
         }
         blockStack.push(curBlock = blk as Block);
         return curBlock;
      }
      
      override protected function initParser(sourceString:String) : void
      {
         super.initParser(sourceString);
         labelStack = [];
         switchStack = [];
         functionList = [];
      }
      
      private function breakContinueStatement(isBreak:Boolean) : void
      {
         curBlock.lastIsExit = true;
         var label:Label = matchJumpLabelName();
         if(label == null)
         {
            label = peekLabel();
         }
         if(label.isSwitch)
         {
            if(!isBreak)
            {
               reportError("msg.bad.continue","Ksw");
            }
            curBlock.trueNext = label.block;
         }
         else
         {
            curBlock.trueNext = !!isBreak?label.block.falseNext:label.postfix;
         }
      }
      
      public function parseProgram(source:String) : Object
      {
         var fd:FunctionDef = null;
         initParser(source);
         newBlock(":Main:");
         var root:Block = curBlock;
         while(peekToken() != EOF)
         {
            statement();
         }
         if(curBlock.trueNext == null)
         {
            curBlock.trueNext = EndBlock.EXIT;
         }
         popBlock();
         if(debugDump)
         {
            dumpProgram("===== Pre-optimization =====",root,functionList);
         }
         root.optimize();
         for each(fd in functionList)
         {
            fd.optimize();
         }
         if(debugDump)
         {
            dumpProgram("\n===== Post-optimization =====",root,functionList);
         }
         if(functionList.length == 0)
         {
            return root;
         }
         return [root,functionList];
      }
      
      private function ifStatement(lineno:int, cond:IExpr) : void
      {
         curBlock.setCond(cond,lineno);
         var nextBlock:Block = new Block();
         var arr:Array = statementAsBlock(":if-part:");
         curBlock.trueNext = arr[0] as Block;
         var end:Block = arr[1] as Block;
         if(!end.lastIsExit)
         {
            end.trueNext = nextBlock;
         }
         if(matchToken(ELSE))
         {
            consumeToken();
            arr = statementAsBlock(":else-part:");
            curBlock.falseNext = arr[0] as Block;
            end = arr[1] as Block;
            if(!end.lastIsExit)
            {
               end.trueNext = nextBlock;
            }
         }
         else
         {
            curBlock.falseNext = nextBlock;
         }
         popBlock();
         newBlock(nextBlock);
      }
      
      private function switchEvent(type:int, expr:IExpr = null) : void
      {
         var label:Label = null;
         var lineno:int = ts.getLineno();
         var switchInfo:Object = curSwitch();
         var branchCond:Block = switchInfo.branchCondition as Block;
         var head:Block = switchInfo.branchHead as Block;
         var prevType:int = switchInfo.type as int;
         switchInfo.type = type;
         if(expr != null)
         {
            expr = exprFactory.createEqRelExpr(switchInfo.switchVar as IExpr,expr,EQ);
         }
         if(prevType == 0)
         {
            if(!head.isEmpty())
            {
               reportError("msg.unreachable.stmts.in.switch","Ksw6");
            }
            if(type == CASE)
            {
               branchCond.setCond(expr,lineno);
            }
            else
            {
               switchInfo.defaultBlockHead = head;
            }
            return;
         }
         var tail:Block = popBlockTo(head);
         if(prevType == DEFAULT)
         {
            switchInfo.defaultBlockTail = tail;
         }
         if(type == RC)
         {
            label = popLabel();
            if(!tail.lastIsExit)
            {
               tail.trueNext = label.block;
            }
            head = switchInfo.defaultBlockHead as Block;
            if(head != null)
            {
               tail = switchInfo.defaultBlockTail as Block;
               branchCond.falseNext = head;
            }
            switchStack.pop();
            newBlock(label.block);
            return;
         }
         switchInfo.branchHead = newBlock();
         if(!tail.lastIsExit)
         {
            tail.trueNext = curBlock;
         }
         if(type == DEFAULT)
         {
            switchInfo.defaultBlockHead = curBlock;
         }
         else if(type == CASE)
         {
            if(branchCond.getCond() != null)
            {
               branchCond.falseNext = new Block();
               branchCond = branchCond.falseNext;
               branchCond.falseNext = peekLabel().block;
               switchInfo.branchCondition = branchCond;
            }
            branchCond.setCond(expr,lineno);
            branchCond.trueNext = curBlock;
         }
      }
      
      protected function popBlockTo(blk:Block) : Block
      {
         var ret:Block = popBlock();
         var idx:int = blockStack.indexOf(blk);
         if(idx >= 0)
         {
            blockStack.length = idx;
         }
         curBlock = blockStack[blockStack.length - 1] as Block;
         return ret;
      }
      
      private function createLabel(name:String = null) : Label
      {
         if(name == null)
         {
            name = "@_";
         }
         return new Label(name + anonLabelCount++);
      }
      
      private function peekLabel() : Label
      {
         if(labelStack.length == 0)
         {
            reportError("msg.bad.break.continue","K56");
         }
         return labelStack[labelStack.length - 1] as Label;
      }
      
      protected function exitLoop() : void
      {
         popLabel();
      }
      
      private function statements() : void
      {
         var tt:int = 0;
         while((tt = peekToken()) != EOF && tt != RC)
         {
            statement();
         }
      }
      
      private function get switchDepth() : int
      {
         return switchStack.length;
      }
      
      private function defaultNamespaceStatement(lineno:int) : void
      {
         if(!(matchToken(NAME) && ts.getString() == "xml"))
         {
            reportError("msg.bad.namespace","K57");
         }
         if(!(matchToken(NAME) && ts.getString() == "namespace"))
         {
            reportError("msg.bad.namespace","K58");
         }
         if(!matchToken(ASSIGN))
         {
            reportError("msg.bad.namespace","K59");
         }
         addStmt(new UnaryStmt(DEFAULT_NS,expression(),lineno),lineno);
      }
      
      private function statement(stmtLabel:Label = null, inForInit:Boolean = false) : void
      {
         var expr:IExpr = null;
         var name:String = null;
         var firstLabel:Boolean = false;
         var ttFlagged:int = 0;
         var lineno:int = ts.getLineno();
         var tt:int = peekToken();
         switch(tt)
         {
            case IF:
               consumeToken();
               ifStatement(lineno,condition());
               return;
            case SWITCH:
               consumeToken();
               enterSwitch(stmtLabel,condition(),lineno);
               break;
            case CASE:
               consumeToken();
               if(!inSwitch)
               {
                  reportError("msg.misplaced.case","Ksw1");
               }
               expr = expression();
               checkAndConsumeToken(COLON,"msg.case.no.colon","Ksw2");
               switchEvent(CASE,expr);
               return;
            case DEFAULT:
               consumeToken();
               if(peekToken() == COLON)
               {
                  checkAndConsumeToken(COLON,"msg.case.no.colon","Ksw3");
                  switchEvent(DEFAULT);
                  return;
               }
               defaultNamespaceStatement(lineno);
               break;
            case RC:
               if(!inSwitch && functionExitBlock == null)
               {
                  reportError("msg.misplaced.right.brace","Krc");
               }
               consumeToken();
               if(inSwitch)
               {
                  switchEvent(RC);
               }
               else
               {
                  functionExitBlock = null;
               }
               return;
            case BREAK:
            case CONTINUE:
               consumeToken();
               breakContinueStatement(tt == BREAK);
               break;
            case THROW:
               consumeToken();
               curBlock.lastIsExit = true;
               addStmt(new UnaryStmt(THROW,expression(),lineno),lineno);
               break;
            case WHILE:
               consumeToken();
               expr = condition();
               whileStatement(lineno,stmtLabel,"@while_" + whileCount++,expr);
               return;
            case DO:
               consumeToken();
               doWhileStatement(stmtLabel);
               return;
            case FOR:
               consumeToken();
               forStatement(ts.getLineno(),stmtLabel);
               return;
            case VAR:
               consumeToken();
               variables();
               break;
            case RETURN:
               consumeToken();
               switch(peekTokenOrEOL())
               {
                  case SEMI:
                     consumeToken();
                  case RC:
                  case EOF:
                  case EOL:
                  case ERROR:
                     break;
                  default:
                     addStmt(expression(),lineno);
               }
               curBlock.trueNext = functionExitBlock != null?functionExitBlock:EndBlock.EXIT;
               curBlock.lastIsExit = true;
               break;
            case LC:
               consumeToken();
               statements();
               mustMatchToken(RC,"msg.no.brace.block","k65");
               return;
            case ERROR:
            case SEMI:
               consumeToken();
               break;
            case IMPORT:
               consumeToken();
               readImports(lineno);
               break;
            case NAME:
               name = ts.getString();
               setCheckForLabel();
               expr = expression();
               if(expr is Label)
               {
                  if(stmtLabel == null)
                  {
                     firstLabel = true;
                     stmtLabel = expr as Label;
                  }
                  else
                  {
                     firstLabel = false;
                  }
                  statement(stmtLabel);
                  break;
               }
               addStmt(expr,lineno);
               break;
            case FUNCTION:
               consumeToken();
               functionList.push(parseFunction());
               break;
            case CLASS:
               reportError("msg.class.not.supported","K64");
               break;
            case TRY:
            case CATCH:
            case FINALLY:
               reportError("msg.reserved.id","K54",getIgnoredKeyword(tt));
               break;
            default:
               addStmt(expression(),ts.getLineno());
         }
         if(!inForInit)
         {
            ttFlagged = peekFlaggedToken();
            switch(ttFlagged & CLEAR_TI_MASK)
            {
               case SEMI:
                  consumeToken();
               case ERROR:
               case EOF:
               case RC:
                  break;
               default:
                  if((ttFlagged & TI_AFTER_EOL) == 0)
                  {
                     reportError("msg.no.semi.stmt","K65");
                     break;
                  }
            }
         }
      }
      
      private function readImports(lineno:int) : void
      {
         var curName:String = null;
         var ttFlagged:int = 0;
         var names:Array = [];
         loop0:
         while(true)
         {
            ttFlagged = peekFlaggedToken();
            switch(ttFlagged & CLEAR_TI_MASK)
            {
               case NAME:
                  if(!curName)
                  {
                     curName = ts.getString();
                  }
                  else
                  {
                     curName = curName + ("." + ts.getString());
                  }
                  consumeToken();
                  continue;
               case DOT:
                  consumeToken();
                  continue;
               case COMMA:
                  names.push(curName);
                  curName = null;
                  consumeToken();
                  continue;
               case SEMI:
                  consumeToken();
               case ERROR:
               case EOF:
               case RC:
                  addr162:
                  names.push(curName);
                  addStmt(new ImportStmt(names,lineno),lineno);
                  return;
               default:
                  break loop0;
            }
         }
         if((ttFlagged & TI_AFTER_EOL) == 0)
         {
            reportError("msg.no.semi.stmt","K66");
         }
         §§goto(addr162);
      }
      
      private function pushLabel(label:Label) : void
      {
         if(labelStack[label.name] != null)
         {
            reportError("msg.dup.label","K61");
         }
         labelStack.push(label);
         labelStack[label.name] = label;
      }
      
      private function variables(firstName:String = null) : void
      {
         var list:IExpr = null;
         var name:* = undefined;
         var init:* = undefined;
         var lineno:int = ts.getLineno();
         do
         {
            if(firstName != null)
            {
               name = firstName;
            }
            else
            {
               mustMatchToken(NAME,"msg.bad.var","k66");
               name = ts.getString();
            }
            if(peekToken() == COLON)
            {
               consumeToken();
               mustMatchToken(NAME,"msg.bad.var","k67");
               consumeToken();
            }
            init = null;
            if(matchToken(ASSIGN))
            {
               init = assignExpr();
            }
            list = exprFactory.createVarExpr(name,init,list);
         }
         while(matchToken(COMMA));
         
         if(list is ExprList)
         {
            list = (list as ExprList).reduce();
         }
         addStmt(list,lineno);
      }
   }
}
