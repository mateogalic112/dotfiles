return {
    {
	"williamboman/mason.nvim",
	lazy = false,
	opts = {},
    },
    {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
	    "hrsh7th/cmp-nvim-lsp",
	},
	config = function()
	    local capabilities = require("cmp_nvim_lsp").default_capabilities()

	    local servers = { "html", "cssls", "tailwindcss", "eslint", "jsonls", "rust_analyzer", "mdx_analyzer" }
	    for _, server in ipairs(servers) do
		vim.lsp.config(server, {
		    capabilities = capabilities,
		})
		vim.lsp.enable(server)
	    end

	    vim.lsp.config("lua_ls", {
		capabilities = capabilities,
		settings = {
		    Lua = {
			diagnostics = {
			    globals = { "vim" },
			},
		    },
		},
	    })
	    vim.lsp.enable("lua_ls")

	    vim.api.nvim_create_autocmd("LspAttach", {
		callback = function(ev)
		    local opts = { buffer = ev.buf }
		    vim.keymap.set("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))
		    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
		    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		end,
	    })
	end,
    },
}
