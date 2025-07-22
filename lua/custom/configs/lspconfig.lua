local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"



local cmp_nvim_lsp = require "cmp_nvim_lsp"
-- if you just want default config for the servers then put them in a table
local servers = { "markdown_oxide", "html", "cssls", "ts_ls", "gopls", "dockerls" }

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach, -- needed for lsp keybinds
		capabilities = capabilities,
	}
end

lspconfig.csharp_ls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
}
lspconfig.sqlls.setup {
	capabilities = capabilities,
	filetypes = { 'sql' },
	root_dir = function(_)
		return vim.loop.cwd()
	end,
}
lspconfig.markdown_oxide.setup({
	capabilities = vim.tbl_deep_extend(
		'force',
		capabilities,
		{
			workspace = {
				didChangeWatchedFiles = {
					dynamicRegistration = true,
				},
			},
		}
	),
	on_attach = on_attach -- configure your on attach config
})

lspconfig.lua_ls.setup {
	capabilities = capabilities,
	on_attach = on_attach,
	settings = {
		Lua = {
			format = {
				enable = true,
				-- Put format options here
				-- NOTE: the value should be STRING!!
				defaultConfig = {
					indent_style = "tab",
					indent_size = "3",
				},
			},
		},
	},
}
lspconfig.pyright.setup {
	capabilities = capabilities,
	on_attach = on_attach,

}


lspconfig.clangd.setup {
	on_attach = function(client, bufnr)
		print "clangd attached" -- Move print statement inside the on_attach function

		-- Your custom on_attach function here
		-- You can define custom key mappings, highlight settings, etc.

		-- Merge capabilities
		client.server_capabilities.document_formatting = true
		client.server_capabilities.document_range_formatting = true

		-- retarded ai dosent even make this fucking do it
		client.config.cmd = {
			"clangd",
			"--background-index",
			"--completion-style=detailed",
			"--function-arg-placeholders",
			"-j4",
			"--fallback-style=llvm",
			"--header-insertion=never",
		}
		client.config.root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json", "CMakeLists.txt")
		client.config.settings = {
			clangd = {
				compileCommandsDirectory = "build",
				indexer = {
					threads = 4,
					background = true,
					trace = "verbose",
					pchStorage = "memory",
				},
			},
		}
		client.config.init_options = {
			usePlaceholders = true,
			completeUnimported = true,
			clangdFileStatus = true,
		}
	end,
	capabilities = cmp_nvim_lsp.default_capabilities(),

	cmd = {
		"clangd",
		"--background-index",
		"--completion-style=detailed",
		"--function-arg-placeholders=1",
		"--offset-encoding=utf-16",

		"--header-insertion=never",
	},
}
