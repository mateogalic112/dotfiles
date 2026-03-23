return {
    "akinsho/bufferline.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    lazy = false,
    opts = {
	options = {
	    offsets = {
		{
		    filetype = "neo-tree",
		    text = "File Explorer",
		    separator = true,
		},
	    },
	},
    },
}
