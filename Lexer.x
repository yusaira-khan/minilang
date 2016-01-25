{
module Lexer (Token(..),scan,validate) where
import Control.Monad.State
}

%wrapper "basic"

$digit = 0-9			-- digits
$alpha = [a-zA-Z]		-- alphabetic characters
$graphic    = [$digit  $alpha  [\  ! \? \. \,]]

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


-- Action to read a token
scan str = go ('\n',[],str)
    where go inp@(_,_bs,str) = case alexScan inp 0 of
            AlexEOF -> [TEOF]
            AlexError inp' -> error "Invalid"
            AlexSkip inp' _ -> go inp'
            AlexToken inp' len act -> act (take len str) : go inp'



validate = do
    s <- getContents
    go ('\n',[],s)
    where go inp@(_,_bs,str) = case alexScan inp 0 of
            AlexEOF -> putStrLn "Valid"
            AlexError inp' -> putStrLn $ "Invalid"
            AlexSkip inp' _ -> go inp'
            AlexToken inp' _ _ -> go inp'
}    
