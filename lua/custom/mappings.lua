---@type MappingsTable
local M = {}

M.general = {
   n = {
      [";"] = { ":", "enter command mode", opts = { nowait = true } },

      --  format with conform
      ["<leader>fm"] = {
         function()
            require("conform").format()
         end,
         "formatting",
      },
   },
   v = {
      [">"] = { ">gv", "indent" },
   },
}

-- Define your custom mappings


M.custom_mappings = {

   n = {

      ["<leader>tg"] = { "<cmd>Telescope live_grep<CR>", "Telescope live_grep" },
      ["<leader>tb"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Telescope current_buffer_fuzzy_find" },
      ["<leader>ut"] = { "<cmd>UndotreeToggle<CR> | <cmd>UndotreeFocus<CR>", "Toggle undotree and focus" },

      ["<leader>wtdk"] = {
         "<cmd>lua SetCDtoBufferCWD()<CR> | <cmd>aboveleft  split term://%:p:h//bash<CR> | <cmd>lua SetBackPreviousCD()<CR>",
         "Open bash terminal split in buffer ",
      },
      ["<leader>wtdj"] = {
         "<cmd>lua SetCDtoBufferCWD()<CR> | <cmd>belowright split term://%:p:h//bash<CR> | <cmd>lua SetBackPreviousCD()<CR>",
         "Open bash terminal split in buffer ",
      },
      ["<leader>wtdl"] = {
         "<cmd>lua SetCDtoBufferCWD()<CR> | <cmd>leftabove vsplit term://%:p:h//bash<CR> | <cmd>lua SetBackPreviousCD()<CR>",
         "Open bash terminal split in buffer ",
      },
      ["<leader>wtdh"] = {
         "<cmd>lua SetCDtoBufferCWD()<CR> | <cmd>vsplit term://%:p:h//bash<CR> | <cmd>lua SetBackPreviousCD()<CR>",
         "Open bash terminal split in buffer ",
      },

      ["<leader>wtwk"] = {
         " <cmd>aboveleft  split term:////bash<CR> ",
         "Open bash terminal split in buffer ",
      },
      ["<leader>wtwj"] = {
         " <cmd>belowright split term:////bash<CR> ",
         "Open bash terminal split in buffer ",
      },
      ["<leader>wtwl"] = {
         " <cmd>leftabove vsplit term:////bash<CR> ",
         "Open bash terminal split in buffer ",
      },
      ["<leader>wtwh"] = {
         " <cmd>vsplit term:////bash<CR> ",
         "Open bash terminal split in buffer ",
      },


      ["<leader>gc"] = { "<cmd>lua generate_organizing_text()<CR>", "Generate organizing section in C++ file" },
      ["<leader>tt"] = { "<cmd>Trouble diagnostics toggle<cr>", "toggle trouble" },

      -- keys = {
      --    {
      --       "<leader>xx",
      --       "<cmd>Trouble diagnostics toggle<cr>",
      --       desc = "Diagnostics (Trouble)",
      --    },
      --    {
      --       "<leader>xX",
      --       "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",
      --       desc = "Buffer Diagnostics (Trouble)",
      --    },
      --    {
      --       "<leader>cs",
      --       "<cmd>Trouble symbols toggle focus=false<cr>",
      --       desc = "Symbols (Trouble)",
      --    },
      --    {
      --       "<leader>cl",
      --       "<cmd>Trouble lsp toggle focus=false win.position=right<cr>",
      --       desc = "LSP Definitions / references / ... (Trouble)",
      --    },
      --    {
      --       "<leader>xL",
      --       "<cmd>Trouble loclist toggle<cr>",
      --       desc = "Location List (Trouble)",
      --    },
      --    {
      --    "<leader>xQ",
      --    "<cmd>Trouble qflist toggle<cr>",
      --    desc = "Quickfix List (Trouble)",
      -- },
      -- },
      -- enter current directory and set its focus
      ["<leader>wcd"] = { "<cmd>lua SetCDtoBufferCWD()<CR>", "Point Neovim to the buffer CWD" },
      -- switchback to last cwd
      ["<leader>wcp"] = { "<cmd>lua SetBackPreviousCD()<CR>", "Point Neovim to Previous Cached CWD" },

      -- ["gD"] = {
      --    function()
      --       vim.lsp.buf.declaration()
      --    end,
      --    "LSP declaration",
      -- },
      --
      -- ["gd"] = {
      --    function()
      --       vim.lsp.buf.definition()
      --    end,
      --    "LSP definition",
      -- },
      --
      -- ["K"] = {
      --    function()
      --       vim.lsp.buf.hover()
      --    end,
      --    "LSP hover",
      -- },
      --
      -- ["gi"] = {
      --    function()
      --       vim.lsp.buf.implementation()
      --    end,
      --    "LSP implementation",
      -- },
      --
      -- ["<leader>ls"] = {
      --    function()
      --       vim.lsp.buf.signature_help()
      --    end,
      --    "LSP signature help",
      -- },
      --
      -- ["<leader>D"] = {
      --    function()
      --       vim.lsp.buf.type_definition()
      --    end,
      --    "LSP definition type",
      -- },
      --
      -- ["<leader>ra"] = {
      --    function()
      --       require("nvchad.renamer").open()
      --    end,
      --    "LSP rename",
      -- },
      --
      -- ["<leader>ca"] = {
      --    function()
      --       vim.lsp.buf.code_action()
      --    end,
      --    "LSP code action",
      -- },
      --
      -- ["gr"] = {
      --    function()
      --       vim.lsp.buf.references()
      --    end,
      --    "LSP references",
      -- },
      --
      -- ["<leader>lf"] = {
      --    function()
      --       vim.diagnostic.open_float { border = "rounded" }
      --    end,
      --    "Floating diagnostic",
      -- },
      --
      -- ["[d"] = {
      --    function()
      --       vim.diagnostic.goto_prev { float = { border = "rounded" } }
      --    end,
      --    "Goto prev",
      -- },
      --
      -- ["]d"] = {
      --    function()
      --       vim.diagnostic.goto_next { float = { border = "rounded" } }
      --    end,
      --    "Goto next",
      -- },

      -- ["<leader>q"] = {
      --    function()
      --       vim.diagnostic.setloclist()
      --    end,
      --    "Diagnostic setloclist",
      -- },
      --
      -- ["<leader>wa"] = {
      --    function()
      --       vim.lsp.buf.add_workspace_folder()
      --    end,
      --    "Add workspace folder",
      -- },
      --
      -- ["<leader>wr"] = {
      --    function()
      --       vim.lsp.buf.remove_workspace_folder()
      --    end,
      --    "Remove workspace folder",
      -- },
      --
      -- ["<leader>wl"] = {
      --    function()
      --       print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      --    end,
      --    "List workspace folders",
      -- },

   },



   -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions


   v = {
      ["<leader>ca"] = {
         function()
            vim.lsp.buf.code_action()
         end,
         "LSP code action",
      },
   },

}

return M
