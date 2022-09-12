return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require'nvim-treesitter.configs'.setup {
				ensure_installed = {
					"go", "python", "typescript", "javascript", "tsx", "html", "css",
					"svelte", "jsdoc", "json", "prisma", "dockerfile", "vim", "lua",
					"yaml", "markdown", "markdown_inline", "comment",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			}
		end
	}

	-- git
	use {
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	}


	-- UI
	use {
		'nvim-lualine/lualine.nvim',
		config = function()
			require('lualine').setup{
				options = {
					icons_enabled = false, -- nerd font
					theme = 'auto',
					component_separators = { left = '|', right = '|'},
					section_separators = { left = '', right = ''},
				},
				sections = {
					lualine_a = {'mode'},
					lualine_b = {'branch', 'diff', 'diagnostics'},
					lualine_c = {'filename'},
					lualine_x = {'filesize'},
					lualine_y = {'encoding'},
					lualine_z = {'location'}
				},
			}
		end
	}

	use {
		'dracula/vim', as = 'dracula'
	}

	-- misc
	use {
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
		end
	}
end)
