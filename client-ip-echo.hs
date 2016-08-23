--- nix-shell -p "haskellPackages.ghcWithPackages (pkgs: [pkgs.network])"

--- import Network
import Network.Socket
import Data.Bits
import Data.Word

main = do {
         ios <- socket AF_INET Stream defaultProtocol;
	 bind ios (SockAddrInet (4242::PortNumber) iNADDR_ANY );
	 listen ios 1;
	 (s, addr) <- accept ios;
	 putStrLn ("accepted connection from " ++ (hostaddr addr));
       }

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
