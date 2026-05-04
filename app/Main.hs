import UDPserver
import FakeInput
import ReadingInput
import Control.Exception (finally)
import Data.ByteString.Char8 (unpack, ByteString)
import Network.Socket (SockAddr, HostName)
import qualified Graphics.UI.GLFW as G

main :: IO ()

main = do
    putStrLn "welcome; launch server or client? [s/c] (defaul:c)"
    input <- getLine
    case input of
        "s" -> basicserver =<< prompt "port" "8000"
        _ -> do
            ip <- prompt "ip" "127.0.0.1"
            port <- prompt "port" "8000"
            basicclient ip port
prompt::String->String->IO String
prompt name default' = do
    putStrLn $ "enter " ++ name ++ " (default:"++ default' ++") "
    input <- getLine
    let res = if input=="" then default' else input
    putStrLn $ name ++ ": " ++ res
    return res
--main = press $ Key 5
-- 5 is F
type MsgHandler = (SockAddr->ByteString->IO())

--basicserver, basicclient :: IO ()
basicserver :: String -> IO ()
basicserver port = openserver port (handlerLogger -+- handlerPresser)
basicclient :: HostName -> String -> IO ()
basicclient ip port = do
    Just client <- openclient ip port
    finally (withWindow $ handleKeyCallback (sendclient client)) $ closeclient client

handlerPresser::MsgHandler
handlerPresser _ msg = func . translateKey $ (read key ::G.Key)
    where
        (key, ':':keysate) = break (== ':' ) $ unpack msg
        func = case read keysate of
            G.KeyState'Pressed -> press
            G.KeyState'Released -> release
            _ -> const $ return ()
(-+-)::MsgHandler->MsgHandler->MsgHandler
h1 -+- h2 = \sndr msg -> h1 sndr msg >> h2 sndr msg