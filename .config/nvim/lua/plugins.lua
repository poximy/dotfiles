return {
	-- UI
	{
		'dracula/vim',
		name = 'dracula',
		lazy = false,
		priority = 1000,
		config = function()
			vim.cmd [[
			hi Normal guibg=NONE ctermbg=NONE
			hi LineNr guibg=NONE ctermbg=NONE
			hi SignColumn guibg=NONE ctermbg=NONE
			hi EndOfBuffer guibg=NONE ctermbg=NONE

			colorscheme dracula
			]]
		end,
	},
	{
		'nvim-lualine/lualine.nvim',
		lazy = false,
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
	},
	-- Git
	{
		'lewis6991/gitsigns.nvim',
		config = function()
			require('gitsigns').setup()
		end
	},
	-- LSP
	'neovim/nvim-lspconfig',
	'hrsh7th/cmp-nvim-lsp',
	'hrsh7th/cmp-buffer',
	'hrsh7th/cmp-path',
	'hrsh7th/cmp-cmdline',
	'L3MON4D3/LuaSnip',
	'saadparwaiz1/cmp_luasnip',

	{
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
					{ name = 'luasnip' },
				}, {
					{ name = 'buffer' },
				})
			})

			cmp.setup.filetype('gitcommit', {
				sources = cmp.config.sources({
					{ name = 'cmp_git' }
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
				'pyright', 'html', 'cssls', 'emmet_ls'
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
	},

	-- Go LSP
	{
		'ray-x/go.nvim',
		config = function()
			require('go').setup()
		end
	},

	'ray-x/guihua.lua',

	-- Syntax
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				ensure_installed = {
					"go", "gomod", "gosum", "python", "html", "css", "javascript",
					"typescript", "jsdoc", "json", "dockerfile", "vim", "lua", "fish",
					"git_config", "gitignore", "diff", "git_rebase", "gitcommit"
				},
				highlight = {
					enable = true,
					additional_vim_regex_highlighting = false,
				},
			}
		end
	},
	-- Misc
	{
		'windwp/nvim-autopairs',
		config = function()
			require('nvim-autopairs').setup()
		end
	},
}
