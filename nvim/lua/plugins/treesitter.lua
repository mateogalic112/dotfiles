return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
        require('nvim-treesitter').setup({
            ensure_installed = { "lua", "tsx", "typescript", "rust", "javascript", "html", "json", "yaml", "dockerfile", "markdown", "markdown_inline" },
            auto_install = true,
        })
    end,
}
