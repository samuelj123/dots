
    programs.neovim.plugins = [
      {plugin = pkgs.vimPlugins.vim-fugitive; }
      {plugin = pkgs.vimPlugins.vim-rhubarb; }
      {plugin = pkgs.vimPlugins.vim-sleuth; }
      {plugin = pkgs.vimPlugins.vim-surround; }
      {plugin = pkgs.vimPlugins.vim-sensible; }
      {plugin = pkgs.vimPlugins.vim-obsession; }
      {plugin = pkgs.vimPlugins.gitsigns-nvim;
       config = ''

        '';
      }
      {plugin = pkgs.vimPlugins.dracula-nvim;
       config = ''
	lua local dracula = require("dracula")
	lua dracula.setup({
	colors = {
	  bg = "#282A36",
	  fg = "#F8F8F2",
	  selection = "#44475A",
	  comment = "#6272A4",
	  red = "#FF5555",
	  orange = "#FFB86C",
	  yellow = "#F1FA8C",
	  green = "#50fa7b",
	  purple = "#BD93F9",
	  cyan = "#8BE9FD",
	  pink = "#FF79C6",
	  bright_red = "#FF6E6E",
	  bright_green = "#69FF94",
	  bright_yellow = "#FFFFA5",
	  bright_blue = "#D6ACFF",
	  bright_magenta = "#FF92DF",
	  bright_cyan = "#A4FFFF",
	  bright_white = "#FFFFFF",
	  menu = "#21222C",
	  visual = "#3E4452",
	  gutter_fg = "#4B5263",
	  nontext = "#3B4048",
	},
	show_end_of_buffer=true,
	transparent_bg=true,
	lualine_bg_color=nil
	italic_comment=true,
	})
	lua vim.cmd.colorscheme 'dracula'
        '';
      }
      {plugin = pkgs.vimPlugins.lualine-nvim;
       config = ''

        '';
      }
      {plugin = pkgs.vimPlugins.indent-blankline-nvim;
       config = ''

        '';
      }
      {plugin = pkgs.vimPlugins.comment-nvim;
       config = ''

        '';
      }
      {plugin = pkgs.vimPlugins.plenary-nvim;
       config = ''

        '';
      }
      {plugin = pkgs.vimPlugins.telescope-nvim;
       config = ''

        '';
      }
      {plugin = pkgs.vimPlugins.telescope-fzf-native-nvim;
       config = ''

        '';
      }
      {plugin = pkgs.vimPlugins.harpoon;
       config = ''

        '';
      }
      {plugin = pkgs.vimPlugins.nvim-treesitter;
       config = ''

        '';
      }
    ];
