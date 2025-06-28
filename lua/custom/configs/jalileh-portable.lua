Cwdhandler = {
	PreviousCWDs = {},
	MaxSlots = 11,
	CacheFilePath = vim.fn.stdpath('data') .. '/cwd_cache.json'
}

function Cwdhandler:LoadCache()
	local file = io.open(self.CacheFilePath, "r")
	if file then
		local contents = file:read("*a")

		local decoded = vim.fn.json_decode(contents) or {}

		for k, v in pairs(decoded) do
			self.PreviousCWDs[tostring(k)] = v
		end
		file:close()
	else
		print("No saved CWDs found")
	end


	self.PreviousCWDs["0"] = self.PreviousCWDs["0"] or vim.fn.getcwd()
end

function Cwdhandler:SaveCache()
	local contents = vim.fn.json_encode(self.PreviousCWDs)


	local file = io.open(self.CacheFilePath, "w")
	if file then
		file:write(contents)
		file:close()
	else
		print("Error writing to CWD cache file")
	end
end

function GetIndex()
	local param_1 = vim.v.count
	return param_1
end

function SetCDtoBufferCWD()
	local index = GetIndex()
	local buffercwd = vim.fn.expand("%:p:h")
	Cwdhandler.PreviousCWDs["0"] = vim.fn.getcwd()
	vim.cmd("silent! cd " .. buffercwd)
	print("Switched to: " .. buffercwd)


	if index > 0 then
		SaveCurrentDirToCache(index)
	end
	Cwdhandler:SaveCache()
end

function SetBackPreviousCD()
	local index = GetIndex()

	if index == 0 then
		local currcwd = vim.fn.getcwd()
		vim.cmd("silent! cd " .. Cwdhandler.PreviousCWDs["0"])
		print("Switched to: " .. Cwdhandler.PreviousCWDs["0"])
		Cwdhandler.PreviousCWDs["0"] = currcwd
	elseif not Cwdhandler.PreviousCWDs[tostring(index)] then
		print("No directory saved at index " .. index)
		return
	else
		vim.cmd("silent! cd " .. Cwdhandler.PreviousCWDs[tostring(index)])
		print("Switched to: " .. Cwdhandler.PreviousCWDs[tostring(index)])
	end
	Cwdhandler:SaveCache()
end

function ListCachedDirs()
	print("Cached Directories:")
	for i = 0, Cwdhandler.MaxSlots - 1 do
		if Cwdhandler.PreviousCWDs[tostring(i)] then
			print(i .. ": " .. Cwdhandler.PreviousCWDs[tostring(i)])
		else
			print(i .. ": [Empty]")
		end
	end
end

function SaveCurrentDirToCache(index)
	if index >= Cwdhandler.MaxSlots then
		print("Invalid index. Please choose a value between 1 and " .. (Cwdhandler.MaxSlots - 1))
		return
	end
	Cwdhandler.PreviousCWDs[tostring(index)] = vim.fn.getcwd()
	Cwdhandler:SaveCache()
end

function ChangeToCachedDir(index)
	if not Cwdhandler.PreviousCWDs[tostring(index)] then
		print("No directory saved at index " .. index)
		return
	end
	Cwdhandler.PreviousCWDs["0"] = vim.fn.getcwd()
	vim.cmd("silent! cd " .. Cwdhandler.PreviousCWDs[tostring(index)])
	print("Changed to directory at index " .. index .. ": " .. Cwdhandler.PreviousCWDs[tostring(index)])
	Cwdhandler:SaveCache()
end

Cwdhandler:LoadCache()

vim.api.nvim_set_keymap("n", "<leader>wcd", ":lua SetCDtoBufferCWD()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wcl", ":lua ListCachedDirs()<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>wcp", ":lua SetBackPreviousCD()<CR>", { noremap = true, silent = true })



function OpenTerminalWithSplit(split_cmd)
	SetCDtoBufferCWD()
	vim.cmd(split_cmd .. " term://bash")
	vim.cmd("startinsert")
	SetBackPreviousCD()
end

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

vim.api.nvim_set_keymap(
	"n",
	"gl",
	"<cmd>lua require('telescope.builtin').lsp_references()<cr>",
	{ noremap = true, silent = true }
)



vim.api.nvim_set_keymap(
	"i",
	"gg",
	"<Esc>",
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"t",
	"gg",
	"<C-\\><C-n>",
	{ noremap = true, silent = true }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>ld",
	"<cmd>lua require('telescope.builtin').lsp_document_symbols()<cr>",
	{ noremap = true, silent = true, desc = 'Telescope->Document Symbols' }
)

vim.api.nvim_set_keymap(
	"n",
	"<leader>lw",
	"<cmd>lua require('telescope.builtin').lsp_workspace_symbols()<cr>",
	{ noremap = true, silent = true, desc = 'Telescope->Workspace Symbols' }
)
