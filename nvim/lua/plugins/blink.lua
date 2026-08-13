require("blink.cmp").setup({
  completion = {
    documentation = { auto_show = true, auto_show_delay_ms = 200 },
    -- Dimmed inline preview of the selected item
    ghost_text = { enabled = true },
  },

  -- Parameter hints while typing inside a call; experimental upstream
  signature = { enabled = true },
})
