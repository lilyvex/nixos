# NixOS configuration files

Configured for KDE Plasma Wayland on Nvidia.

## Customizing user settings

To change your username or any additional user settings, you must:

- Create `./nixos/users/<your-name>.nix`, this can be copied from `luxzi.nix` in the same directory.
- Import the newly created file in `./nixos/configuration.nix`.
- Edit `./home-manager/home.nix` to the corresponding username and home directory.

## Adjusting hardware configuration

> [!NOTE]
> If you use an older Nvidia graphics card (i.e. before RTX 20 series), you do not need to modify `./nixos/hardware/nvidia.nix`.
> Although if you use a newer Nvidia graphics card, it is advised to enable `open` to use the open-source kernel driver.

To use AMD graphics cards:

- Create `./nixos/hardware/amd.nix`
- Add `services.xserver.videoDrivers = [ "amdgpu" ];`

## Deployment

If you would like to use these configuration files as is, you can install a NixOS system by:

- Mount and format desired filesystems (as described in the NixOS manual).
- Run the following git clone command while also making sure to replace `<your-name>` with your desired username:
``` sh
git clone git@codeberg.org:luxzi/nixos /mnt/home/<your-name>/.dotfiles
```
- Make any desired changes.
- Install the system with the command below, again, making sure to replace `<your-name>` with your desired username:
``` sh
nixos-install --flake /mnt/home/<your-name>/.dotfiles
```

For more modified versions of this configuration, I recommend forking this repository.

