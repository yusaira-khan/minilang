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
    "Declarations:\n"++(show $ prettyDecs d ) ++ "Statements:\n" ++ (prettyStmts $ reverse s)
printMap :: Map.Map k a -> String
printMap _ =""

--prettyDecs :: Declarations -> String
decError :: String -> (Type,AlexPosn) -> (Type,AlexPosn) -> a
decError key (t1,p1) (t2,p2) = error("Variable "++"key has declarations at"++ (show $ getLineNum p1)++"and " ++(show $ getLineNum p2))


createDecMap d = Map.map fst $ Map.fromListWithKey decError $ map unwrapDec d

prettyDecs d = Map.mapWithKey (\s t -> "\t" ++ s ++ " : " ++ (show t) ++ "\n" ) $ createDecMap d

unwrapDec (Dec (pos,str) t) = (str,(t,pos))
prettyStmts _ = ""

