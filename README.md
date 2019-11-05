# My NixOS system configuration

## Installation

Clone the repository
```
git clone https://github.com/dnixty/nixos-config.git ~/nixos-config
```

Copy `hardware-configuration.nix`
```
sudo cp /etc/nixos/hardware-configuration.nix ~/nixos-config
sudo chown dnixty:users ~/nixos-config/hardware-configuration.nix
```

Link `nixos-config`
```
sudo ln -s /home/dnixty/nixos-config /etc/nixos
```

Rebuild NixOS
```
sudo nixos-rebuild switch
```
