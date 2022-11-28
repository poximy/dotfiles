return require('packer').startup(function(use)
	use 'wbthomason/packer.nvim'

	-- lsp & syntax
	use 'neovim/nvim-lspconfig'
	use 'hrsh7th/cmp-nvim-lsp'
	use 'hrsh7th/cmp-buffer'
	use 'hrsh7th/cmp-path'
	use 'hrsh7th/cmp-cmdline'
	use {
		'nvim-treesitter/nvim-treesitter',
		run = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = {
					"go", "python", "typescript", "javascript", "tsx", "html", "css",
					"svelte", "jsdoc", "json", "prisma", "dockerfile", "vim", "lua",
					"yaml", "markdown", "markdown_inline", "comment", "fish",
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			}
		end
	}

	use {
		'hrsh7th/nvim-cmp',
		config = function()
			local cmp = require 'cmp'

			cmp.setup({
				snippet = {
					expand = function(args)
						require('luasnip').lsp_expand(args.body)
					end,
				},
				window = {
					completion = cmp.config.window.bordered(),
					documentation = cmp.config.window.bordered(),
				},
				mapping = cmp.mapping.preset.insert({
					['<c-b>'] = cmp.mapping.scroll_docs(-4),
					['<c-f>'] = cmp.mapping.scroll_docs(4),
					['<c-space>'] = cmp.mapping.complete(),
					['<c-e>'] = cmp.mapping.abort(),
					['<cr>'] = cmp.mapping.confirm({ select = true }),
				}),
				sources = cmp.config.sources({
					{ name = 'nvim_lsp' },
					{ name = 'luasnip' }, -- for luasnip users.
				}, {
					{ name = 'buffer' },
				})
			})

			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'cmp_git' }, -- you can specify the `cmp_git` source if you were installed it.
				}, {
					{ name = 'buffer' },
				})
			})

			cmp.setup.cmdline('/', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = {
					{ name = 'buffer' }
				}
			})

			cmp.setup.cmdline(':', {
				mapping = cmp.mapping.preset.cmdline(),
				sources = cmp.config.sources({
					{ name = 'path' }
				}, {
					{ name = 'cmdline' }
				})
			})
			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			local servers = {
				'tsserver', 'tailwindcss', 'eslint', 'jsonls', 'dockerls',
				'pyright', 'svelte', 'html', 'cssls'
			}

			local lspconfig = require('lspconfig')
			for _, lsp in ipairs(servers) do
				lspconfig[lsp].setup {
					capabilities = capabilities,
				}
			end

			lspconfig.gopls.setup {
				cmd = { '/Users/poximy/go/bin/gopls' }
			}
		end
	}

	use 'L3MON4D3/LuaSnip'
	use 'saadparwaiz1/cmp_luasnip'

	use {
		'ray-x/go.nvim',
		config = function()
			require('go').setup()
		end
	}
	use 'ray-x/guihua.lua'

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
			require('lualine').setup {
				options = {
					theme = 'auto',
					icons_enabled = false, -- nerd font
					component_separators = { left = '', right = '' },
					section_separators = { left = '', right = '' },
				},
				sections = {
					lualine_a = { 'mode' },
					lualine_b = { 'filename' },
					lualine_c = { 'branch', 'diff', 'diagnostics' },
					lualine_x = { 'filesize' },
					lualine_y = { 'filetype' },
					lualine_z = { 'location' }
				},
			}
		end
	}

	use { 'dracula/vim', as = 'dracula' }

	-- misc
	use 'mattn/emmet-vim'

	use {
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
		end
	}

	use {
		'kyazdani42/nvim-tree.lua',
		config = function()
			require("nvim-tree").setup {
				view = {
					side = 'right',
					adaptive_size = true
				},
				renderer = {
					icons = {
						show = {
							file = false,
							folder = false,
							folder_arrow = false,
							git = false,
						}
					}
				}
			}
		end
	}
end)
