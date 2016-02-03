module TypeChecking where
import AST
import qualified Data.Map as Map
import qualified Lexer as L


checkStmts l  d= eachValid (Just TypeInt) $ map (checkStmnt d) l

eachValid current previous = case current of
    Just a -> current
    Nothing -> error "ERROR! INVALID!"

checkTerm (TTimes t f) d = equalTerm (checkTerm t d) (checkFac f d)
checkTerm (TDiv t f) d = equalTerm (checkTerm t d) (checkFac f d)
checkTerm (TFac t) d = checkFac t d

checkExp (EPlus e t) d =  equalsExp  id  id (checkExp e d)(checkTerm t d)
checkExp (EMinus e t) d = checkExp  (EPlus e $  TFac $ FNeg $ FPar $ ETerm t) d
checkExp (ETerm t) d = checkTerm t d

checkFac (FPar e) d = checkExp e d
checkFac (FNeg e) d = checkFac e d
checkFac (FFLit (p,f)) d = TypeInt
checkFac (FILit (p,i)) d = TypeFloat
checkFac (FSLit (p,i)) d = TypeString
checkFac (FId (p,i)) d = getVarType d i p

checkStmnt d (SAssign (p,i) e)  = Just $ checkAssign (getVarType d i p)  (checkExp e d)
checkStmnt d (SElse e s1 s2)  =   if (checkInt  $ checkExp e d) == TypeInt
    then
        let c1 =checkStmts s1 d
            c2 =checkStmts s2 d
        in case (c1,c2) of
            (Just a1, Just a2)-> Just a1
            _ -> Nothing
    else Nothing
checkStmnt d (SIf e s1)  = if (checkInt $ checkExp e d) == TypeInt then  checkStmts s1 d else Nothing
checkStmnt d (SWhile e s1)  = if (checkInt  $ checkExp e d) == TypeInt then  checkStmts s1 d else Nothing
checkStmnt d (SPrint e )  = Just $ checkExp e d
checkStmnt d (SRead (p,i) )  = Just $ getVarType d i p


termError _ = error "Action invalid for strings"
assignError _ = error "Cannot use float for an int"

getVarType declarations var pos =
    let found = Map.lookup var declarations
    in case found of
        (Just t) -> t
        Nothing -> error $ "Variable '" ++ var ++"' used @"++ (L.getPosString pos) ++" was never declared"

checkInt = equalsExp  termError  assignError TypeInt
equalTerm = equalsExp  termError id
checkAssign = equalsExp id  assignError

equalsExp assignmentAction termAction t1 t2 = let both = (t1,t2) in case both of
  (TypeInt,TypeInt) -> TypeInt
  (TypeInt,TypeFloat) -> assignmentAction TypeFloat
  (TypeFloat,TypeInt) -> TypeFloat
  (TypeFloat,TypeFloat) -> TypeFloat
  (TypeString,TypeString) ->termAction TypeString
  _ -> error ("Incompatible types" ++ (show t1) ++" and " ++(show t2))
