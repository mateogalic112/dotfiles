return {
    "iamcco/markdown-preview.nvim",
    ft = { "markdown" },
    build = "cd app && npm install",
    keys = {
	{ "<leader>mp", "<cmd>MarkdownPreviewToggle<cr>", desc = "Toggle markdown preview" },
    },
}
