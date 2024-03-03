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

api.nvim_set_keymap('n', '<leader>tt', '<cmd>TroubleToggle<CR>', { noremap = true })


api.nvim_set_keymap('n', '<leader>tu', '<cmd>UndotreeToggle<CR> | <cmd>UndotreeFocus<CR>' , { noremap = true })


api.nvim_set_keymap('n', '<leader>wtd', '<cmd>vsplit term://%:p:h//bash<CR>' , { noremap = true })


api.nvim_set_keymap('t', '<C-t>', '<C-\\><C-n>', {noremap = true})

-- Function to open a Bash terminal split to the right using the directory where Neovim was started
function open_bash_terminal_start_dir()
  -- Get the directory where Neovim was started
  local start_dir = vim.fn.getcwd()

  -- Normalize the directory path for the current operating system
  start_dir = start_dir:gsub("/", "\\")

  -- Open a new vertical split and open a terminal in the specified directory
  vim.cmd('vsplit | terminal bash -c "cd \'' .. start_dir .. '\' && exec $SHELL"')
end

-- Map a key to open the Bash terminal split to the right using the directory where Neovim was started
api.nvim_set_keymap('n', '<leader>wtw', ':lua open_bash_terminal_start_dir()<CR>', {noremap = true, silent = true})

-- Function to generate organizing text in a C++ file
-- Function to generate organizing text in a C++ file
-- Function to generate organizing text in a C++ file
function generate_organizing_text()
  -- Prompt the user to input the section name
  local section_name = vim.fn.input('Enter section name: ')

  -- Define the organizing text with the provided section name
  local organizing_text = {
      "                ",
      "//             @",
      "//           _____",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//",
      "//           -  -",
      "//",
      "//            @@",
      "                "
  }
  
  -- Calculate the maximum length of the section name
  local max_length = 0

  -- Find the maximum length of the section name
  for _, line in ipairs(organizing_text) do
      local name_length = line:sub(6):find("%S")
      if name_length then
          max_length = math.max(max_length, #line - name_length + 1)
      end
  end

  -- Calculate the padding for aligning the section name and @@
  local padding = math.floor((max_length - #section_name) / 2)
  local name_padding = string.rep(" ", padding)

  -- Adjust the lines to align the section name and @@
  organizing_text[12] = string.format("//     %s%s", name_padding, section_name)

  -- Get the current line number
  local current_line = vim.fn.line('.')

  -- Insert each line of the organizing text above the current line
  for _, line in ipairs(organizing_text) do
      vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, true, {line})
  end

  -- Move cursor to the line below the last line of the inserted text
  vim.cmd(tostring(current_line + #organizing_text) .. 'j')

end


-- Map a key to generate organizing text in a C++ file
api.nvim_set_keymap('n', '<leader>gc', ':lua generate_organizing_text()<CR>', {noremap = true, silent = true})
