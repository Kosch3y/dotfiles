{
  description = "dotfiles";

  outputs = { self }: {
    nixosModules.symlinks = import ./symlinks.nix;
  };
}
