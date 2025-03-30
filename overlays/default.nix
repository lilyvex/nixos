{inputs, ...}: {
  # This one brings our custom packages from the 'pkgs' directory
  additions = final: _prev: import ../pkgs final.pkgs;

  # This one contains whatever you want to overlay
  # You can change versions, add patches, set compilation flags, anything really.
  # https://nixos.wiki/wiki/Overlays
  modifications = final: prev: {
    prismlauncher = prev.prismlauncher.overrideAttrs (oldAttrs: {
      buildInputs = (oldAttrs.buildInputs or []) ++ [final.jdk23];
      jdks = [
        final.jdk23
      ];
      # configurePhase = ''
      #   export JAVA_HOME=${pkgs.jdk22}
      # '';
      # installPhase = ''
      #   mkdir -p $out/bin
      #   cp -r $oldAttrs.out/* $out/
      #   # Create a wrapper script to ensure JAVA_HOME is set
      #   echo '#!/bin/sh' > $out/bin/prismlauncher
      #   echo "export JAVA_HOME=${pkgs.jdk22}" >> $out/bin/prismlauncher
      #   echo "exec $out/bin/PrismLauncher \"\$@\"" >> $out/bin/prismlauncher
      #   chmod +x $out/bin/prismlauncher
      # '';
    });
  };

  # When applied, the unstable nixpkgs set (declared in the flake inputs) will
  # be accessible through 'pkgs.unstable'
  unstable-packages = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
      config.allowUnfree = true;
    };
  };
}
