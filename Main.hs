module Main(main) where
import qualified Lexer as L
import qualified Parser as P
import qualified Control.Exception as Exc
import qualified System.Environment as Env
import System.IO

handler :: Exc.ErrorCall -> IO ()
handler (Exc.ErrorCall msg) = putStrLn $ msg

--checkValidity :: String -> IO ()
checkValidity parsed = let b = show parsed in if b /= "" then putStrLn $ P.prettyProgram parsed else putStrLn "Invalid\n empty progam"

main::IO ()
main = do
 ar <-  Env.getArgs
 h <- openFile (head ar) ReadMode
 inp <- hGetContents h
 Exc.catch (checkValidity $ P.parse $ L.scan inp) handler




