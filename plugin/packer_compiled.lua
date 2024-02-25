-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

_G._packer = _G._packer or {}
_G._packer.inside_compile = true

local time
local profile_info
local should_profile = false
if should_profile then
  local hrtime = vim.loop.hrtime
  profile_info = {}
  time = function(chunk, start)
    if start then
      profile_info[chunk] = hrtime()
    else
      profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
    end
  end
else
  time = function(chunk, start) end
end

local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end
  if threshold then
    table.insert(results, '(Only showing plugins that took longer than ' .. threshold .. ' ms ' .. 'to load)')
  end

  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "C:\\Users\\fayar\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.1703942320\\share\\lua\\5.1\\?.lua;C:\\Users\\fayar\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.1703942320\\share\\lua\\5.1\\?\\init.lua;C:\\Users\\fayar\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.1703942320\\lib\\luarocks\\rocks-5.1\\?.lua;C:\\Users\\fayar\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.1703942320\\lib\\luarocks\\rocks-5.1\\?\\init.lua"
local install_cpath_pattern = "C:\\Users\\fayar\\AppData\\Local\\Temp\\nvim\\packer_hererocks\\2.1.1703942320\\lib\\lua\\5.1\\?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  ["TrueZen.nvim"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\TrueZen.nvim",
    url = "https://github.com/Pocco81/TrueZen.nvim"
  },
  diffconflicts = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\diffconflicts",
    url = "https://github.com/whiteinge/diffconflicts"
  },
  ["dracula.nvim"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\dracula.nvim",
    url = "https://github.com/Mofiqul/dracula.nvim"
  },
  ["guihua.lua"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\guihua.lua",
    url = "https://github.com/ray-x/guihua.lua"
  },
  kommentary = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\kommentary",
    url = "https://github.com/b3nj5m1n/kommentary"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\lualine.nvim",
    url = "https://github.com/hoob3rt/lualine.nvim"
  },
  ["navigator.lua"] = {
    config = { "\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14navigator\frequire\0" },
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\navigator.lua",
    url = "https://github.com/ray-x/navigator.lua"
  },
  ["nvim-autopairs"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-autopairs",
    url = "https://github.com/windwp/nvim-autopairs"
  },
  ["nvim-compe"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-compe",
    url = "https://github.com/hrsh7th/nvim-compe"
  },
  ["nvim-lspconfig"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-toggleterm.lua"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-toggleterm.lua",
    url = "https://github.com/akinsho/nvim-toggleterm.lua"
  },
  ["nvim-treesitter"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = false,
    needs_bufread = false,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\opt\\nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["popup.nvim"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\popup.nvim",
    url = "https://github.com/nvim-lua/popup.nvim"
  },
  ["telescope.nvim"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["vim-doge"] = {
    loaded = true,
    path = "C:\\Users\\fayar\\AppData\\Local\\nvim-data\\site\\pack\\packer\\start\\vim-doge",
    url = "https://github.com/kkoomen/vim-doge"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: navigator.lua
time([[Config for navigator.lua]], true)
try_loadstring("\27LJ\2\n7\0\0\3\0\3\0\0066\0\0\0'\2\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\14navigator\frequire\0", "config", "navigator.lua")
time([[Config for navigator.lua]], false)

_G._packer.inside_compile = false
if _G._packer.needs_bufread == true then
  vim.cmd("doautocmd BufRead")
end
_G._packer.needs_bufread = false

if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end
