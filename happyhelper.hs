module Parser(parse) where
import qualified Lexer as L
import Control.Monad.Error

parseError :: [Token] -> a
parseError _ = error "Parse error"


data Program
    = Program StatementList
      deriving (Show, Eq)

data Type =
    TypeInt
    | TypeFloat
    | TypeString
    deriving (Show, Eq)

data Literal =
     FloatLit Float
     | StringLit String
     |  IntLit Int
     deriving (Show, Eq)

data Statement
    = SIf Exp StatementList StatementList
    | SWhile Exp StatementList
    | SPrint Id
    | SRead Id
    | SAssign Id Exp
    | SDec Id Type
    deriving (Show, Eq)

data StatementList
    = StatementList Statement
    | Empty
    deriving (Show, Eq)


data Exp
    = EPlus Exp Exp
    | EMinus Exp Exp
    | EStar Exp Exp
    | ESlash Exp Exp
    | ENeg Exp
    | EPar Exp
    | ELit
    | EId
    deriving (Show, Eq)


type Id = String
--type Integer_Literal = Int
--type Float_Literal = Float
--type String_Literal = String

main = do
  inStr <- getContents
  let parseTree = parse (alexScanTokens inStr)
  putStrLn ("parseTree: " ++ show(parseTree))
  print "done"
}