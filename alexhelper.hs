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
		AlexError _ -> throwError "Invalid"
	   	AlexSkip inp' _ -> do
			  put inp'
			  readToken
	   	AlexToken inp' _ tk -> do
			  put inp'
			  return acttk

-- The lexer function to be passed to Happy
lexer::(Token -> P a)->P a
lexer cont = readToken >>= cont



validator = do
    s <- getContents
    go (’\n’,[],s)
    where go inp@(_,_bs,str) =
        case alexScan inp 0 of
            AlexEOF -> putStrLn "Valid"
            AlexError inp' -> putStrLn $ "Invalid" --: " ++ "Lexical error due to character: " ++ show inp'
            AlexSkip inp' _ -> go inp'
            AlexToken inp' _ _ -> go inp'