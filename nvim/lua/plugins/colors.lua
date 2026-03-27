return {
    {
	"catppuccin/nvim",
	name = "catppuccin",
	priority = 1000,
	opts = {
	    transparent_background = true,
	    integrations = {
		neotree = true,
	    },
	},
	config = function(_, opts)
	    require("catppuccin").setup(opts)
	    vim.cmd.colorscheme("catppuccin")
	end,
    },
    {
	"nvim-lualine/lualine.nvim",
	dependencies = {
	    "nvim-tree/nvim-web-devicons",
	},
	opts = {
	    theme = 'catppuccin'
	}
    },
}
