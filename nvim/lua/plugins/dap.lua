return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "rcarriga/nvim-dap-ui",
      "theHamsta/nvim-dap-virtual-text",
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle breakpoint",
      },
      {
        "<leader>dB",
        function()
          require("dap").set_breakpoint(vim.fn.input("Breakpoint condition: "))
        end,
        desc = "Conditional breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step into",
      },
      {
        "<leader>dO",
        function()
          require("dap").step_out()
        end,
        desc = "Step out",
      },
      {
        "<leader>dr",
        function()
          require("dap").restart()
        end,
        desc = "Restart",
      },
      {
        "<leader>dt",
        function()
          require("dap").terminate()
        end,
        desc = "Terminate",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "Toggle DAP UI",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()
      require("nvim-dap-virtual-text").setup()

      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end
      dap.listeners.before.event_terminated["dapui_config"] = function()
        dapui.close()
      end
      dap.listeners.before.event_exited["dapui_config"] = function()
        dapui.close()
      end

      -- JS debug adapter (Mason)
      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- Node.js configurations
      -- JavaScript
      dap.configurations.javascript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = "${workspaceFolder}",
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to process",
          processId = require("dap.utils").pick_process,
          cwd = "${workspaceFolder}",
        },
      }

      -- TypeScript
      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file (tsx)",
          program = "${file}",
          cwd = "${workspaceFolder}",
          runtimeExecutable = "node",
          runtimeArgs = { "--import", "tsx" },
          sourceMaps = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to debugger",
          port = 9230,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          outFiles = { "${workspaceFolder}/dist/**/*.js" },
        },
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Next.js server worker",
          port = 9230,
          cwd = "${workspaceFolder}",
          sourceMaps = true,
          pauseForSourceMap = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          outFiles = { "${workspaceFolder}/.next/**/*.js" },
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          -- Debug only the test file currently open in the buffer.
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest (current file)",
          program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
          args = { "--runInBand", "--watchAll=false", "${relativeFile}" },
          cwd = "${workspaceFolder}",
          env = { NODE_ENV = "test" },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          sourceMaps = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
        {
          -- Debug the entire test suite.
          type = "pwa-node",
          request = "launch",
          name = "Debug Jest (all tests)",
          program = "${workspaceFolder}/node_modules/jest/bin/jest.js",
          args = { "--runInBand", "--watchAll=false" },
          cwd = "${workspaceFolder}",
          env = { NODE_ENV = "test" },
          console = "integratedTerminal",
          internalConsoleOptions = "neverOpen",
          sourceMaps = true,
          resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
          skipFiles = { "<node_internals>/**", "${workspaceFolder}/node_modules/**" },
        },
      }

      -- Breakpoint icons
      vim.fn.sign_define("DapBreakpoint", { text = "B", texthl = "DiagnosticError", linehl = "", numhl = "" })
      vim.fn.sign_define("DapBreakpointCondition", { text = "C", texthl = "DiagnosticWarn", linehl = "", numhl = "" })
      vim.fn.sign_define("DapStopped", { text = ">", texthl = "DiagnosticInfo", linehl = "DapStopped", numhl = "" })
    end,
  },
}
