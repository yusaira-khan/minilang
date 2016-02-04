module TypeChecking where
import AST
import Debug.Trace
import qualified Data.Map as Map
import qualified Lexer as L


checkStmts l  d= foldr eachValid "" $ map (checkStmnt d) l

eachValid current previous = current

checkTerm (TTimes t f) d = (equalTerm (checkTerm t d) (checkFac f d))
checkTerm (TDiv t f) d = equalTerm (checkTerm t d) (checkFac f d)
checkTerm (TFac t) d =  (checkFac t d)

checkExp (EPlus e t) d =  (equalTerm (checkExp e d)(checkTerm t d))
checkExp (EMinus e t) d = checkExp  (EPlus e $  TFac $ FNeg $ FPar $ ETerm t) d
checkExp (ETerm t) d =  (checkTerm t d)

checkFac (FPar e) d = checkExp e d
checkFac (FNeg e) d = checkFac e d
checkFac (FFLit (p,f)) d = TypeInt
checkFac (FILit (p,i)) d = TypeFloat
checkFac (FSLit (p,i)) d = TypeString
checkFac (FId (p,i)) d = getVarType d i p

checkStmnt d (SAssign (p,i) e)  = show $ checkAssign (getVarType d i p)  (checkExp e d)
checkStmnt d (SElse e s1 s2)  =   if (checkInt  $ checkExp e d) == TypeInt
    then
        let c1 =checkStmts s1 d
            c2 =checkStmts s2 d
        in case (c1,c2) of
            _ -> show $ c1
    else error("Can only have ints in if statment")
checkStmnt d (SIf e s1)  = if (checkInt $ checkExp e d) == TypeInt then show $ checkStmts s1 d else error("Can only have ints in if statment")
checkStmnt d (SWhile e s1)  = if (checkInt  $ checkExp e d) == TypeInt then show $ checkStmts s1 d else error("Can only have ints in if statment")
checkStmnt d (SPrint e )  = let z = checkExp e d in show z
checkStmnt d (SRead (p,i) )  =  show $ getVarType d i p


termError x = error("Action invalid for " ++ (show x))
assignError x = error ("Cannot use "++ (show x)++"for an int")

getVarType declarations var pos =
    let found = Map.lookup var declarations
    in case found of
        (Just t) -> t
        Nothing -> error $ "Variable '" ++ var ++"' used @"++ (L.getPosString pos) ++" was never declared"

checkInt = equalsExp   TypeInt
equalTerm x y=  let
    d = (equalsExp x y)
    z= trace (show d) d
  in case  z of
    TypeString -> error ("Cannot perform multiplication on " ++ (show z))
    _ -> z
checkAssign x y= case (x,y) of
    (TypeInt,TypeFloat) ->error("Cannot assign " ++(show x)++ "to "++(show y))
    _ -> equalsExp x y


equalsExp  t1 t2 = let both = (t1,t2) in case both of
  (TypeInt,TypeInt) -> TypeInt
  (TypeInt,TypeFloat) -> TypeFloat
  (TypeFloat,TypeInt) -> TypeFloat
  (TypeFloat,TypeFloat) -> TypeFloat
  (TypeString,TypeString) -> TypeString
  _ -> error ("Incompatible types" ++ (show t1) ++" and " ++(show t2))
