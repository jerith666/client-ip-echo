--- nix-shell -p "haskellPackages.ghcWithPackages (pkgs: [pkgs.network])"

--- import Network
import System.Environment
import Network.Socket hiding (send, sendTo, recv, recvFrom)
import Network.Socket.ByteString
import qualified Data.ByteString.Char8 as C
import Data.Bits
import Data.Word

--- args <- getArgs

main = do args <- getArgs
          case args of
               []      -> usage
               (p:[])  -> echoPortStr p
               (x:y:_) -> usage

usage = putStrLn "usage: client-ip-echo <port>"

echoPortStr portStr = do case (reads portStr) of
                              [] -> usage
                              [(p, _)] -> echoPort p

echoPort :: Integer -> IO ()
echoPort p = do ios <- socket AF_INET Stream defaultProtocol
                bind ios (SockAddrInet (fromInteger p) iNADDR_ANY )
                listen ios 1
                (s, addr) <- accept ios
                let addrs = hostaddr addr
                putStrLn ("accepted connection from " ++ addrs)
                send s (C.pack addrs)
                return ()

shiftmask :: Word32 -> Int -> Integer -> Integer
shiftmask x y z = (.&.) (shiftR (toInteger x) y) z

hostaddr :: SockAddr -> String
hostaddr (SockAddrInet _ hAddr) =
  let 
      w1 = shiftmask hAddr 0  (2^8-1)
      w2 = shiftmask hAddr 8  (2^8-1)
      w3 = shiftmask hAddr 16 (2^8-1)
      w4 = shiftmask hAddr 24 (2^8-1)
  in (show w1) ++ "." ++ (show w2) ++ "." ++ (show w3) ++ "." ++ (show w4)
hostaddr _ = "unsupported address type"
