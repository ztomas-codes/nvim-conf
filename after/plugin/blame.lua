require('blame').setup {
    mappings = {
        commit_info = "i",
        stack_push = "<TAB>",
        stack_pop = "<BS>",
        show_commit = "<CR>",
        close = { "<esc>", "q" },
    }
}

vim.api.nvim_set_keymap('n', '<leader>B', ':BlameToggle<CR>', { noremap = true, silent = true })

