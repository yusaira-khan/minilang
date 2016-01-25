module Lexer (Token(..),P,evalP,lexer,validator) where
import Control.Monad.State
import Control.Monad.Error
import Data.Word

--2nd part
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
	 | TIntLiteral Int
	 | TFloatLiteral Float
	 | TStringLiteral String
     | TEOF
     deriving (Eq,Show)


scan str = go ("\n",[],str)
    where go inp@(_,_bs,str) = case alexScan inp 0 of
            AlexEOF -> [TEOF]
            AlexError inp' -> throwError "Invalid"
            AlexSkip inp' _ -> go inp'
            AlexToken inp' _ _ -> act $ take len str : go inp'

validator = do
    s <- getContents
    go ("\n",[],s)
    where go inp@(_,_bs,str) = case alexScan inp 0 of
            AlexEOF -> putStrLn "Valid"
            AlexError inp' -> putStrLn $ "Invalid"
            AlexSkip inp' _ -> go inp'
            AlexToken inp' _ _ -> go inp'