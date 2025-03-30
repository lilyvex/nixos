{
  config,
  lib,
  pkgs,
  ...
}: let
  cfg = config.lily.vscode;
in {
  options.lily.vscode = {
    enable = lib.mkEnableOption "activate vscode";
  };

  config = lib.mkIf cfg.enable {
    programs.vscode = {
      enable = true;
      enableUpdateCheck = false;
      enableExtensionUpdateCheck = false;
      mutableExtensionsDir = false;
      package = pkgs.vscode.overrideAttrs (attrs: {
        buildInputs = with pkgs;
          attrs.buildInputs
          ++ [
            bun
            gcc
            cmake
            ninja
          ];
      });
      extensions = with pkgs.vscode-extensions; [
        github.copilot
        github.copilot-chat
        rust-lang.rust-analyzer
        svelte.svelte-vscode
        bradlc.vscode-tailwindcss
        ms-vsliveshare.vsliveshare
        ms-vscode.cmake-tools
        ms-python.python
        vadimcn.vscode-lldb
        bierner.markdown-preview-github-styles
        bierner.markdown-checkbox
        bierner.markdown-emoji
        bierner.markdown-footnotes
        bierner.markdown-mermaid
        denoland.vscode-deno
        ziglang.vscode-zig
        #             geequlim.godot-tools
        gruntfuggly.todo-tree
        mhutchie.git-graph
        fill-labs.dependi
        bbenoist.nix
        tamasfe.even-better-toml
        twxs.cmake
        llvm-vs-code-extensions.vscode-clangd
        mkhl.direnv
        (pkgs.vscode-utils.buildVscodeMarketplaceExtension {
          mktplcRef = {
            name = "darcula-solid";
            publisher = "jussiemion";
            version = "1.2.1";
            hash = "sha256-tIfCkOR1Z/uRWiZhrBfOQCZT3Cu6yNjAnxjn0UJFO2U=";
          };
        })
      ];

      userSettings = {
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;
        "editor.cursorBlinking" = "expand";
        "workbench.colorTheme" = "Darcula Solid";
        "clangd.path" = "${pkgs.clang-tools}/bin/clangd";
        "clangd.arguments" = [
          "--clang-tidy"
          "--background-index"
          "--completion-style=detailed"
          "--cross-file-rename"
          "--header-insertion=iwyu"
          "--all-scopes-completion"
        ];
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "zig.path" = "${pkgs.zls}/bin/zls";
      };
    };
  };
}
