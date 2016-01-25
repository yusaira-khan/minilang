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

Statement :
    if  Exp then  StatementList else StatementList endif { SIf $2 $4 $6 }
    | while  Exp do StatementList done                { SWhile $2 $4 }
    | print  Id  ";"         { SPrint $2 }
    | read   Id  ";"         { SRead $2 }
    | var Id ":" Type ";"    { SDec $2 $4 }
    | Id "=" Exp ";"         { SAssign $1 $3}

StatementList :
    Statement               { StatementList Empty $1 }
    | StatementList Statement   { StatementList $1 $2 }

Exp :
    Exp "+" Exp                { EPlus $1 $3}
    | Exp "-" Exp                { EMinus $1 $3}
    | Exp "*" Exp                { EStar $1 $3}
    | Exp "/" Exp                { ESlash $1 $3}
    | "(" Exp ")"                 { ExpPar $2 }
--    | "-" Exp  %prec NEG         { ENeg $2}
    | Literal                 {ELit}
    | Id                      { EId}

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
