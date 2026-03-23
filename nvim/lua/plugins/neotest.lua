return {
    "nvim-neotest/neotest",
    dependencies = {
	"nvim-neotest/nvim-nio",
	"nvim-lua/plenary.nvim",
	"nvim-treesitter/nvim-treesitter",
	"nvim-neotest/neotest-jest",
    },
    keys = {
	{ "<leader>tn", function() require("neotest").run.run() end, desc = "Run nearest test" },
	{ "<leader>tf", function() require("neotest").run.run(vim.fn.expand("%")) end, desc = "Run file tests" },
	{ "<leader>ts", function() require("neotest").summary.toggle() end, desc = "Toggle test summary" },
	{ "<leader>to", function() require("neotest").output.open({ enter_on_open = true }) end, desc = "Show test output" },
	{ "<leader>tp", function() require("neotest").output_panel.toggle() end, desc = "Toggle output panel" },
	{ "<leader>ta", function() require("neotest").run.run(vim.fn.getcwd()) end, desc = "Run all tests" },
    },
    config = function()
	require("neotest").setup({
	    adapters = {
		require("neotest-jest")({
		    jestCommand = "npx jest --runInBand",
		    env = { NODE_ENV = "test" },
		    cwd = function() return vim.fn.getcwd() end,
		}),
	    },
	})
    end,
}
