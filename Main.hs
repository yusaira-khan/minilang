import qualified Lexer as L
main::IO ()
main = do
 h<-getContents
 putStrLn $ show $ L.scan h
