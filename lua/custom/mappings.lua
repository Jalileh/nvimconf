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

		["<leader>tg"] = { "<cmd>Telescope live_grep_args<CR>", "Telescope live_grep (ARG)" },
		["<leader>tb"] = { "<cmd>Telescope current_buffer_fuzzy_find<CR>", "Telescope current_buffer_fuzzy_find" },
		["<leader>ut"] = { "<cmd>UndotreeToggle<CR> | <cmd>UndotreeFocus<CR>", "Toggle undotree and focus" },

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
