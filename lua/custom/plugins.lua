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
				lua = { "language_server" },
				c_sharp = { "language_server" },
			}

			g.ale_lint_on_text_changed = "never"
			g.ale_lint_on_insert_leave = 0
			g.ale_lint_on_enter = 0
			g.ale_lint_on_save = 1
		end,
	},

	--
	-- {
	-- 	"zbirenbaum/copilot.lua",
	-- 	cmd = "Copilot",
	-- 	event = "InsertEnter", -- Only load when entering insert mode, good for suggestions
	-- 	config = function()
	-- 		require('copilot').setup({
	-- 			panel = {
	-- 				enabled = true,
	-- 				auto_refresh = false,
	-- 				keymap = {
	-- 					jump_prev = "[[",
	-- 					jump_next = "]]",
	-- 					accept = "<CR>",
	-- 					refresh = "gr",
	-- 					open = "<M-CR>"
	-- 				},
	-- 				layout = {
	-- 					position = "bottom", -- | top | left | right | horizontal | vertical
	-- 					ratio = 0.4
	-- 				},
	-- 			},
	-- 			suggestion = {
	-- 				enabled = true,
	-- 				auto_trigger = true,
	-- 				hide_during_completion = true,
	-- 				debounce = 75,
	-- 				trigger_on_accept = true,
	-- 				keymap = {
	-- 					accept = "<M-l>",
	-- 					accept_word = "<M-o>",
	-- 					accept_line = "<M-u>",
	-- 					next = "<M-]>",
	-- 					prev = "<M-[>",
	-- 					dismiss = "<C-]>",
	-- 				},
	-- 			},
	-- 		})
	--
	--
	--
	-- 		-- Keymap for Copilot's own suggestion (might be useful as a fallback or if Avante is off)
	-- 	end,
	-- },
	--

	{
		"yetone/avante.nvim",
		event = "VeryLazy",
		version = false,
		opts = {
			provider = "mistral",
			behaviour = {
				enable_cursor_planning_mode = true,
			},
			cursor_applying_provider = "mistral",
			providers = {
				ollama = {
					endpoint = "http://127.0.0.1:11434",
					model = "llama3:latest",
				},
				mistral = {
					__inherited_from = "openai",
					api_key_name = "MISTRAL_API_KEY",
					endpoint = "https://api.mistral.ai/v1/",
					model = "codestral-latest",
					extra_request_body = {
						max_tokens = 4096,
					},
				},
			},
		},
		build = "make",
		dependencies = {
			"stevearc/dressing.nvim",
			"nvim-lua/plenary.nvim",
			"MunifTanjim/nui.nvim",
			"hrsh7th/nvim-cmp",
			"nvim-tree/nvim-web-devicons",
			"zbirenbaum/copilot.lua", -- This dependency ensures Copilot is loaded for Avante
			{
				"HakonHarnes/img-clip.nvim",
				event = "VeryLazy",
				opts = {
					default = {
						embed_image_as_base64 = true,
						prompt_for_file_name = false,
						drag_and_drop = {
							insert_mode = true,
						},
						use_absolute_path = true,
					},
				},
			},
			{
				'MeanderingProgrammer/render-markdown.nvim',
				opts = {
					file_types = { "markdown", "Avante" },
				},
				ft = { "markdown", "Avante" },
			},
		},
		-- Avante specific keymap for accepting suggestions from Copilot provider
		-- This is where the real "genius" fix lies
		config = function(_, opts)
			require("avante").setup(opts)

			-- Keymap for accepting Avante's auto-suggestions (from Copilot)
			-- Avante typically uses <Tab> by default for accepting its auto-suggestions.
			-- If you want to use <C-m>, you'd map it to Avante's accept function.
			vim.keymap.set("i", "<C-m>", function()
				if require("avante.ai.copilot.suggestions").is_visible() then
					require("avante.ai.copilot.suggestions").accept()
				end
			end, { desc = "Accept Avante/Copilot suggestion" })

			-- You can also try mapping to the general Avante accept function if you want it to work for any provider
			-- vim.keymap.set("i", "<C-m>", function()
			-- 	if require("avante.ui.suggestion_box").is_visible() then
			-- 		require("avante.ui.suggestion_box").accept()
			-- 	end
			-- end, { desc = "Accept Avante suggestion (general)" })
		end
	},

	{
		"neovim/nvim-lspconfig",
		config = function()
			require "plugins.configs.lspconfig"
			require "custom.configs.lspconfig"
		end, -- Override to setup mason-lspconfig
	},

	{
		"ray-x/lsp_signature.nvim",
		"nvim-lua/plenary.nvim",
		lazy = false,
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
		'rmagatti/auto-session',
		lazy = false,
		keys = {
			{ '<leader>wr', '<cmd>SessionSearch<CR>',         desc = 'Session search' },
			{ '<leader>ws', '<cmd>SessionSave<CR>',           desc = 'Save session' },
			{ '<leader>wa', '<cmd>SessionToggleAutoSave<CR>', desc = 'Toggle autosave' },
		},

		init = function()
			-- 🛠️ This ensures folds and other settings are saved
			vim.o.sessionoptions = "blank,buffers,curdir,help,tabpages,winsize,winpos,terminal,localoptions"
		end,

		---@type AutoSession.Config
		opts = {
			suppressed_dirs = { '~/', '~/Projects', '~/Downloads', '/Desktop' },
			enabled = true,              -- Enables/disables auto creating, saving and restoring
			auto_restore_last_session = false, -- On startup, loads the last saved session if session for cwd does not exist
			session_lens = {
				load_on_setup = true,     -- Initialize on startup (requires Telescope)
				picker_opts = nil,        -- Table passed to Telescope / Snacks to configure the picker. See below for more information
				mappings = {
					-- Mode can be a string or a table, e.g. {"i", "n"} for both insert and normal mode
					delete_session = { "i", "<C-D>" },
					alternate_session = { "i", "<C-S>" },
					copy_session = { "i", "<C-Y>" },
				},

				session_control = {
					control_dir = vim.fn.stdpath "data" .. "/auto_session/", -- Auto session control dir, for control files, like alternating between two sessions with session-lens
					control_filename = "session_control.json",     -- File name of the session control file
				},
			},
		}
	},
	{
		"Decodetalkers/csharpls-extended-lsp.nvim",
		-- Make sure this loads after lspconfig, and only when csharp_ls is active
		dependencies = { "neovim/nvim-lspconfig" },
		event = "VeryLazy", -- Or "LspAttach" if you want it loaded specifically with LSP
	},

	{
		"kevinhwang91/nvim-ufo",
		dependencies = {
			"kevinhwang91/promise-async",
		},
		config = function()
			require "custom.configs.nvim-ufo"
		end,
	},



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
		"folke/noice.nvim",
		event = "VeryLazy",
		dependencies = {
			"MunifTanjim/nui.nvim",
			"rcarriga/nvim-notify",
		},
		config = function()
			require("noice").setup({
				lsp = {
					signature = {
						enabled = true,
					}
				},
				enabled = true,
				presets = {
					bottom_search = true,
					command_palette = true,
					long_message_to_split = true,
					inc_rename = false,
					lsp_doc_border = false,
				},

				views = {
					hover = {
						relative = "editor",

						position = {
							row = "50%",
							col = "100%",
						},
						border = {
							style = "none",
						},


						-- win_options = {
						-- 	wrap = true,
						-- 	linebreak = true,
						-- 	winhighlight = {
						-- 		Normal = "NormalFloat",
						-- 		FloatBorder = "NormalFloat",
						-- 	}
						-- },
					},
				},
			})
		end
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
		"saifulapm/commasemi.nvim",
		event = "VeryLazy",
		opts = {
			leader = "<leader>",
			keymaps = true,
			commands = true
		}
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
