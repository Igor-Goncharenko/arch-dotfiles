return {
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500

    local wk = require("which-key")
    wk.add({
      { "<leader>c", group = "NERDCommenter" },
      { "<leader>d", group = "Diagnostics" },
      { "<leader>f", group = "Telescope" },
      { "<leader>g", group = "LSP" },
    })
  end,
  opts = {
    icons = {
      breadcrumb = "", -- symbol used in the command line area that shows your active key combo
      separator = "", -- symbol used between a key and it's label
      group = "+", -- symbol prepended to a group
    },
    win = {
      -- don't allow the popup to overlap with the cursor
      no_overlap = true,
      -- width = 1,
      -- height = { min = 4, max = 25 },
      -- col = 0,
      -- row = math.huge,
      -- border = "none",
      padding = { 1, 2 }, -- extra window padding [top/bottom, right/left]
      title = false,
      title_pos = "center",
      zindex = 1000,
    },
  },
}

