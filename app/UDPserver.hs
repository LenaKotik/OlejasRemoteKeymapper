module UDPserver (
    openserver,
    openclient,
    sendclient,
    closeclient,
    handlerLogger
) where

import Prelude hiding (putStrLn)
import Network.Socket
import Network.Socket.Address (recvFrom, sendAllTo)
import Data.ByteString.Char8 (putStrLn, ByteString)
import System.IO (hPutStrLn, stderr, stdout)
import Control.Monad
import qualified Data.Map as M


safeHead::[a] -> Maybe a
safeHead [] = Nothing
safeHead (x:_) = Just x


withUDPSocket::Maybe HostName -> Maybe ServiceName -> (AddrInfo -> Socket -> IO a) ->  IO (Maybe a)
withUDPSocket h s f = withSocketsDo $ do
    minfo <- safeHead <$> getAddrInfo (Just addr) h s
    case minfo of
        Nothing -> Nothing <$ hPutStrLn stderr ("Could not get address info: " ++ show addr  ++ show h ++ show s)
        Just info -> Just <$> (f info =<< openSocket info)
    where
        addr = defaultHints {
            addrFlags=[AI_PASSIVE],
            addrSocketType = Datagram
            }


-- SERVER SIDE
openserver::String -> (SockAddr -> ByteString -> IO ()) -> IO ()
openserver port handler = void.withUDPSocket Nothing (Just port) $ \info sock -> do
    bind sock $ addrAddress info
    hPutStrLn stdout $ "Listening on " ++ show (addrAddress info)
    processMessages sock M.empty
    where
        processMessages sock clients = do
            (msg, sndr) <- recvFrom sock 1024
            {-
            case M.lookup sndr clients of
                Nothing -> do
                    hPutStrLn stdout $ "Connection request from: " ++ show sndr ++ "\naccept? [y/n] (default:n)"
                    input <- getLine
                    processMessages sock $ M.insert sndr (input=="y") clients
                Just False -> processMessages sock clients
                Just True -> do
            -}
            handler sndr msg
            processMessages sock clients

handlerLogger::SockAddr -> ByteString -> IO ()
handlerLogger = const putStrLn

-- CLIENT SIDE
newtype ClientSocket = CS (AddrInfo, Socket)

openclient::HostName->String->IO (Maybe ClientSocket)
openclient host port = withUDPSocket (Just host) (Just port) $ curry (return.CS)

sendclient::ClientSocket->ByteString->IO()
sendclient (CS (i, s)) msg = sendAllTo s msg $ addrAddress i

closeclient::ClientSocket->IO()
closeclient (CS (_, s)) = close' s
