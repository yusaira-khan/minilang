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
      in do
      putStrLn(show $ T.checkStmts stmts symtable)
      writePretty fname symtable stmts
      writeC fname symtable stmts


getNoExt fname = Text.unpack $ Text.dropEnd 3 $ Text.pack fname

writePretty fname dec stmts= do
    let
        t = (getNoExt fname)++ "pretty.min"
        s = (getNoExt fname)++ "symbol.txt"
    writeFile t $ P.prettyProgram dec stmts
    writeFile s $ P.symbolTable dec


cStub= "#include <stdio.h>\n\
\#include <stdlib.h>\n\
\#include <string.h>\n\
\\n\
\char* add_s(char *s1, char *s2){\n\
\    size_t len1 = strlen(s1);\n\
\    size_t len2 = strlen(s2);\n\
\    char *result = malloc(len1+len2+1);//+1 for the zero-terminator\n\
\    memcpy(result, s1, len1);\n\
\    memcpy(result+len1, s2, len2+1);//+1 to copy the null-terminator\n\
\    return result;\n\
\}\n\
\\n\
\char* neg_s(char *s1){\n\
\    size_t len1 = strlen(s1);\n\
\    int c, i, j;\n\
\    char *result = malloc(len1+1);\n\
\    for (i = 0, j = len1-1; i < len1; i++, j--){\n\
\       result[j] = s1[i];\n\
\    }\n\
\    result[len1]='\\0';\n\
\    return result;\n\
\}\n\
\\n\
\int main(){\n"

cEnd = "  return 0;\n}\n"
writeC fname dec stmts= do
    let t = (getNoExt fname)++ "c"
        gen = G.generateBlock dec "  " stmts
        d = G.genearateDecs dec
        code = cStub++d++gen ++ cEnd
    writeFile t code





