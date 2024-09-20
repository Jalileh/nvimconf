local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
   -- {
   --       event = "VeryLazy",
   --    "dense-analysis/ale",
   --    config = function()
   --       -- Configuration goes here.
   --       local g = vim.g
   --       local b = vim.b
   --
   --       -- " Only run linters named in ale_linters settings."
   --       g.ale_linters_explicit = 1
   --
   --       -- Disable all linters
   --
   --       -- Enable specific linters for desired file types
   --
   --       vim.g.ale_linters = {
   --          sh = { "bashate", "cspell", "language_server", "shell", "shellcheck" },
   --          bash = { "bashate", "cspell", "language_server", "shell", "shellcheck" },
   --          cpp = { "clangtidy" },
   --       }
   --
   --       g.ale_lint_on_text_changed = "never"
   --       g.ale_lint_on_insert_leave = 1
   --       g.ale_lint_on_enter = 0
   --    end,
   -- },

   -- {
   --    event = "VeryLazy",
   --    "mfussenegger/nvim-dap",
   --    config = function()
   --       require("nvim-web-devicons").get_icons()
   --    end,
   -- },
   --
   -- {
   --    "folke/trouble.nvim",
   --    dependencies = { "nvim-tree/nvim-web-devicons" },
   --    lazy = false,
   -- },
   --
   -- {
   --    "ray-x/lsp_signature.nvim",
   --    event = "VeryLazy",
   --    opts = {},
   --    config = function(_, opts)
   --       require("lsp_signature").setup(opts)
   --    end,
   -- },
   --
   -- nvchad edits below
   --
   -- {
   --    "neovim/nvim-lspconfig",
   --    config = function()
   --       require "plugins.configs.lspconfig"
   --       require "custom.configs.lspconfig"
   --    end, -- Override to setup mason-lspconfig
   -- },
   --
   -- override plugin configs
   {
      "williamboman/mason.nvim",
      opts = overrides.mason,
   },

   {
      "nvim-treesitter/nvim-treesitter",
      opts = overrides.treesitter,
   },

   {
      "nvim-tree/nvim-tree.lua",
      opts = overrides.nvimtree,
   },

   -- Install a plugin
   {
      "max397574/better-escape.nvim",
      event = "InsertEnter",
      config = function()
         require("better_escape").setup()
      end,
   },

   {

      event = "VeryLazy",
      "stevearc/conform.nvim",
      --  for users those who want auto-save conform + lazyloading!
      -- event = "BufWritePre"
      config = function()
         require "custom.configs.conform"
      end,
   },
   {
      "mbbill/undotree",
      lazy = false,
   },

   -- To make a plugin not be loaded
   -- {
   --   "NvChad/nvim-colorizer.lua",
   --   enabled = false
   -- },

   -- All NvChad plugins are lazy-loaded by default
   -- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
   -- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
   -- {
   --   "mg979/vim-visual-multi",
   --   lazy = false,
   -- }
}

return plugins
