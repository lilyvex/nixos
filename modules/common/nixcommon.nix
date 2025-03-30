{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  nixpkgs.config.allowUnfree = true;

  home-manager = {
    extraSpecialArgs = {inherit inputs outputs;};
    useGlobalPkgs = true;
    useUserPackages = true;
  };

  nix = {
    nixPath = ["nixpkgs=${inputs.nixpkgs}"];
    package = pkgs.nixVersions.stable;
    optimise.automatic = true;
    gc = {
      persistent = true;
      automatic = true;
    };
    extraOptions = ''
      # If set to true, Nix will fall back to building from source if a binary substitute fails.
      fallback = true
      # the timeout (in seconds) for establishing connections in the binary cache substituter.
      connect-timeout = 10
      # these log lines are only shown on a failed build
      log-lines = 25
    '';
    settings = {
      auto-optimise-store = true;

      trusted-users = ["root" "@wheel"];
      experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
  };
  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "24.11";
}
