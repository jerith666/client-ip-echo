--- nix-shell -p "haskellPackages.ghcWithPackages (pkgs: [pkgs.network])"

--- import Network
import Network.Socket

main = do {
         ios <- socket AF_INET Stream defaultProtocol;
	 bind ios (SockAddrInet (4242::PortNumber) iNADDR_ANY );
	 listen ios 1;
	 (s, addr) <- accept ios;
	 putStrLn "accepted connection";
       }
