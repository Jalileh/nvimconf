---@type MappingsTable

Cwdhandler = {}
Cwdhandler.PreviousCWD = vim.fn.getcwd()
Cwdhandler.Status = 0
-- enter current directory and set its focus
function SetCDtoBufferCWD()
   local buffercwd = vim.fn.expand "%:p:h"
   print("Neovim CWD pointed to: " .. vim.fn.expand "%:p:h")

   Cwdhandler.PreviousCWD = vim.fn.getcwd()

   if Cwdhandler.Status == 0 then
      Cwdhandler.Status = 1
   elseif Cwdhandler.Status == 1 then
      Cwdhandler.Status = 0
   else
      Cwdhandler.Status = Cwdhandler.Status + 1
   end

   vim.cmd("cd " .. buffercwd)
end

SwitchCache = "unset"
function SetBackPreviousCD()
   print(Cwdhandler.PreviousCWD)

   SwitchCache = vim.fn.getcwd()

   vim.cmd("cd " .. Cwdhandler.PreviousCWD)

   Cwdhandler.PreviousCWD = SwitchCache
end

-- Function to generate organizing text in a C++ file
function generate_organizing_text()
   local section_name = "@s." .. vim.fn.input "Enter section name: "

   local organizing_text = {
      " ",
      "////       ",
      "////       ",
      "////       ",
      "////       ",
      "////  " .. section_name,
      "////",
      string.rep("/", 70),
      string.rep("/", 70),
      " ",
   }

   local current_line = vim.fn.line "."
   for _, line in ipairs(organizing_text) do
      vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, true, { line })
   end

   vim.cmd(tostring(current_line + #organizing_text) .. "j")
end

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

      ["<leader>wcd"] = { "<cmd>lua SetCDtoBufferCWD()<CR>", "Point Neovim to the buffer CWD" },
      -- switchback to last cwd
      ["<leader>wcp"] = { "<cmd>lua SetBackPreviousCD()<CR>", "Point Neovim to Previous Cached CWD" },


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
