
{
module Main (main) where
}

%wrapper "basic"

$digit = 0-9			-- digits
$alpha = [a-zA-Z]		-- alphabetic characters
$graphic    = $printable # $white

@string     = \" ($graphic # \")* \"



tokens :-
       $white+			;
       "#".*            ;
       int         { \s -> TIntType }
       float       { \s -> TFloatType }
       string      { \s -> TStringType }
       $digit+              { \s -> TIntLit (read s) }
       $digit+\.$digit+     { \s -> TFloatLit (read s) }
       $digit+\.            { \s -> TFloatLit (read $ s ++ "0") }
       \.$digit+            { \s -> TFloatLit (read $ "0" ++ s) }
       @string      { \s-> TStringLit (s) }
       var          { \s -> TVar }
       if           { \s -> TIf }
       then         { \s -> TThen }
       else         { \s -> TElse }
       endif        { \s -> TEndif }
       while        { \s -> TWhile }
       do   		{ \s -> TDo }
       done		    { \s -> TDone }
       "="			{ \s -> TEquals }
       ";" 			{ \s -> TSemiColon }
       ":" 			{ \s -> TColon }
       "+" 			{ \s -> TPlus }
       "-" 			{ \s -> TMinus }
       "*" 			{ \s -> TStar }
       "/" 			{ \s -> TSlash }
       "("			{ \s -> TLeftParen }
       ")"			{ \s -> TRightParen }
       print        { \s -> TPrint }
       read         { \s -> TRead }
       $alpha[$alpha $digit \_ ]* { \s -> TId (s) }
{
-- Each action has type :: String -> Token

-- The token type:
data Token =
     TVar
     | TId String
     | TLeftParen
	 | TRightParen
     | TPlus
     | TMinus
     | TStar
     | TSlash
     | TWhile
     | TDo
     | TDone
     | TIf
     | TThen
     | TElse
     | TEndif
     | TColon
     | TSemiColon
     | TEquals
     | TPrint
     | TRead
     | TIntType
	 | TFloatType
	 | TStringType
	 | TIntLit Int
	 | TFloatLit Float
	 | TStringLit String
     | TEOF
     deriving (Eq,Show)

main = do
  s <- getContents
  print (alexScanTokens s)

}