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
type Id = String
type Integer_Literal = Int
type Float_Literal = Float
type String_Literal = String

prettyProgram :: Program -> String
prettyProgram (Program d s)=
    "Declarations:\n"++(show $ prettyDecs d ) ++ "Statements:\n" ++ (prettyStmts $ reverse s)
printMap :: Map.Map k a -> String
printMap _ =""
--prettyDecs :: Declarations -> String
decError key val1 val2 = error("declaration has 2 values:"++(show val1)++"and " ++(show val2))
prettyDecs d = map unwrapDec d

unwrapDec (Dec str t) = (str,t)
prettyStmts _ = ""

