vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.relativenumber = true
vim.opt.numberwidth = 3
vim.opt.signcolumn = "yes"
vim.opt.laststatus = 3

vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true
vim.opt.smartcase = true
vim.opt.mouse = "a"

vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false

vim.opt.hlsearch = false
vim.opt.incsearch = true
vim.opt.ignorecase = true

vim.opt.termguicolors = true
vim.opt.scrolloff = 8
vim.opt.updatetime = 50

vim.opt.clipboard = "unnamedplus"
vim.opt.cmdheight = 2
vim.opt.completeopt = { "menuone", "noselect" }
vim.opt.conceallevel = 0
vim.spelllang = "en_ca"
vim.opt.fileencoding = "utf-8"

vim.keymap.set("n", "<leader>tt", vim.cmd.tabnew, { silent = true })
vim.keymap.set("n", "<leader>tn", vim.cmd.tabNext, { silent = true })
vim.keymap.set("n", "<leader>tp", vim.cmd.tabprevious, { silent = true })
vim.keymap.set("n", "<leader>tx", vim.cmd.tabclose, { silent = true })
