local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"



local cmp_nvim_lsp = require "cmp_nvim_lsp"
-- if you just want default config for the servers then put them in a table
local servers = { "markdown_oxide", "html", "cssls", "ts_ls", "gopls", "dockerls" } -- Removed "csharp_ls"

for _, lsp in ipairs(servers) do
	lspconfig[lsp].setup {
		on_attach = on_attach, -- needed for lsp keybinds
		capabilities = capabilities,
	}
end

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

-- OmniSharp configuration - Minimal version for testing
local omnisharp_bin = vim.fn.stdpath("data") .. "/mason/packages/omnisharp/OmniSharp.dll"

if vim.fn.filereadable(omnisharp_bin) == 0 then
	print("Error: OmniSharp.dll not found at: " .. omnisharp_bin)
	print("Please ensure OmniSharp is installed via Mason: `:Mason`")
	return -- Exit this setup if OmniSharp.dll isn't there
end

lspconfig.omnisharp.setup {
	on_attach = on_attach,     -- Use your existing on_attach function
	capabilities = capabilities, -- Use your existing capabilities
	cmd = {
		"dotnet",
		omnisharp_bin,
		"--languageserver",
		"--hostPID",
		tostring(vim.fn.getpid()),
		-- If your project has multiple .sln or .csproj files in the root_dir
		-- and you don't want the "Specify which project file" error,
		-- you might need to *temporarily* add this back for testing:
		-- "--solution", "skymania.sln",
	},
	-- This root_dir logic should be fine; it helps nvim-lspconfig find the project root.
	root_dir = function(fname)
		-- Prioritize finding a .sln file in the current directory or its parents
		local root = require('lspconfig.util').root_pattern(".sln")(fname)
		if root then
			return root
		end
		-- If no .sln found, then look for .csproj, omnisharp.json, etc.
		return require('lspconfig.util').root_pattern("*.csproj", "omnisharp.json", "function.json")(fname)
			 or require('lspconfig.util').find_git_ancestor(fname)
	end,
	-- ALL OmniSharp and .NET-specific settings should go here,
	-- NOT in the 'cmd' table.
	settings = {
		OmniSharp = {
			EnableRoslynAnalyzers = true,
			EnableImportCompletion = true,
			OrganizeImportsOnFormat = true,
			Use = "latest",
			DisableMSBuildProjectLoad = false,
			-- If 'dotnet' is not in your PATH, you *might* need to specify it here
			-- DotNetPath = "C:\\Program Files\\dotnet\\dotnet.exe",
		},
		FormattingOptions = {
			EnableEditorConfigSupport = true,
		},
		DotNet = {
			enablePackageRestore = false,
		},
		Sdk = {
			IncludePrereleases = true,
		},
	}
}
