--- nix-shell -p "haskellPackages.ghcWithPackages (pkgs: [pkgs.network])"

import Network
import Network.Socket

localhost = 127 * 2^24 + 1

main = do {
         ios <- socket AF_INET Stream defaultProtocol;
	 bind ios (SockAddrInet (4242::PortNumber) (fromInteger localhost) );
	 listen ios 1;
	 (s, addr) <- Network.Socket.accept ios;
	 putStrLn "accepted connection";
       }
