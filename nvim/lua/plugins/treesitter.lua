return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
	require('nvim-treesitter.configs').setup({
	    ensure_installed = { "lua", "tsx", "typescript", "rust", "javascript", "html", "json", "yaml", "dockerfile" },
	    auto_install = true,
	    highlight = { enable = true },
	})
    end,
}
