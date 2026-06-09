return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "nvim-neotest/neotest-jest",
  },
  keys = {
    {
      "<leader>tn",
      function()
        require("neotest").run.run()
      end,
      desc = "Run nearest test",
    },
    {
      "<leader>tf",
      function()
        require("neotest").run.run(vim.fn.expand("%"))
      end,
      desc = "Run file tests",
    },
    {
      "<leader>td",
      function()
        -- Raise the per-test timeout for debug runs only: while paused at a
        -- breakpoint, Jest's default 5s timeout keeps ticking and fails the
        -- test ("Exceeded timeout of 5000 ms"), killing the debug session.
        require("neotest").run.run({ strategy = "dap", extra_args = { "--testTimeout=600000" } })
      end,
      desc = "Debug nearest test (DAP)",
    },
    {
      "<leader>ts",
      function()
        require("neotest").summary.toggle()
      end,
      desc = "Toggle test summary",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter_on_open = true })
      end,
      desc = "Show test output",
    },
    {
      "<leader>tp",
      function()
        require("neotest").output_panel.toggle()
      end,
      desc = "Toggle output panel",
    },
    {
      "<leader>ta",
      function()
        require("neotest").run.run(vim.fn.getcwd())
      end,
      desc = "Run all tests",
    },
  },
  config = function()
    local jest = require("neotest-jest")({
      -- Run jest through `node` directly (not `npx`) so the DAP strategy
      -- attaches to the jest process itself. With `npx`, the debugger
      -- attaches to the npx wrapper, which forks jest and exits — the
      -- session terminates instantly.
      jestCommand = "node node_modules/jest/bin/jest.js --runInBand",
      env = { NODE_ENV = "test" },
      cwd = function()
        return vim.fn.getcwd()
      end,
    })

    -- neotest-jest's default filter_dir only excludes node_modules, so it
    -- crawls dist/ (compiled output + .js.map) and chokes parsing them
    -- ("Invalid language name"), which breaks discovery and the DAP run.
    -- Restrict discovery to source dirs.
    local ignored = { ["node_modules"] = true, dist = true, coverage = true, logs = true, [".git"] = true }
    jest.filter_dir = function(name)
      return not ignored[name]
    end

    require("neotest").setup({
      adapters = { jest },
    })
  end,
}
