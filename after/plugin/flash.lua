vim.keymap.set('n', 's', function()
  require("flash").jump()
end, { desc = "Flash Jump" })



vim.keymap.set('n', '<leader>t', function()
  require("flash").treesitter()
end, { desc = "Flash sitter" })
