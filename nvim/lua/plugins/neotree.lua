return {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
	"nvim-lua/plenary.nvim",
	"nvim-tree/nvim-web-devicons",
	"MunifTanjim/nui.nvim",
    },
    lazy = false,
    init = function()
	vim.api.nvim_create_autocmd("VimEnter", {
	    callback = function()
		vim.cmd("Neotree show")
	    end,
	})
    end,
    opts = {
	close_if_last_window = true,
	window = {
	    mappings = {
		["l"] = "open",
		["h"] = "close_node",
		["O"] = {
		    command = function(state)
			local node = state.tree:get_node()
			vim.fn.system({ "open", node.path })
		    end,
		    desc = "Open with system viewer",
		},
	    },
	},
	filesystem = {
	    use_libuv_file_watcher = true,
	    follow_current_file = { enabled = true },
	    filtered_items = {
		visible = true,
		hide_dotfiles = false,
		hide_gitignored = false,
	    },
	},
    },
}
