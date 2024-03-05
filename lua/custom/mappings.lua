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
    }

  },
  v = {
    [">"] = { ">gv", "indent"},
  },
}

 
-- Define your custom mappings
M.custom_mappings = {
  n = {
  
    ["<leader>tg"] = {"<cmd>Telescope live_grep<CR>", "Telescope live_grep"},
    ["<leader>tb"] = {"<cmd>Telescope current_buffer_fuzzy_find<CR>", "Telescope current_buffer_fuzzy_find"},
    -- ["<leader>tu"] = {"<cmd>UndotreeToggle<CR> | <cmd>UndotreeFocus<CR>", "Toggle undotree and focus"},
    ["<leader>wtd"] = {"<cmd>vsplit term://%:p:h//bash<CR>", "Open bash terminal split"},
    ["<leader>wtw"] = {"<cmd>lua open_bash_terminal_start_dir()<CR>", "Open Bash terminal in current directory"},
    ["<leader>gc"] = {"<cmd>lua generate_organizing_text()<CR>", "Generate organizing text in C++ file"}
  },
 
}

-- Function to open a Bash terminal split to the right using the directory where Neovim was started
function open_bash_terminal_start_dir()
  local start_dir = vim.fn.getcwd()
  start_dir = start_dir:gsub("/", "\\")
  vim.cmd('vsplit | terminal bash -c "cd \'' .. start_dir .. '\' && exec $SHELL"')
end

-- Function to generate organizing text in a C++ file
function generate_organizing_text()
  local section_name = vim.fn.input('Enter section name: ')
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
    " "
  }
  local current_line = vim.fn.line('.')
  for _, line in ipairs(organizing_text) do
      vim.api.nvim_buf_set_lines(0, current_line - 1, current_line - 1, true, {line})
  end
  vim.cmd(tostring(current_line + #organizing_text) .. 'j')
end

 

return M
