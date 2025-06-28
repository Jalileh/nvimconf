local overrides = require "custom.configs.overrides"

---@type NvPluginSpec[]
local plugins = {
	{
		event = "VeryLazy",
		"dense-analysis/ale",
		config = function()
			-- Configuration goes here.
			local g = vim.g
			local b = vim.b

			-- " Only run linters named in ale_linters settings."
			g.ale_linters_explicit = 1

			-- Disable all linters

			-- Enable specific linters for desired file types

			vim.g.ale_linters = {
				sh = { "bashate", "cspell", "language_server", "shell", "shellcheck" },
				bash = { "bashate", "cspell", "language_server", "shell", "shellcheck" },
				cpp = { "clangtidy" },
			}

			g.ale_lint_on_text_changed = "never"
			g.ale_lint_on_insert_leave = 0
			g.ale_lint_on_enter = 1
			g.ale_lint_on_save = 1
		end,
	},
	{
		"zbirenbaum/copilot.lua",
		cmd = "Copilot",
		event = "InsertEnter",
		config = function()
			require("copilot").setup({
				suggestion = { enabled = false },
				panel = { enabled = false },
			})
		end,
	},

	{
		"zbirenbaum/copilot-cmp",
		dependencies = { "copilot.lua", "nvim-cmp" },
		lazy = false,
		config = function()
			require("copilot_cmp").setup()
		end,
	},
	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false, -- set this to "*" if you want to always pull the latest change, false to update on release
		opts = {

			ui = {
				file_width = 30,
				output = {
					height = 15,
					width = 80,
				},
				relative = "win",
				"editor"
			},
			provider = "copilot",
			auto_suggestions_provider = "copilot",
			behaviour = {
				modifiable = true,
				auto_suggestions = false,
				enable_cursor_planning_mode = true
			},
		},


		-- if you want to build from source then do `make BUILD_FROM_SOURCE=true`
		build = "make",
		-- build = "powershell -ExecutionPolicy Bypass -File Build.ps1 -BuildFromSource false" -- for windows
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			--- The below dependencies are optional,
			"hrsh7th/nvim-cmp",      -- autocompletion for avante commands and mentions
			"nvim-tree/nvim-web-devicons", -- or echasnovski/mini.icons
			"zbirenbaum/copilot.lua", -- for providers='copilot'

			{
				-- support for image pasting
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					-- recommended settings


					default = {
						embed_image_as_base64 = true,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						-- required for Windows users
						use_absolute_path = true,
					},
				},
			},
			{
				-- Make sure to set this up properly if you have lazy=true
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
	},

	{
		"ray-x/lsp_signature.nvim",
		"nvim-lua/plenary.nvim",
		event = "VeryLazy",
		opts = {},
		config = function(_, opts)
			require("lsp_signature").setup(opts)
		end,
	},


	{
		"neovim/nvim-lspconfig",
		config = function()
			require "plugins.configs.lspconfig"
			require "custom.configs.lspconfig"
		end, -- Override to setup mason-lspconfig
	},


	{
		"williamboman/mason.nvim",
		opts = overrides.mason,
	},

	{
		"nvim-treesitter/nvim-treesitter",
		opts = overrides.treesitter,
	},

	{

		event = "VeryLazy",
		"nvim-tree/nvim-tree.lua",
		opts = overrides.nvimtree,
	},


	-- Install a plugin



	{

		event = "VeryLazy",
		"stevearc/conform.nvim",
		--  for users those who want auto-save conform + lazyloading!
		-- event = "BufWritePre"
		config = function()
			require "custom.configs.conform"
		end,
	},


	{
		"mbbill/undotree",
		lazy = false,
	},

	{
		lazy = false,
		"tpope/vim-fugitive",
		dependencies = { "nvim-tree/nvim-web-devicons" },
	},


	{
		lazy = false,
		"nvim-telescope/telescope-live-grep-args.nvim",
		dependencies = {
			"nvim-telescope/telescope.nvim",
		},
		config = function()
			local telescope = require("telescope")
			local actions = require("telescope.actions")
			local lga_actions = require("telescope-live-grep-args.actions")

			telescope.setup({
				extensions = {
					live_grep_args = {
						auto_quoting = true,
						mappings = {
							i = {
								["<C-k>"] = lga_actions.quote_prompt(),
								["<C-i>"] = lga_actions.quote_prompt({ postfix = " --iglob " }),
								["<C-space>"] = actions.to_fuzzy_refine,
							},
						},
					},
				},
			})

			telescope.load_extension("live_grep_args")
		end,
	},
	-- nvim v0.8.0
	{
		"kdheepak/lazygit.nvim",
		lazy = false,
		cmd = {
			"LazyGit",
			"LazyGitConfig",
			"LazyGitCurrentFile",
			"LazyGitFilter",
			"LazyGitFilterCurrentFile",
		},
		keys = {
			{ "<leader>lg", "<cmd>LazyGit<cr>", desc = "LazyGit" }
		},
		dependencies = {
			"nvim-telescope/telescope.nvim",
			"nvim-lua/plenary.nvim",
		},

		config = function()
			require("telescope").load_extension("lazygit")
		end,
	},

	{
		"folke/trouble.nvim",
		opts = {}, -- for default options, refer to the configuration section for custom setup.
		cmd = "Trouble",
		-- config in custom/mappings.lua instead
	},

	-- more themes

	{
		"scottmckendry/cyberdream.nvim",

	},




	-- To make a plugin not be loaded
	-- {
	--   "NvChad/nvim-colorizer.lua",
	--   enabled = false
	-- },

	-- All NvChad plugins are lazy-loaded by default
	-- For a plugin to be loaded, you will need to set either `ft`, `cmd`, `keys`, `event`, or set `lazy = false`
	-- If you want a plugin to load on startup, add `lazy = false` to a plugin spec, for example
	-- {
	--   "mg979/vim-visual-multi",
	--   lazy = false,
	-- }
}

return plugins
