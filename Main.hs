import qualified Lexer as L
import qualified Parser as P
import qualified Control.Exception as Exc

handler :: Exc.ErrorCall -> IO ()
handler (Exc.ErrorCall msg) = putStrLn $ msg

dismiss :: String -> IO ()
dismiss b = if b /= "" then putStrLn "Valid" else putStrLn "Invalid\n empty progam"

main::IO ()
main = do
 inp<-getContents
 Exc.catch (dismiss.show $P.parse $ L.scan inp) handler
