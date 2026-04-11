return {
    "mrcjkb/rustaceanvim",
    version = "^6",
    lazy = false,
    ft = { "rust" },
    config = function()
	vim.g.rustaceanvim = {
	    server = {
		default_settings = {
		    ["rust-analyzer"] = {
			inlayHints = {
			    typeHints = { enable = true },
			    parameterHints = { enable = true },
			    chainingHints = { enable = true },
			    closingBraceHints = { enable = true },
			},
		    },
		},
	    },
	}
    end,
}
