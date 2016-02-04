{
module Parser(parse,prettyProgram,createDecMap,Program(..),symbolTable) where
import  Lexer
import AST
}


%name parse
%tokentype { Token }
%error { parseError }
%token
       int          {  TIntType _ }
       float        {  TFloatType _ }
       string       {  TStringType _ }
       Integer_Literal      {  TIntLit  $$ }
       Float_Literal    {  TFloatLit  $$ }
       String_Literal   {  TStringLit  $$ }
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
       Id           {  TId  $$ }
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
   -- Declaration               { [ $1] }
   {- empty -}{ [] }
    | DeclarationList Declaration    { $2 : $1 }

StatementList :
   -- Statement               { [ $1] }
      {- empty -}{ [] }
    | StatementList Statement    { $2 : $1 }

--types of statements
Statement :
    if  Exp then  StatementList endif { SIf $2 $4 }
    | if  Exp then  StatementList else StatementList endif { SElse $2 $4 $6 }
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


}
