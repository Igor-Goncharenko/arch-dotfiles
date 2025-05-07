return {
  "tikhomirov/vim-glsl",
  config = function()
    vim.api.nvim_create_autocmd(
      { "BufNewFile", "BufRead" }, {
        pattern = { "*.vs", "*.fs", "*.gs" },
        callback = function()
          vim.bo.filetype = "glsl"
        end,
      })
    end,
}
