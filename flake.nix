{
  description = "xdg.nix, the flake for XDG compliance in NixOS";

  outputs = inputs: {
    lib = (import ./lib.nix);
  };
}
