vim.g.mapleader = " "
vim.keymap.set("n","<leader>pv", vim.cmd.Ex)
vim.api.nvim_set_keymap('n', '<C-j>', '10j', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', '<C-k>', '10k', { noremap = true, silent = true })




vim.api.nvim_set_keymap('n', ',s', ':split<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ',v', ':vsplit<CR>', { noremap = true, silent = true })
vim.keymap.set('n', '<leader>e', vim.diagnostic.open_float, { noremap = true, silent = true })

