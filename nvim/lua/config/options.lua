-- Leader Keys
vim.g.mapleader = " "

-- Line Numbers
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.cursorlineopt = "number"

-- Search
vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.inccommand = "split"
vim.opt.grepprg = "rg --vimgrep --smart-case"

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 2
vim.opt.smartindent = true
