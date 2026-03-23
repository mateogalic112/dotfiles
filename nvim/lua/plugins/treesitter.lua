return {
    'nvim-treesitter/nvim-treesitter',
    lazy = false,
    build = ':TSUpdate',
    config = function()
	require('nvim-treesitter').setup()

	local parsers = { "lua", "tsx", "typescript", "rust", "javascript", "html", "json", "yaml", "dockerfile" }
	local installed = require('nvim-treesitter').get_installed()
	local to_install = vim.tbl_filter(function(p)
	    return not vim.tbl_contains(installed, p)
	end, parsers)
	if #to_install > 0 then
	    require('nvim-treesitter').install(to_install)
	end
    end,
}
