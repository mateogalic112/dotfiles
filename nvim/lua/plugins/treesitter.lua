-- Neovim only bundles parsers for c/lua/markdown/query/vim/vimdoc, so the rest
-- are installed on demand. Only missing ones are fetched, so startup stays cheap.
local parsers = {
  "bash",
  "css",
  "html",
  "javascript",
  "json",
  "lua",
  "markdown",
  "tsx",
  "typescript",
  "yaml",
}

local installed = require("nvim-treesitter.config").get_installed()
local missing = vim.tbl_filter(function(parser)
  return not vim.tbl_contains(installed, parser)
end, parsers)

if #missing > 0 then
  require("nvim-treesitter").install(missing)
end

-- Enable treesitter for any filetype that has a parser, rather than keeping a
-- second list in sync with the one above
vim.api.nvim_create_autocmd("FileType", {
  group = vim.api.nvim_create_augroup("treesitter-start", { clear = true }),
  callback = function(ev)
    local lang = vim.treesitter.language.get_lang(ev.match)
    if lang and pcall(vim.treesitter.language.add, lang) then
      pcall(vim.treesitter.start, ev.buf, lang)
    end
  end,
})
