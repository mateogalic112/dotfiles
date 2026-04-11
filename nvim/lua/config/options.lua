vim.opt.number = true
vim.opt.cursorline = true
vim.opt.relativenumber = true
vim.opt.shiftwidth = 2
vim.opt.timeoutlen = 100
vim.opt.autoread = true

vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "CursorHold", "CursorHoldI" }, {
    pattern = "*",
    command = "checktime",
})

vim.api.nvim_create_autocmd("TextYankPost", {
    callback = function()
        vim.highlight.on_yank({ timeout = 200 })
        vim.fn.setreg("+", vim.fn.getreg('"'))
    end,
})
vim.filetype.add({ extension = { mdx = "markdown" } })

vim.api.nvim_create_autocmd("FileType", {
    pattern = { "typescript", "typescriptreact", "javascript", "javascriptreact" },
    callback = function()
        vim.opt_local.path:append("src")
        vim.opt_local.suffixesadd:prepend({ ".ts", ".tsx", ".js", ".jsx" })
    end,
})
