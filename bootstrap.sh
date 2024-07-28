#!/bin/sh

nix-channel --add https://nixos.org/channels/nixos-unstable nixos
nixos-rebuild switch --upgrade
nixos-install --flake /mnt/home/luxzi/.dotfiles
