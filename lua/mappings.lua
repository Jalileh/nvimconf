local keymap = vim.keymap
local api = vim.api
local uv = vim.loop
 
 
 
 -- Set keymap
local opts = { noremap = true, silent = true }
api.nvim_set_keymap('n', '<A-f>', '<cmd>lua require("telescope.builtin").find_files()<CR>', opts)