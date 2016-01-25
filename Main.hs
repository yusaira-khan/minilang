import qualified Lexer as L
import qualified Parser as P
main::IO ()
main = do
 h<-getContents
 putStrLn "Tokens:"
 putStrLn $ show $ L.scan h
 let parseTree = P.parse (L.scan h)
 putStrLn ("parseTree: " ++ show(parseTree))
 putStrLn "done"