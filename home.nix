{ config, pkgs, lib, ... }:
let
nurpkgs = import (builtins.fetchTarball "https://github.com/nix-community/NUR/archive/master.tar.gz") {};
in
{
	home.username = "sam";
	home.homeDirectory = "/home/sam";
	nix = {
		package = pkgs.nix;
	};
# {{{1 Packages General
	home.packages = with pkgs; [
# core and Terminal
		alacritty dig feh fzf git gh mpv ranger ripgrep tree xfce.thunar unzip yt-dlp zathura
# Wayland
			eww-wayland rofi-wayland swww
# Graphical programs
			krita logseq
# Development 
			gcc nodejs nodePackages_latest.npm
# Language servers
			nodePackages_latest.typescript-language-server nodePackages_latest.svelte-language-server nodePackages_latest.firebase-tools # Node Tools
			sumneko-lua-language-server
			vscode-extensions.rust-lang.rust-analyzer rustup
	];

# {{{1 Firefox
	programs.firefox = {
		enable = true;
		package = pkgs.wrapFirefox pkgs.firefox-unwrapped { 
			extraPolicies = {
				CaptivePortal = false;
				DisableFirefoxStudies = true;
				DisablePocket = true;
				DisableTelemetry = true;
				DisableFirefoxAccounts = false;
				NoDefaultBookmarks = true;
				OfferToSaveLogins = false;
				OfferToSaveLoginsDefault = false;
				PasswordManagerEnabled = false;
				FirefoxHome = {
					Search = true;
					Pocket = true;
					Snippets = true;
					TopSites = true;
					Highlights = true;
				};
			};
		};
		profiles = {
			sam = {
				id = 0;
				name = "sam";
				extensions = with nurpkgs.repos.rycee.firefox-addons; [
					ublock-origin
						bitwarden
						videospeed
				];
			};
		};
	};
# {{{1 Neovim
	programs.neovim = {
		enable = true;
		defaultEditor = true;
# {{{2 Neovim Plugins
	plugins = with pkgs.vimPlugins; [
# {{{3 TPopes Plugins and other similar
	vim-fugitive vim-rhubarb vim-sleuth vim-surround
		vim-sensible vim-obsession vim-unimpaired
		comment-nvim vim-tmux-navigator
# {{{3 LSP Stuff 
	nvim-lspconfig fidget-nvim neodev-nvim nvim-cmp 
		cmp-nvim-lsp luasnip cmp_luasnip
# {{{3 Looking good
	catppuccin-nvim lualine-nvim
# {{{3 Fuzzy Finder and Harpoon
	plenary-nvim telescope-nvim telescope-fzf-native-nvim telescope-file-browser-nvim
		harpoon
# {{{3 Treesitter and its many parsers
	nvim-treesitter nvim-treesitter-textobjects nvim-treesitter-parsers.yaml 
		nvim-treesitter-parsers.yuck
		nvim-treesitter-parsers.typescript
		nvim-treesitter-parsers.tsx
		nvim-treesitter-parsers.toml
		nvim-treesitter-parsers.svelte
		nvim-treesitter-parsers.scss
		nvim-treesitter-parsers.rust
		nvim-treesitter-parsers.python
		nvim-treesitter-parsers.nix
		nvim-treesitter-parsers.markdown
		nvim-treesitter-parsers.lua
		nvim-treesitter-parsers.ledger
		nvim-treesitter-parsers.javascript
		nvim-treesitter-parsers.html
		nvim-treesitter-parsers.html
		nvim-treesitter-parsers.css
		nvim-treesitter-parsers.norg
		];
};

programs.bash = {
	enable = true;
	bashrcExtra = ''
		. ~/dotfiles/bash/bashrc
		'';
};
programs.git = {
	enable = true;
	userName = "samuelj123";
	userEmail = "samuelj123@gmail.com";
	extraConfig = {
		color = { ui = true; };
		init = { defaultBranch = "master"; };
	};
};
home.stateVersion = "22.11"; # Please read the comment before changing.

# {{{1 Sourcing other files
	home.file = {
		"/home/sam/.config/alacritty/alacritty.yml".source = /home/sam/dotfiles/alacritty/alacritty.yml;
		"/home/sam/.config/hypr/hyprland.conf".source = /home/sam/dotfiles/hyprland.conf;
		"/home/sam/.config/nvim/init.lua".source = /home/sam/dotfiles/nvim/init2.lua;
		"/home/sam/.config/nixpkgs/config.nix".source = /home/sam/dotfiles/nurinstall.nix;
	};
# if you don't want to manage your shell through Home Manager.
	home.sessionVariables = {
		EDITOR = "nvim";
	};

# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
