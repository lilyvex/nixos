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
      mutableExtensionsDir = true;
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
        github.github-vscode-theme
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
        gruntfuggly.todo-tree
        mhutchie.git-graph
        fill-labs.dependi
        bbenoist.nix
        tamasfe.even-better-toml
        twxs.cmake
        llvm-vs-code-extensions.vscode-clangd
        mkhl.direnv
        vscodevim.vim
      ];

      userSettings = {
        "editor.cursorSmoothCaretAnimation" = "on";
        "editor.smoothScrolling" = true;
        "editor.cursorBlinking" = "expand";
        "workbench.colorTheme" = "GitHub Dark Default";
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
        "workbench.activityBar.location" = "top";
        "window.menuBarVisibility" = "compact";
      };
    };
  };
}
