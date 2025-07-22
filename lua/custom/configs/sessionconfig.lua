local session_manager = require("session_manager")
local U = require("session_manager.utils")
local vim = vim;

session_manager.setup({
	-- Your preferred directory for sessions
	sessions_dir = U.get_sessions_dir() .. "/custom_sessions", -- Example: stores sessions in ~/.local/share/nvim/sessions/custom_sessions

	-- Auto-save session on VimExit
	autosave_on_session_substitute = true,
	autosave_on_default_session_restore = false,
	autosave_on_last_session_restore = false,
	autosave_on_change_dir = false,
	autosave_on_exit = true, -- Crucial for saving state when you quit Neovim

	-- Auto-restore last session on VimEnter
	autoless_on_start = true, -- Automatically restore the last session on startup

	-- Customize ignored files/buffers
	exclude_dirs = {
		vim.fn.stdpath("config"),      -- Ignore your Neovim config directory
		vim.fn.stdpath("data") .. "/lazy", -- Ignore Lazy.nvim's data directory
		-- Add any other directories you want to exclude from session saving
	},
	-- You can also exclude specific filetypes or buftypes
	-- excluded_filetypes = { "gitcommit", "gitrebase", "markdown" },
	-- excluded_buftypes = { "nofile", "prompt", "terminal" },

	-- UI configuration (optional)
	-- theme = "sky", -- "sky", "moon", "solarized", "nord", "dracula", "gruvbox", "catppuccin", "auto"
	-- border = "rounded",

	-- Keymaps for session management (optional, but highly recommended)
	-- You can integrate these with your existing keymap setup
	-- For example, in your custom/mappings.lua or directly here
	-- vim.keymap.set("n", "<Leader>ss", session_manager.save_current_session, { desc = "Save current session" })
	-- vim.keymap.set("n", "<Leader>sl", session_manager.load_session, { desc = "Load session" })
	-- vim.keymap.set("n", "<Leader>sd", session_manager.delete_session, { desc = "Delete session" })
	-- vim.keymap.set("n", "<Leader>sc", session_manager.switch_session, { desc = "Switch session" })
	-- vim.keymap.set("n", "<Leader>sr", session_manager.restore_last_session, { desc = "Restore last session" })
})

-- Optional: Set up keymaps if you don't have a separate keymap config
vim.keymap.set("n", "<Leader>ss", session_manager.save_current_session, { desc = "Save current session" })
vim.keymap.set("n", "<Leader>sl", session_manager.load_session, { desc = "Load session" })
vim.keymap.set("n", "<Leader>sd", session_manager.delete_session, { desc = "Delete session" })
vim.keymap.set("n", "<Leader>sc", session_manager.switch_session, { desc = "Switch session" })
vim.keymap.set("n", "<Leader>sr", session_manager.restore_last_session, { desc = "Restore last session" })

-- You can also define commands if you prefer
vim.api.nvim_create_user_command("SessionSave", session_manager.save_current_session,
	{ nargs = "?", complete = "custom,session_manager.complete_sessions" })
vim.api.nvim_create_user_command("SessionLoad", session_manager.load_session,
	{ nargs = "?", complete = "custom,session_manager.complete_sessions" })
vim.api.nvim_create_user_command("SessionDelete", session_manager.delete_session,
	{ nargs = "?", complete = "custom,session_manager.complete_sessions" })
vim.api.nvim_create_user_command("SessionSwitch", session_manager.switch_session,
	{ nargs = "?", complete = "custom,session_manager.complete_sessions" })
vim.api.nvim_create_user_command("SessionRestoreLast", session_manager.restore_last_session, {})
