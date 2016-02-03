module TypeChecking where
import AST
import qualified Data.Map as Map



--prettyDecs d = Map.foldrWithKey  (\s t p -> p ++ "\t" ++ s ++ " : " ++ (show t) ++ "\n" )  "" $ createDecMap d


checkStmts l  d= eachValid (Just TypeInt) $ map checkStmnt l d

eachValid current previous = case current of
    Just a -> current
    Nothing -> "ERROR! INVALID!"

checkTerm (TTimes t f) d = equalTerm (checkTerm t) (checkFac f)
checkTerm (TDiv t f) d = equalTerm (checkTerm t) (checkFac f)
checkTerm (TFac t) d = checkFac t

checkExp (EPlus e t) d =  equalsExp  emptyAction  emptyAction (checkExp e)(checkTerm t)
checkExp (EMinus e t) d = checkExp $ EPlus e $  TFac $ FNeg $ FPar $ ETerm t
checkExp (ETerm t) d = checkTerm t

checkFac (FPar e) d = checkExp e
checkFac (FNeg e) d = checkFac e
checkFac (FFLit (p,f)) d = TypeInt
checkFac (FILit (p,i)) d = TypeFloat
checkFac (FSLit (p,i)) d = TypeString
checkFac (FId (p,i)) d = Map.lookup(i,d)

checkStmnt (SAssign (p,i) e) d = Just $ checkAssign (Map.lookup i d)  (checkExp e)
checkStmnt (SElse e s1 s2) d =   if (checkInt e) == TypeInt then let c1 =checkStmts s1
    c2 =checkStmts s2
  in case (c1,c2) of
  (Just a1, Just a2)-> Just a1
  _ -> Nothing
checkStmnt (SIf e s1) d = if (checkInt e) == TypeInt then  checkStmts s1 else Nothing
checkStmnt (SWhile e s1) d = if (checkInt e) == TypeInt then  checkStmts s1 else Nothing
checkStmnt (SPrint e ) d = Just checkExp e
checkStmnt (SRead (p,i) ) d = Map.lookup i d

checkType t = (t == TypeInt) or (t == TypeFloat)  or (t == TypeString)

termError _ -> error "Action invalid for strings"
assignError _ -> error "Cannot use float for an int"
emptyAction e -> e

checkInt = equalsExp  termError  assignError TypeInt
equalTerm = equalsExp  termError  emptyAction
checkAssign = equalsExp emptyAction  assignError

equalsExp assignmentAction termAction t1 t2 = let both = (t1,t2) in case both of
  (TypeInt,TypeInt) -> TypeInt
  (TypeInt,TypeFloat) -> assignmentAction ()
  (TypeFloat,TypeInt) -> TypeFloat
  (TypeFloat,TypeFloat) -> TypeFloat
  (TypeString,TypeString) ->termAction TypeString
  _ -> error "Incompatible types" ++ show t1 ++" and " ++show t2
