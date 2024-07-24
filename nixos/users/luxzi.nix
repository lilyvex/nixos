{ self, pkgs, ... }:

{
  users.users.luxzi = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
    shell = pkgs.zsh;
    packages = [
      self.inputs.home-manager.packages.${pkgs.system}.home-manager
    ];
  };

  environment.shells = with pkgs; [ zsh ];
  programs.zsh.enable = true;
}
