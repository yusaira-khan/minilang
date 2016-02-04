module Main(main) where
import qualified Lexer as L
import qualified Parser as P
import qualified TypeChecking as T
import qualified Generator as G
import qualified Control.Exception as Exc
import qualified System.Environment as Env
import qualified Data.Text as Text
import System.IO

handler :: Exc.ErrorCall -> IO ()
handler (Exc.ErrorCall msg) = putStrLn $ msg

--checkValidity :: String -> IO ()
checkValidity parsed = let b = show parsed in if b /= "" then putStrLn $ b else putStrLn "Invalid\n empty progam"

main::IO ()
main = do
 ar <-  Env.getArgs
 let fname = head ar
 h <- openFile fname ReadMode
 inp <- hGetContents h
 Exc.catch (compile fname inp) handler

compile fname inp = case P.parse $ L.scan inp of
    P.Program dec stmts -> let
        symtable = P.createDecMap dec
      in writePretty fname symtable stmts


getNoExt fname = Text.unpack $ Text.dropEnd 3 $ Text.pack fname

writePretty fname dec stmts= do
    let t = (getNoExt fname)++ "pretty.min"
    writeFile t $ P.prettyProgram dec stmts





