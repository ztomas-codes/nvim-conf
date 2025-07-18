vim.g.mapleader = " "
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
    local lazyrepo = "https://github.com/folke/lazy.nvim.git"
    local out = vim.fn.system({"git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath})
    if vim.v.shell_error ~= 0 then
        vim.api.nvim_echo(
            {
                {"Failed to clone lazy.nvim:\n", "ErrorMsg"},
                {out, "WarningMsg"},
                {"\nPress any key to exit..."}
            },
            true,
            {}
        )
        vim.fn.getchar()
        os.exit(1)
    end
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        "nvim-telescope/telescope.nvim",
        tag = "0.1.4",
        dependencies = {{"nvim-lua/plenary.nvim"}, {"nvim-telescope/telescope-live-grep-args.nvim"}},
        config = function()
            local telescope = require("telescope")
            telescope.load_extension("live_grep_args")
        end
    },
    {
        "rose-pine/neovim",
        name = "rose-pine",
        config = function()
            vim.cmd("colorscheme rose-pine")
        end
    },
    {
        "nvim-lualine/lualine.nvim",
        dependencies = {"nvim-tree/nvim-web-devicons", lazy = true}
    },
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    {
      "NeogitOrg/neogit",
      dependencies = {
        "nvim-lua/plenary.nvim",
        "sindrets/diffview.nvim",
        "nvim-telescope/telescope.nvim", 
      },
    },
    "nvim-treesitter/playground",
    "christoomey/vim-tmux-navigator",
    "theprimeagen/harpoon",
    "mbbill/undotree",
    "tpope/vim-fugitive",
    'lewis6991/gitsigns.nvim',
    'tpope/vim-surround', 
    "hrsh7th/nvim-cmp",
    "sindrets/diffview.nvim",
    "hrsh7th/cmp-nvim-lsp",
    "L3MON4D3/LuaSnip",
    "saadparwaiz1/cmp_luasnip",
    "tpope/vim-dadbod",
    "kristijanhusak/vim-dadbod-completion",
    "kristijanhusak/vim-dadbod-ui",
    "jose-elias-alvarez/null-ls.nvim",
    "MunifTanjim/prettier.nvim",
    "rafamadriz/friendly-snippets",
    "folke/flash.nvim",
    "akinsho/toggleterm.nvim",
    {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
        "neovim/nvim-lspconfig"
    },
    "mfussenegger/nvim-jdtls",
    "FabijanZulj/blame.nvim",
    {
  -- "yetone/avante.nvim",
  -- event = "VeryLazy",
  -- lazy = false,
  -- version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
  -- opts = {
  --   -- add any opts here
  -- },
  -- -- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
  -- build = "make",
  -- -- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
  -- dependencies = {
  --   "stevearc/dressing.nvim",
  --   "nvim-lua/plenary.nvim",
  --   "MunifTanjim/nui.nvim",
  --   --- The below dependencies are optional,
  --   -- "hrsh7th/nvim-cmp", -- autocompletion for avante commands and mentions
  --   "nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
  --   "zbirenbaum/copilot.lua", -- for providers='copilot'
  --   {
  --     -- support for image pasting
  --     "HakonHarnes/img-clip.nvim",
  --     event = "VeryLazy",
  --     opts = {
  --       -- recommended settings
  --       default = {
  --         embed_image_as_base64 = false,
  --         prompt_for_file_name = false,
  --         drag_and_drop = {
  --           insert_mode = true,
  --         },
  --         -- required for Windows users
  --         use_absolute_path = true,
  --       },
  --     },
  --   },
  --   {
  --     -- Make sure to set this up properly if you have lazy=true
  --     'MeanderingProgrammer/render-markdown.nvim',
  --     opts = {
  --       file_types = { "markdown", "Avante" },
  --     },
  --     ft = { "markdown", "Avante" },
  --   },
  -- },
}
}

require("lazy").setup(plugins, {
    rocks = {enabled = false} 
})

