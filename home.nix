# {{{1 README
# This particular home.nix file is meant for WSL installs only. There are no Graphical apps on this thing
# To install, run...
# nix-channel --add https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz home-manager
# nix-channel --update
# Place this file into ~/.config/home-manager/home.nix
# Run...
# home-manager switch

#{{{1 Initial Configs
{ config, pkgs, lib, ... }:
let
allowUnfree = true;
in
{
	home.username = "sam";
	home.homeDirectory = "/home/sam";
	home.stateVersion = "23.11"; # Please read the comment before changing.
		nix = {
			package = pkgs.nix;
			settings.experimental-features = ["nix-command" "flakes" ];
		};

	home.packages = with pkgs; [ #{{{ 1 Packages General
# core and Terminal
		alacritty dig feh fzf git gh mpv ranger ripgrep tmux tree xfce.thunar unzip xclip yt-dlp zathura
# Development 
			gcc nodejs nodePackages_latest.npm
# Language servers
			nodePackages_latest.typescript-language-server nodePackages_latest.svelte-language-server nodePackages_latest.firebase-tools # Node Tools
			sumneko-lua-language-server
			vscode-extensions.rust-lang.rust-analyzer rustup
	];

# {{{1 Tmux
	programs.tmux = {
		enable = true;
		terminal = "tmux-256color";
		shortcut = "s";
		baseIndex = 1;
		extraConfig = ''
		 set -g status-position top
		'';
	#{{{2 Tmux Plugins
		plugins = with pkgs.tmuxPlugins; [ 
			{ 
				plugin = catppuccin;
				extraConfig = ''
				tmux_orange="#fab387"
				set -g @catppuccin_pane_status_enabled "yes"
				set -g @catppuccin_pane_border_status "top"
				set -g @catppuccin_pane_left_separator ""
				set -g @catppuccin_pane_right_separator ""
				set -g @catppuccin_pane_middle_separator "█ "
				set -g @catppuccin_pane_number_position "left"
				set -g @catppuccin_pane_default_fill "number"
				set -g @catppuccin_pane_default_text "#{b:pane_current_path}"
				set -g @catppuccin_pane_border_style "fg=$tmux_orange"
				set -g @catppuccin_pane_active_border_style "fg=$tmux_orange"
				set -g @catppuccin_pane_color "$tmux_orange"
				set -g @catppuccin_pane_background_color "$tmux_orange"
				'';
			}
			vim-tmux-navigator 
		];
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
# {{{3 Fuzzy Finder and FileChooser
	plenary-nvim fzf-lua oil-nvim
# {{{3 Treesitter and its many parsers
	nvim-treesitter nvim-treesitter-textobjects nvim-treesitter-parsers.yaml 
		nvim-treesitter-parsers.yuck nvim-treesitter-parsers.typescript nvim-treesitter-parsers.tsx
		nvim-treesitter-parsers.toml nvim-treesitter-parsers.svelte nvim-treesitter-parsers.scss
		nvim-treesitter-parsers.rust nvim-treesitter-parsers.python nvim-treesitter-parsers.nix
		nvim-treesitter-parsers.markdown nvim-treesitter-parsers.lua nvim-treesitter-parsers.ledger
		nvim-treesitter-parsers.javascript nvim-treesitter-parsers.html nvim-treesitter-parsers.html
		nvim-treesitter-parsers.css nvim-treesitter-parsers.norg
		];
	};
# {{{1 Bash
	programs.bash = {
		enable = true;
		bashrcExtra = ''
			. ~/dotfiles/bash/bashrc
			'';
	};
# {{{1 Git
	programs.git = {
		enable = true;
		userName = "samuelj123";
		userEmail = "samuelj123@gmail.com";
		extraConfig = {
			color = { ui = true; };
			init = { defaultBranch = "master"; };
		};
	};

#{{{1 Links
	home.file = {
		"/home/sam/.config/alacritty/alacritty.yml".source = /home/sam/dotfiles/alacritty/alacritty.yml;
		"/home/sam/.config/hypr/hyprland.conf".source = /home/sam/dotfiles/hyprland.conf;
		"/home/sam/.config/nvim/init.lua".source = /home/sam/dotfiles/nvim/init2.lua;
		"/home/sam/.config/nixpkgs/config.nix".source = /home/sam/dotfiles/nurinstall.nix;
		# IF I ever install an X System with URXVT terminal
		#"/home/sam/.config/i3/config".source = /home/sam/dotfiles/i3config;
		#"/home/sam/.Xresources".source = /home/sam/dotfiles/xresources;
	};

#{{{1 Session Variables
	home.sessionVariables = {
		EDITOR = "nvim";
	};
# {{{1 Final boilerplate
# Let Home Manager install and manage itself.
	programs.home-manager.enable = true;
}
