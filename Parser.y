{
module Parser(parse) where
import  Lexer
}


%name parse
%tokentype { Token }
%error { parseError }
%token
       int          {  TIntType _ }
       float        {  TFloatType _ }
       string       {  TStringType _ }
       Integer_Literal      {  TIntLit _ $$ }
       Float_Literal    {  TFloatLit _ $$ }
       String_Literal   {  TStringLit _ $$ }
       var          {  TVar _ }
       if           {  TIf _ }
       then         {  TThen _ }
       else         {  TElse _ }
       endif        {  TEndif _ }
       while        {  TWhile _ }
       do   		{  TDo _ }
       done		    {  TDone _ }
       "="			{  TEquals _ }
       ";" 			{  TSemiColon _ }
       ":" 			{  TColon _ }
       "+" 			{  TPlus _ }
       "-" 			{  TMinus _ }
       "*" 			{  TStar _ }
       "/" 			{  TSlash _ }
       "("			{  TLeftParen _ }
       ")"			{  TRightParen _ }
       print        {  TPrint _ }
       read         {  TRead _ }
       Id           {  TId _ $$ }
       eof          {  TEOF _ }
%left '+' '-'
%left '*' '/'
%left NEG
%%

Program :
        DeclarationList StatementList eof { Program $1 $2}

Type :
     float    { TypeFloat }
     | string      { TypeString }
     | int          { TypeInt }

Declaration:
     var Id ":" Type ";"    { Dec $2 $4 }

DeclarationList :
    Declaration               { [ $1] }
    |  Declaration DeclarationList   { $1 : $2 }

StatementList :
    Statement               { [ $1] }
    |  Statement StatementList   { $1 : $2 }

--types of statements
Statement :
    if  Exp then  StatementList else StatementList endif { SIf $2 $4 $6 }
    | while  Exp do StatementList done                { SWhile $2 $4 }
    | print  Exp  ";"         { SPrint $2 }
    | read   Id  ";"         { SRead $2 }
    | Id "=" Exp ";"         { SAssign $1 $3}

--forced reductions
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
    | Float_Literal       {FFLit $1}
    | String_Literal      {FSLit $1}
    | Integer_Literal         {FILit $1}
    | Id                      { FId $1}

{

parseError :: [Token] -> a
parseError tokenList = let pos = tokenPosn(head(tokenList))
  in
  error ("Invalid \nParse error @ line " ++ show(getLineNum(pos)) ++ " and column " ++ show(getColumnNum(pos)))


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
    = SIf Exp StatementList StatementList
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


}
