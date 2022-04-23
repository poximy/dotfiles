call plug#begin()
Plug 'mattn/emmet-vim'
Plug 'tpope/vim-fugitive'
Plug 'lewis6991/gitsigns.nvim'

Plug 'windwp/nvim-autopairs'
Plug 'nvim-lualine/lualine.nvim'

Plug 'navarasu/onedark.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

Plug 'fatih/vim-go'

Plug 'neovim/nvim-lspconfig'
Plug 'hrsh7th/nvim-cmp'
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'L3MON4D3/LuaSnip'
Plug 'saadparwaiz1/cmp_luasnip'
call plug#end()

set title
set ignorecase
set incsearch
set smartcase
set nohlsearch

set splitbelow splitright
set scrolloff=8
set laststatus=2

set nowrap
set shiftwidth=2
set tabstop=2 softtabstop=2

set noswapfile
set nobackup

" visual settings
set showcmd
set noshowmode
set wildmenu
set number relativenumber
set mouse=a
set cursorline
set colorcolumn=80
set signcolumn=yes
set encoding=utf-8
set clipboard+=unnamedplus

set lazyredraw
set updatetime=100

highlight Normal guibg=none
highlight Normal ctermbg=none

lua << EOF
require('lualine').setup {
	options = {
    icons_enabled = false, --Nerf Font
    theme = 'auto',
  },
}

require('onedark').setup {
    style = 'dark',
		transparent = true,
		code_style = {
        comments = 'italic',
        keywords = 'italic',
        functions = 'bold',
        strings = 'none',
        variables = 'none'
    },
}
require('onedark').load()

local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities)

local lspconfig = require('lspconfig')

local servers = { 'tsserver', 'tailwindcss', 'eslint', 'jsonls', 'dockerls', 'pyright' }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    -- on_attach = my_custom_on_attach,
    capabilities = capabilities,
  }
end

require'lspconfig'.gopls.setup{
	cmd = { "/Users/poximy/go/bin/gopls" }
}

local luasnip = require 'luasnip'

local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = cmp.mapping.preset.insert({
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping.complete(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end, { 'i', 's' }),
    ['<S-Tab>'] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, { 'i', 's' }),
  }),
  sources = {
    { name = 'nvim_lsp' },
    { name = 'luasnip' },
  },
}

require('gitsigns').setup()

require('nvim-autopairs').setup{}

require'nvim-treesitter.configs'.setup {
	ensure_installed = {
		"go", "python", "typescript", "javascript", "tsx", "lua",
		"vim", "dockerfile", "json", "yaml", "markdown", "comment",
	},
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
}
EOF
