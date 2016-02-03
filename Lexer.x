{
module Lexer (Token(..),scan, getLineNum,getColumnNum,tokenPosn,AlexPosn,getPosString) where
}

%wrapper "posn"

$digit = 0-9			-- digits
$nonzero = 1-9
$alpha = [a-zA-Z]		-- alphabetic characters
$graphic    = [$digit  $alpha  [\  ! \? \. \,]]

@string     = \" ($graphic # \")* \"



tokens :-
       $white+			;
       "#".*            ;
--types separate from literals
       int         { \p s -> TIntType p }
       float       { \p s -> TFloatType p }
       string      { \p s -> TStringType p }

--precautions so that multiple zeroes don't count as a number
       $nonzero $digit*        { \p s -> TIntLit (p, (read s) )}
       "0"        { \p s -> TIntLit (p,read s) }
       $nonzero $digit*\.$digit+     { \p s -> TFloatLit (p,(read s)) }
       $nonzero $digit*\.            { \p s -> TFloatLit (p, (read $ s ++ "0")) }
       "0"?\.$digit+            { \p s -> TFloatLit (p,(read $ "0" ++ s)) }

--acceptible characters in string listed above
       @string      { \p s-> TStringLit  (p,s) }

--keywords
       var          { \p s -> TVar p }
       if           { \p s -> TIf p }
       then         { \p s -> TThen p }
       else         { \p s -> TElse p }
       endif        { \p s -> TEndif p }
       while        { \p s -> TWhile p }
       do   		{ \p s -> TDo p }
       done		    { \p s -> TDone p }
       "="			{ \p s -> TEquals p }
       ";" 			{ \p s -> TSemiColon  p}
-- operators
       ":" 			{ \p s -> TColon p }
       "+" 			{ \p s -> TPlus p }
       "-" 			{ \p s -> TMinus p }
       "*" 			{ \p s -> TStar p }
       "/" 			{ \p s -> TSlash p }
       "("			{ \p s -> TLeftParen p }
       ")"			{ \p s -> TRightParen p }
-- IO
       print        { \p s -> TPrint p }
       read         { \p s -> TRead p }
--var
       $alpha[$alpha $digit \_ ]* { \p s -> TId (p,s) }
{
-- Each action has type :: String -> Token

-- The token type:
data Token =
     TVar AlexPosn
     | TId (AlexPosn,String)
     | TLeftParen AlexPosn
	 | TRightParen AlexPosn
     | TPlus AlexPosn
     | TMinus AlexPosn
     | TStar AlexPosn
     | TSlash AlexPosn
     | TWhile AlexPosn
     | TDo AlexPosn
     | TDone AlexPosn
     | TIf AlexPosn
     | TThen AlexPosn
     | TElse AlexPosn
     | TEndif AlexPosn
     | TColon AlexPosn
     | TSemiColon AlexPosn
     | TEquals AlexPosn
     | TPrint AlexPosn
     | TRead AlexPosn
     | TIntType AlexPosn
	 | TFloatType AlexPosn
	 | TStringType AlexPosn
	 | TIntLit (AlexPosn,Int)
	 | TFloatLit (AlexPosn,Float)
	 | TStringLit (AlexPosn,String)
     | TEOF AlexPosn
     deriving (Eq,Show)


--getting position information for error messages
tokenPosn (TVar p) = p
tokenPosn (TId (p,s)) = p
tokenPosn (TLeftParen p) = p
tokenPosn (TRightParen p) = p
tokenPosn (TPlus p) = p
tokenPosn (TMinus p) = p
tokenPosn (TStar p) = p
tokenPosn (TSlash p) = p
tokenPosn (TWhile p) = p
tokenPosn (TDo p) = p
tokenPosn (TDone p) = p
tokenPosn (TIf p) = p
tokenPosn (TElse p) = p
tokenPosn (TThen p) = p
tokenPosn (TEndif p) = p
tokenPosn (TColon p) = p
tokenPosn (TSemiColon p) = p
tokenPosn (TEquals p) = p
tokenPosn (TPrint p) = p
tokenPosn (TRead p) = p
tokenPosn (TIntType p) = p
tokenPosn (TFloatType p) = p
tokenPosn (TStringType p) = p
tokenPosn (TIntLit (p,i)) = p
tokenPosn (TStringLit (p,str)) = p
tokenPosn (TFloatLit (p,c)) = p
tokenPosn (TEOF p) = p

getLineNum :: AlexPosn -> Int
getLineNum (AlexPn offset lineNum colNum) = lineNum

getColumnNum :: AlexPosn -> Int
getColumnNum (AlexPn offset lineNum colNum) = colNum

getPosString pos = "line " ++ show (getLineNum  pos) ++ " and column " ++ show ( getColumnNum  pos)
-- Action to read a token
scan str = go (alexStartPos,'\n',[],str)
    where go inp@(pos,_,_,str) = case alexScan inp 0 of
            AlexEOF -> [TEOF pos]
            AlexError inp' -> error ( "Invalid\nLexical error @ " ++ getPosString pos )
            AlexSkip inp' _ -> go inp'
            AlexToken inp' len act -> act pos (take len str) : go inp'

}    
