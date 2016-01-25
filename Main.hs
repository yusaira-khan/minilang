import qualified Lexer as L
import qualified Parser as P
import qualified Control.Exception as Exc

handler :: Exc.ErrorCall -> IO ()
handler (Exc.ErrorCall msg) = putStrLn $ msg

dismiss :: a -> IO ()
dismiss _ = return ()

main::IO ()
main = do
 inp<-getContents
 Exc.catch (dismiss $ P.parse $ L.scan inp) handler
 putStrLn "Valid"