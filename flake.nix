{
  description = "xdg.nix, the flake for XDG compliance in NixOS";

  outputs = { self, nixpkgs }: {
    lib = (import ./lib.nix);
  };
}
