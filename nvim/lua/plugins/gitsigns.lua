require("gitsigns").setup({
  current_line_blame = true,
  current_line_blame_opts = {
    virt_text_pos = "eol",
    delay = 200,
  },

  on_attach = function(bufnr)
    local gs = require("gitsigns")

    local function map(mode, lhs, rhs, desc)
      vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
    end

    map("n", "]h", function()
      gs.nav_hunk("next")
    end, "Next Hunk")

    map("n", "[h", function()
      gs.nav_hunk("prev")
    end, "Prev Hunk")

    map("n", "<leader>gp", gs.preview_hunk, "Preview Hunk")
    map("n", "<leader>ga", gs.stage_hunk, "Stage Hunk")
    map("n", "<leader>gr", gs.reset_hunk, "Reset Hunk")
    map("n", "<leader>gB", gs.toggle_current_line_blame, "Toggle Line Blame")

    local function selection()
      return { vim.fn.line("."), vim.fn.line("v") }
    end

    map("v", "<leader>ga", function()
      gs.stage_hunk(selection())
    end, "Stage Selected Lines")

    map("v", "<leader>gr", function()
      gs.reset_hunk(selection())
    end, "Reset Selected Lines")
  end,
})
