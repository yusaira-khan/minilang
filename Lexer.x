{
module Lexer (Token(..),P,evalP,lexer,validator) where
import Control.Monad.State
import Control.Monad.Error
import Data.Word
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

-- The functions that must be provided to Alex's basic interface
type AlexInput = [Word8]
alexGetByte :: AlexInput -> Maybe (Word8,AlexInput)
alexGetByte (b:bs) = Just (b,bs)
alexGetByte []    = Nothing

alexInputPrevChar :: AlexInput -> Char
alexInputPrevChar = undefined


-- Our Parser monad
type P a = StateT AlexInput (Either String) a

evalP::P a -> AlexInput -> Either String a
evalP = evalStateT

-- Action to read a token
readToken::P Token
readToken = do
	  s <- get  
	  case alexScan s 0 of
      	        AlexEOF -> return TEOF
		AlexError _ -> throwError "!Lexical error"
	   	AlexSkip inp' _ -> do	
			  put inp'
			  readToken
	   	AlexToken inp' _ tk -> do 
			  put inp'
			  return tk

-- The lexer function to be passed to Happy
lexer::(Token -> P a)->P a
lexer cont = readToken >>= cont

validator =
}    
