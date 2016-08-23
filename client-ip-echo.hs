--- nix-shell -p "haskellPackages.ghcWithPackages (pkgs: [pkgs.network])"

import Network
import Network.Socket

--- we don't have 2.6.3.0 :(
--- localhost = tupleToHostAddress (fromInteger 127,
---                                fromInteger 0,
---				fromInteger 0,
---				fromInteger 1)
--- localhost = ntohl (fromInteger 127 * 2^24 + 1)
localhost = 127 + 1 * 2^24 ---little-endian only :-/

main = do {
         ios <- socket AF_INET Stream defaultProtocol;
	 bind ios (SockAddrInet (4242::PortNumber) localhost );
	 listen ios 1;
	 (s, addr) <- Network.Socket.accept ios;
	 putStrLn "accepted connection";
       }
