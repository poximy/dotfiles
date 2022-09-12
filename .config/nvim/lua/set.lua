-- base config
vim.opt.title = true
vim.opt.ignorecase = true
vim.opt.incsearch = true
vim.opt.smartcase = true
vim.opt.hlsearch = true

vim.opt.splitbelow = true
vim.opt.scrolloff = 0
vim.opt.laststatus = 2

vim.opt.wrap = false
vim.opt.shiftwidth = 2
vim.opt.tabstop = 2
vim.opt.softtabstop = 2

vim.opt.swapfile = false
vim.opt.backup = false

-- visual settings
vim.opt.showcmd = true
vim.opt.showmode = true
vim.opt.wildmenu = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.mouse = "a"
vim.opt.cursorline = true
vim.opt.colorcolumn = "80"
vim.opt.signcolumn = "yes"
vim.opt.encoding = "utf-8"
vim.opt.clipboard = "unnamedplus"

vim.opt.lazyredraw = true
vim.opt.updatetime = 100

-- also place hilight group
vim.cmd[[colorscheme dracula]]
