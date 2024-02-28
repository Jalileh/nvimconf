local keymap = vim.keymap
local api = vim.api
local uv = vim.loop



 -- Set keymap
local opts = { noremap = true, silent = true }
-- api.nvim_set_keymap('n', '<A-f>', '<cmd>lua require("telescope.builtin").find_files()<CR>', opts)

-- Load Telescope
api.nvim_set_keymap('n', '<leader>tf', '<cmd>Telescope find_files<CR>', { noremap = true })
api.nvim_set_keymap('n', '<leader>tg', '<cmd>Telescope live_grep<CR>', { noremap = true })

api.nvim_set_keymap('n', '<leader>tb', '<cmd>Telescope current_buffer_fuzzy_find<CR>', { noremap = true })

api.nvim_set_keymap('n', '<leader>tu', '<cmd>UndotreeToggle<CR> | <cmd>UndotreeFocus<CR>' , { noremap = true })

