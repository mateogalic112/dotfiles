return {
    {
	"williamboman/mason.nvim",
	lazy = false,
	opts = {},
    },
    {
	"williamboman/mason-lspconfig.nvim",
	lazy = false,
	dependencies = {
	    "williamboman/mason.nvim",
	    "neovim/nvim-lspconfig",
	},
	opts = {
	    ensure_installed = {
		"html",
		"cssls",
		"tailwindcss",
		"eslint",
		"jsonls",
		"lua_ls",
	    },
	    automatic_installation = true,
	},
    },
    {
	"neovim/nvim-lspconfig",
	lazy = false,
	dependencies = {
	    "hrsh7th/cmp-nvim-lsp",
	},
	config = function()
	    local capabilities = require("cmp_nvim_lsp").default_capabilities()

	    local servers = { "html", "cssls", "tailwindcss", "eslint", "jsonls" }
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
		    vim.keymap.set("n", "gr", vim.lsp.buf.references, vim.tbl_extend("force", opts, { desc = "Find references" }))
		    vim.keymap.set("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Hover docs" }))
		    vim.keymap.set("n", "<leader>ca", vim.lsp.buf.code_action, vim.tbl_extend("force", opts, { desc = "Code action" }))
		    vim.keymap.set("n", "<leader>rn", vim.lsp.buf.rename, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))
		    vim.keymap.set("n", "[d", function() vim.diagnostic.jump({ count = -1 }) end, vim.tbl_extend("force", opts, { desc = "Previous diagnostic" }))
		    vim.keymap.set("n", "]d", function() vim.diagnostic.jump({ count = 1 }) end, vim.tbl_extend("force", opts, { desc = "Next diagnostic" }))
		end,
	    })

	    vim.diagnostic.config({
		virtual_text = true,
	    })
	end,
    },
}
