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
			require('gitsigns').setup {
				numhl = true,

				on_attach = function(bufnr)
					local gs = package.loaded.gitsigns

					vim.keymap.set('n', '<leader>hs', gs.stage_hunk)
					vim.keymap.set('n', '<leader>hr', gs.reset_hunk)
					vim.keymap.set('v', '<leader>hs', function() gs.stage_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
					vim.keymap.set('v', '<leader>hr', function() gs.reset_hunk { vim.fn.line('.'), vim.fn.line('v') } end)
					vim.keymap.set('n', '<leader>hS', gs.stage_buffer)
					vim.keymap.set('n', '<leader>hu', gs.undo_stage_hunk)
					vim.keymap.set('n', '<leader>hR', gs.reset_buffer)
					vim.keymap.set('n', '<leader>hp', gs.preview_hunk)
					vim.keymap.set('n', '<leader>hb', function() gs.blame_line { full = true } end)
					vim.keymap.set('n', '<leader>tb', gs.toggle_current_line_blame)
					vim.keymap.set('n', '<leader>hd', gs.diffthis)
					vim.keymap.set('n', '<leader>hD', function() gs.diffthis('~') end)
					vim.keymap.set('n', '<leader>td', gs.toggle_deleted)
				end,
			}
		end,
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
					['<C-space>'] = cmp.mapping.complete(),
					['<C-e>'] = cmp.mapping.abort(),
					['<CR>'] = cmp.mapping.confirm(),
					-- Only usable when docs cannot fit in preview window
					['<C-u>'] = cmp.mapping.scroll_docs(-4),
					['<C-d>'] = cmp.mapping.scroll_docs(4),
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
				'ts_ls', 'ts_ls', 'tailwindcss', 'jsonls', 'dockerls', 'pyright',
				'html', 'cssls', 'lua_ls', 'astro', 'emmet_language_server',
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

			lspconfig.lua_ls.setup {
				settings = {
					Lua = {
						runtime = {
							version = 'LuaJIT',
						},
						diagnostics = {
							globals = { 'vim' },
						},
						workspace = {
							library = vim.api.nvim_get_runtime_file("", true),
						},
						telemetry = {
							enable = false,
						},
					},
				},
			}
		end
	},

	-- Go LSP
	{
		'ray-x/go.nvim',
		config = function()
			require('go').setup()

			local format_sync_grp = vim.api.nvim_create_augroup("GoImport", {})
			vim.api.nvim_create_autocmd("BufWritePre", {
				pattern = "*.go",
				callback = function()
					require('go.format').goimport()
				end,
				group = format_sync_grp,
			})
		end
	},

	'ray-x/guihua.lua',

	-- Syntax
	{
		'nvim-treesitter/nvim-treesitter',
		build = ':TSUpdate',
		config = function()
			require 'nvim-treesitter.configs'.setup {
				auto_install = true,
				sync_install = true,
				ignore_install = {},
				ensure_installed = {
					"go", "gomod", "gosum", "python", "html", "css", "javascript",
					"typescript", "tsx", "jsdoc", "json", "dockerfile", "vim",
					"lua", "fish", "git_config", "gitignore", "diff", "git_rebase", "gitcommit"
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
	{
		'nvim-telescope/telescope.nvim',
		dependencies = { 'nvim-lua/plenary.nvim' },
		config = function()
			local builtin = require('telescope.builtin')
			vim.keymap.set('n', '<space>ff', builtin.find_files, {})
			vim.keymap.set('n', '<space>fg', builtin.live_grep, {})
			vim.keymap.set('n', '<space>fb', builtin.buffers, {})
		end
	},
	{
		'nvim-tree/nvim-tree.lua',
		config = function()
			vim.g.loaded_netrw = 1
			vim.g.loaded_netrwPlugin = 1

			require("nvim-tree").setup {
				view = {
					side = 'right',
					width = 32,
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

			local api = require 'nvim-tree.api'
			vim.keymap.set('n', '<space>t', api.tree.toggle)
		end,
	},
}
