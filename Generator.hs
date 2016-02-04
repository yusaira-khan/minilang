module Generator(generateBlock,genearateDecs) where
import AST
import qualified TypeChecking as T
import qualified Data.Map as Map

generateBlock dec indent l = foldr (\s p -> p ++ indent ++ s++ "\n") "" $ map (generateStmt dec indent ) l

generateTerm litType (TTimes e f) = (generateTerm litType e ) ++" * " ++(generateFac litType f)
generateTerm litType (TDiv e f) = (generateTerm litType e ) ++" / " ++(generateFac litType f)
generateTerm litType (TFac t) = generateFac litType t

generateExp litType (EPlus e t) = case litType of
    TypeString->" add_s("++(generateExp litType e ) ++" , " ++(generateTerm litType t)++") "
    _->(generateExp litType e ) ++" + " ++(generateTerm litType t)
generateExp litType (EMinus e t) = generateExp litType $ EPlus e $ TFac $ FNeg $ FPar $ ETerm t
generateExp litType (ETerm t) = generateTerm litType t

generateFac litType (FPar e) = " ("++ generateExp litType e ++") "
generateFac litType (FNeg e) = case litType of
    TypeString->" neg_s("++(generateFac litType e ) ++") "
    _->"-" ++(generateFac litType e)
generateFac litType (FFLit (p,f)) = show f
generateFac litType (FILit (p,i)) = show i
generateFac litType (FSLit (p,i)) = i
generateFac litType (FId (p,i)) = i


generateStmt dec indent (SAssign (p,i) e) = i ++ " = " ++ (generateExp (T.getVarType dec i p) e)++";"
generateStmt dec indent (SElse e s1 s2) = let
    i1 = "if ("++(generateExp TypeInt e)++") {\n"
    i2 = (generateBlock dec (indent++"  ") s1)++indent ++"} else {\n"
    i3 = (generateBlock dec (indent++"  ") s2)++indent ++ "}"
  in i1++i2++i3
generateStmt dec indent (SIf e s1) = let
    i1 = "if ("++(generateExp TypeInt e)++") {\n"
    i2 = (generateBlock dec (indent++"  ") s1)++indent ++"}"
  in i1++i2
generateStmt dec indent (SWhile e s1) = let
    i1="while ("++(generateExp TypeInt e)++") {\n"
    i2 =(generateBlock dec (indent++"  ") s1)++indent ++"}"
  in i1++i2
generateStmt dec indent (SPrint e) = let
    t= T.checkExp e dec
    s= generateExp t e
    p=getPrintFunction t
  in p++s++" );"
generateStmt dec indent (SRead (p,i) ) = let
    t = (T.getVarType dec i p)
    f=getReadFunction t
  in f++i++");"

getPrintFunction TypeInt = "printf( \"%d\\n\","
getPrintFunction TypeString = "printf( \"%s\\n\","
getPrintFunction TypeFloat = "printf( \"%f\\n\","

getReadFunction TypeInt = "scanf( \"%d\",&"
getReadFunction TypeString = "scanf( \"%s\","
getReadFunction TypeFloat = "scanf( \"%f\",&"

genearateDecs d = Map.foldrWithKey  (\s t p -> p++"  "++ (getCType t) ++ s ++ ";\n" )  "" d

getCType TypeInt = "int "
getCType TypeFloat = "float "
getCType TypeString = "char* "