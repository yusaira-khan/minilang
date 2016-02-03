module TypeChecking where
import AST
import qualified Data.Map as Map



--prettyDecs d = Map.foldrWithKey  (\s t p -> p ++ "\t" ++ s ++ " : " ++ (show t) ++ "\n" )  "" $ createDecMap d


checkStmts l  d= foldr (\s p -> s) TypeInt $ map checkStmnt l d


checkTerm (TTimes t f) d = let ct = checkTerm t in if (checkFac f) == ct then ct else error ""
checkTerm (TDiv t f) d = let ct = checkTerm t in if (checkFac f) == ct then ct else error ""
checkTerm (TFac t) d = checkFac t

checkExp (EPlus e t) d =  let ct = checkTerm t in if (checkExp e ) == ct then e else error ""
checkExp (EMinus e t) d = checkExp $ EPlus e $  TFac $ FNeg $ FPar $ ETerm t
checkExp (ETerm t) d = checkTerm t

checkFac (FPar e) d = checkExp e
checkFac (FNeg e) d = checkFac e
checkFac (FFLit (p,f)) d = TypeInt
checkFac (FILit (p,i)) d = TypeFloat
checkFac (FSLit (p,i)) d = TypeString
checkFac (FId (p,i)) d = Map.lookup(i,d)

checkStmnt (SAssign (p,i) e) d = Map.lookup(i,d) == checkExp e
checkStmnt (SElse e s1 s2) d = if (checkExp e) == TypeInt then if checkType $ checkStmts s1 then checkType $ checkStmts s2 else error "" else error ""
checkStmnt (SIf e s1) d = if (checkExp e) == TypeInt then checkType $ checkStmts s1 else error ""
checkStmnt (SWhile e s1) d = if (checkExp e) == TypeInt then checkType $ checkStmts s1 else error ""
checkStmnt (SPrint e ) d = let c=checkExp e in checkType c
checkStmnt (SRead (p,i) ) d = let c=Map.lookup(i,d) in checkType c

checkType t = (t == TypeInt) or (t == TypeFloat)  or (t == TypeString)

