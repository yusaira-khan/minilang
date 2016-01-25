{
module Parser(parse) where
import  Lexer
}


%name parse
%tokentype { Token }
%error { parseError }
%token
       int          {  TIntType }
       float        {  TFloatType }
       string       {  TStringType }
       int_lit      {  TIntLit $$ }
       float_lit    {  TFloatLit $$ }
       string_lit   {  TStringLit $$ }
       var          {  TVar }
       if           {  TIf }
       then         {  TThen }
       else         {  TElse }
       endif        {  TEndif }
       while        {  TWhile }
       do   		{  TDo }
       done		    {  TDone }
       "="			{  TEquals }
       ";" 			{  TSemiColon }
       ":" 			{  TColon }
       "+" 			{  TPlus }
       "-" 			{  TMinus }
       "*" 			{  TStar }
       "/" 			{  TSlash }
       "("			{  TLeftParen }
       ")"			{  TRightParen }
       print        {  TPrint }
       read         {  TRead }
       Id           {  TId $$ }
       eof          {  TEOF }
%left '+' '-'
%left '*' '/'
%left NEG
%%

Program :
        StatementList eof { Program $1}

Type :
     float    { TypeFloat }
     | string      { TypeString }
     | int          { TypeInt }
Literal:
     float_lit   { FloatLit }
     | string_lit      { StringLit }
     | int_lit          { IntLit }


StatementList :
    Statement               { [ $1] }
    | StatementList Statement   { $2 : $1 }
Statement :
    if  Exp then  StatementList else StatementList endif { SIf $2 $4 $6 }
    | while  Exp do StatementList done                { SWhile $2 $4 }
    | print  Id  ";"         { SPrint $2 }
    | read   Id  ";"         { SRead $2 }
    | var Id ":" Type ";"    { SDec $2 $4 }
    | Id "=" Exp ";"         { SAssign $1 $3}


Exp :
    Exp "+" Term                { EPlus $1 $3}
    | Exp "-" Term              { EMinus $1 $3}
    | Term {ETerm $1}
Term :
    Term "*" Factor                { TTimes $1 $3}
    | Term "/" Factor                { TDiv $1 $3}
    | Factor {TFac $1}

Factor :
    "(" Exp ")"         { FPar $2 }
    | "-" Factor          { FNeg $2}
    | Literal                 {FLit}
    | Id                      { FId}

{

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

--data StatementList
--  = StatementList Statement
-- | Empty
--deriving (Show, Eq)


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
    | FLit
    | FId
    deriving (Show, Eq)

type StatementList = [Statement]
type Id = String
--type Integer_Literal = Int
--type Float_Literal = Float
--type String_Literal = String

main = do
  inStr <- getContents
  let parseTree = parse (scan inStr)
  putStrLn ("parseTree: " ++ show(parseTree))
  print "done"
}
