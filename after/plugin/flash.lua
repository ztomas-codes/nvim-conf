vim.keymap.set('n', 's', function()
  require("flash").jump()
end, { desc = "Flash Jump" })

vim.keymap.set('n', '<leader>t', function()
  require("flash").treesitter()
end, { desc = "Flash sitter" })

-- Map <C-j> to flash.jump()
vim.keymap.set('n', '<C-j>', function()
  require("flash").jump()
end, { desc = "Flash Jump (Ctrl-J)" })

-- Map <C-k> to flash.treesitter()
vim.keymap.set('n', '<C-k>', function()
  require("flash").jump()
end, { desc = "Flash Treesitter (Ctrl-K)" })
