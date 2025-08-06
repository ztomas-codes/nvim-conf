local builtin = require('telescope.builtin')
local pickers = require('telescope.pickers')
local finders = require('telescope.finders')
local sorters = require('telescope.sorters')

-- Funkce pro zkrácení cesty souboru tak, aby se zobrazily první dvě složky
local function shorten_path(full_path)
    local first, second, last = full_path:match("([^/]+)/([^/]+)/([^/]+)$") -- Získá první, druhou a poslední část cesty
    if second then
        return first .. "/" .. second .. "/" .. last -- Vytvoří nový zkrácený název
    else
        return full_path -- V případě, že není druhá složka, vrátí plnou cestu
    end
end

local function custom_find_files(opts)
    opts = opts or {}

    opts.entry_maker = function(entry)
        -- Zkracování názvu souboru
        local filename = shorten_path(entry)

        return {
            value = entry,
            display = filename,
            ordinal = filename,
        }
    end

    -- Použití defaultního find_files, ale s vlastním entry_maker
    builtin.find_files(opts)
end

-- Klávesové zkratky
vim.keymap.set('n', 'gd', builtin.lsp_definitions, { noremap = true, silent = true })
vim.keymap.set('n', 'gr', builtin.lsp_references, {})
vim.keymap.set('n', '<leader>pf', custom_find_files, {})  -- Používáme custom_find_files
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
vim.keymap.set('n', '<leader>ps', function()
    builtin.grep_string({search = vim.fn.input("Grep > ")});
end)

vim.keymap.set('n', '<leader>ps', require("telescope").extensions.live_grep_args.live_grep_args, { noremap = true })


vim.api.nvim_set_keymap('n', ',v', ':vsplit<CR>', { noremap = true, silent = true })
vim.api.nvim_set_keymap('n', ',s', ':split<CR>', { noremap = true, silent = true })

vim.keymap.set('n', '/', '<cmd>Telescope current_buffer_fuzzy_find<cr>', { desc = 'Fuzzy find in current buffer' })
