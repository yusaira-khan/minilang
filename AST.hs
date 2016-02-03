module AST where
import qualified Data.Map as Map
import  Lexer
data Program
    = Program DeclarationList StatementList
      deriving (Show, Eq)

data Declaration
    = Dec Id Type
      deriving (Show, Eq)

data Type =
    TypeInt
    | TypeFloat
    | TypeString
    deriving (Show, Eq)

data Statement
    = SIf Exp StatementList
    | SElse Exp StatementList StatementList
    | SWhile Exp StatementList
    | SPrint Exp
    | SRead Id
    | SAssign Id Exp
    deriving (Show, Eq)

data Exp
    = EPlus Exp Term
    | EMinus Exp Term
    | ETerm Term
    deriving (Show, Eq)

data Term
    = TTimes Term Factor
    | TDiv Term Factor
    | TFac Factor
    deriving (Show, Eq)

data Factor
    = FPar Exp
    | FNeg Factor
    | FFLit Float_Literal
    | FILit Integer_Literal
    | FSLit String_Literal
    | FId Id
    deriving (Show, Eq)

type StatementList = [Statement]
type DeclarationList = [Declaration]
type Id = (AlexPosn,String)
type Integer_Literal = (AlexPosn,Int)
type Float_Literal = (AlexPosn,Float)
type String_Literal = (AlexPosn,String)

prettyProgram :: Program -> String
prettyProgram (Program d s)=
    "Declarations:\n"++( prettyDecs d ) ++ "Statements:\n" ++ ( prettyStmts s)

--prettyDecs :: Declarations -> String
decError :: String -> (Type,AlexPosn) -> (Type,AlexPosn) -> a
decError key (t1,p1) (t2,p2) = error("Variable "++"key has declarations at"++ (getPosString p1)++"and " ++(getPosString p2))


createDecMap d = Map.map fst $ Map.fromListWithKey decError $ map unwrapDec d

prettyDecs d = Map.foldrWithKey  (\s t p -> p ++ "\t" ++ s ++ " : " ++ (show t) ++ "\n" )  "" $ createDecMap d

unwrapDec (Dec (pos,str) t) = (str,(t,pos))

prettyStmts l = foldr (\s p -> p ++ "\t" ++ s++ "\n") "" $ map stmtTree l

printTerm (TTimes e f) = " ("++(printTerm e ) ++" * " ++(printFac f) ++") "
printTerm (TDiv e f) = " ("++(printTerm e ) ++" / " ++(printFac f) ++") " --FIXME
printTerm (TFac t) = printFac t

printExp (EPlus e t) = " ("++(printExp e ) ++" + " ++(printTerm t) ++") "
printExp (EMinus e t) = printExp $ EPlus e $  TFac $ FNeg $ FPar $ ETerm t
printExp (ETerm t) = printTerm t

printFac (FPar e) = " ("++(printExp e)++") "
printFac (FNeg e) = "-" ++(printFac e)
printFac (FFLit (p,f)) = show f ++ "\t @ " ++ getPosString p
printFac (FILit (p,i)) = show i  ++ "\t @ " ++ getPosString p
printFac (FSLit (p,i)) = i  ++ "\t @ " ++ getPosString p
printFac (FId (p,i)) = i  ++ "\t @ " ++ getPosString p

stmtTree (SAssign (p,i) e) = i ++ "\t" ++ (printExp e)
stmtTree (SElse e s1 s2) = "if\n"++(printExp e)++ (prettyStmts s1)++"else\n"++(prettyStmts s2)
stmtTree (SIf e s1) = "if\n"++(printExp e)++ (prettyStmts s1)
stmtTree (SWhile e s1) = "while\t"++(printExp e)++ "\n"++(prettyStmts s1)
stmtTree (SPrint e ) = "print\t"++(printExp e)
stmtTree (SRead (p,i) ) = "read\t"++i  ++ "\t @ " ++ getPosString p


