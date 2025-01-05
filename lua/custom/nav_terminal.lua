-- moved here because nvchad M mappings bugs if we chain these calls together

Cwdhandler = {}
Cwdhandler.PreviousCWD = vim.fn.getcwd()
Cwdhandler.Status = 0
-- enter current directory and set its focus
function SetCDtoBufferCWD()
   local buffercwd = vim.fn.expand "%:p:h"

   Cwdhandler.PreviousCWD = vim.fn.getcwd()

   if Cwdhandler.Status == 0 then
      Cwdhandler.Status = 1
   elseif Cwdhandler.Status == 1 then
      Cwdhandler.Status = 0
   else
      Cwdhandler.Status = Cwdhandler.Status + 1
   end

   vim.cmd("silent! cd " .. buffercwd)
end

SwitchCache = nil
function SetBackPreviousCD()
   print(Cwdhandler.PreviousCWD)

   SwitchCache = vim.fn.getcwd()

   vim.cmd("silent! cd " .. Cwdhandler.PreviousCWD)

   Cwdhandler.PreviousCWD = SwitchCache
end


function OpenTerminalWithSplit(split_cmd)
   SetCDtoBufferCWD()
   vim.cmd(split_cmd .. " term://bash")
   vim.cmd("startinsert")
   SetBackPreviousCD()
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


vim.api.nvim_set_keymap( 
  "n",
  "gt",
	"<cmd>lua require('telescope.builtin').lsp_references()<cr>",
   { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
   "n",
   "<leader>wth",
   ":lua OpenTerminalWithSplit('belowright split')<CR>",
   { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
   "n",
   "<leader>wtj",
   ":lua OpenTerminalWithSplit('aboveleft split')<CR>",
   { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
   "n",
   "<leader>wtl",
   ":lua OpenTerminalWithSplit('vsplit')<CR>",
   { noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
   "n",
   "<leader>wtk",
   ":lua OpenTerminalWithSplit('leftabove vsplit')<CR>",
   { noremap = true, silent = true }
)
