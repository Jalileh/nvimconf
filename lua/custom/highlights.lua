-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

---@type Base46HLGroupsList
M.override = {
	Comment = {
		italic = true,
	},
	LspSignatureActiveParameter = {
		fg = "#FFFFFF", -- This sets the foreground (text) color to pure white.
		-- You can experiment with other light colors like "#FFFF00" (yellow),
		-- or "#00FFFF" (cyan) if white doesn't provide enough contrast with your background.

	},
}

---@type HLTable
M.add = {
	NvimTreeOpenedFolderName = { fg = "green", bold = true },
}

return M
