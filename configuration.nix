{ config, lib, pkgs, ... }:
{
# {{{1 Imports
  imports =
    [ 
    /etc/nixos/hardware-configuration.nix
      <home-manager/nixos> 
    ];

# {{{1 BootLoader
  boot.loader.systemd-boot.enable = true;
  boot.initrd.network.enable = true;
  boot.initrd.network.udhcpc.enable = true;

# {{{1 Networking
  networking = {
# hostName = "samdesktop"; # Define your hostname.
# wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
    nameservers = [ "208.67.222.222" "208.67.220.220"];
# Configure network proxy if necessary
# proxy.default = "http://user:password@proxy:port/";
# proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Open ports in the firewall.
# firewall.allowedTCPPorts = [ ... ];
# firewall.allowedUDPPorts = [ ... ];
# Or disable the firewall altogether.
# firewall.enable = false;
  };

  services.openssh.enable = true; # Enable the OpenSSH daemon.


# {{{1 Timezone & Locale
  time.timeZone = "Australia/Brisbane"; # Set your time zone.
# Select internationalisation properties.
# i18n.defaultLocale = "en_US.UTF-8";

# {{{1 Fonts
# {{{2 General Fonts
fonts.packages = with pkgs; [
  (nerdfonts.override {fonts = [ "FiraCode" "DroidSansMono" ]; })
];
# {{{2 Console Fonts
# console = {
#   font = "Lat2-Terminus16";
#   keyMap = "us";
#   useXkbConfig = true; # use xkbOptions in tty.
# };

# {{{1 System Packages
  environment = {
    pathsToLink = ["/libexec"];
    systemPackages = with pkgs; [
      vim 
      wget
      home-manager
    ];
    variables = {
      EDITOR = "nvim";
      VISUAL= "nvim";
      SUDO_EDITOR = "nvim";
    };
  };
# services.xserver.xkbOptions = "eurosign:e,caps:escape";

# {{{1 Wayland and Hyperland
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    NIXOS_OZONE_WL = "1";
  };
  xdg.portal = {
    enable = true;
    extraPortals = [pkgs.xdg-desktop-portal-gtk];
  };

# {{{1 Enable CUPS to print documents.
  services.printing.enable = true;

# {{{1 Enable sound.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

# {{{1 Enable touchpad support (enabled default in most desktopManager).
  services.xserver.libinput.enable = true;

# {{{1 Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.sam = {
    isNormalUser = true;
    extraGroups = [ "wheel" ]; # Enable ‘sudo’ for the user.
  };

# {{{2 Adding Nur
  nixpkgs.config.packageOverrides = pkgs: {
    nur = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {
      inherit pkgs;
    };
  };
# {{{1 Home Manager Packages
# {{{2 Packages General
  home-manager.users.sam = { pkgs, ... }: {
# {{{2 Firefox
# {{{2 Tmux
  programs.tmux.plugins = with pkgs; [
    tmuxPlugins.vim-tmux-navigator
    tmuxPlugins.catppuccin
  ];
# {{{3 Tmux Config
  programs.tmux = {
    enable = true;
    clock24 = true;
    extraConfig = ''
      unbind C-b
      set -g prefix C-s

# General Options
      # set -g default-terminal "xterm-256color"
      set -ag terminal-overrides ",alacritty:RBG,xterm-256color:RGB"
      set-window-option -g mode-keys vi
# set-option -g status-style bg=default,fg=white
      set -g base-index 1
      setw -g pane-base-index 1

# StatusBar!
      set -g status-position top
      set -g @catppuccin_flavor "mocha"
      set -g @catppuccin_status_modules "application date_time"
      set -g @catppuccin_window_current_fill "number"
      set -g @catppuccin_window_default_fill "number"
      set -g @catppuccin_window_current_text "#W"
      set -g @catppuccin_window_default_text "#W"

# Keep this line at the end of the config
      run '~/.config/tmux/plugins/tpm/tpm'
      '';
  };
  programs.home-manager.enable = true;
  home.stateVersion = "23.11"; # Did you read the comment?
# # {{{2 Neovim
  # programs.neovim = {
    # enable = true;
    # defaultEditor = true;
  # # {{{3 Neovim Plugins
    # plugins = with pkgs.vimPlugins; [
    # # {{{4 TPopes Plugins and other similar
      # vim-fugitive vim-rhubarb vim-sleuth vim-surround
      # vim-sensible vim-obsession vim-unimpaired
      # comment-nvim vim-tmux-navigator
    # # {{{4 LSP Stuff 
      # nvim-lspconfig fidget-nvim neodev-nvim nvim-cmp 
      # cmp-nvim-lsp luasnip cmp_luasnip
    # # {{{4 Looking good
      # catppuccin-nvim lualine-nvim
    # # {{{4 Fuzzy Finder and Harpoon
      # plenary-nvim telescope-nvim telescope-fzf-native-nvim telescope-file-browser-nvim
      # harpoon
    # # {{{4 Treesitter and its many parsers
      # nvim-treesitter nvim-treesitter-textobjects nvim-treesitter-parsers.yaml 
      # nvim-treesitter-parsers.yuck
      # nvim-treesitter-parsers.typescript
      # nvim-treesitter-parsers.tsx
      # nvim-treesitter-parsers.toml
      # nvim-treesitter-parsers.svelte
      # nvim-treesitter-parsers.scss
      # nvim-treesitter-parsers.rust
      # nvim-treesitter-parsers.python
      # nvim-treesitter-parsers.nix
      # nvim-treesitter-parsers.markdown
      # nvim-treesitter-parsers.lua
      # nvim-treesitter-parsers.ledger
      # nvim-treesitter-parsers.javascript
      # nvim-treesitter-parsers.html
      # nvim-treesitter-parsers.html
      # nvim-treesitter-parsers.css
      # nvim-treesitter-parsers.norg
      # ];
    # extraConfig = ''
    # '';
# };
# # {{{2 Bash
  # programs.bash = {
    # enable = true;
    # bashrcExtra = ''
      # . ~/dotfiles/bash/bashrc
      # '';
  # };
# {{{2 Git
  # programs.git = {
    # enable = true;
    # userName = "samuelj123";
    # userEmail = "samuelj123@gmail.com";
    # extraConfig = {
      # color = { ui = true; };
      # init = { defaultBranch = "master"; };
    # };
  # };
# {{{2 Other config files
  home.file = {
    "/home/sam/.config/alacritty/alacritty.yml".source = /home/sam/dotfiles/alacritty/alacritty.yml;
    "/home/sam/.config/hypr/hyprland.conf".source = /home/sam/dotfiles/hyprland.conf;
  };
};

home-manager.useUserPackages = true;
home-manager.useGlobalPkgs = true;

# {{{1 Unknown
# List packages installed in system profile. To search, run:
# $ nix search wget

# Some programs need SUID wrappers, can be configured further or are
# started in user sessions.
# programs.mtr.enable = true;
# programs.gnupg.agent = {
#   enable = true;
#   enableSSHSupport = true;
# };


# {{{1 Saving a backup @ (/run/current-system/configuration.nix)
  system.copySystemConfiguration = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It's perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
