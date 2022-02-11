# For building an environment to use on macOS
FROM nixos/nix
RUN nix-channel --update
RUN nix-env -iA nixpkgs.haskellPackages.stack
