--type conform.options
local options = {
	lsp_fallback = true,

	formatters_by_ft = {
		-- lua = { { "stylua" } },
		cpp = { { "clangd", "clang-format", "clang" } },
		javascript = { "prettier" },
		python = { { "black" } },
		css = { "prettier" },
		html = { "prettier" },
		go = { "gofumpt" },
		sh = { "shfmt" },
	},

	-- adding same formatter for multiple filetypes can look too much work for some
	-- instead of the above code you could just use a loop! the config is just a table after all!

	format_on_save = {
		-- These options will be passed to conform.format()
		timeout_ms = 500,
		lsp_fallback = true,
	},
}

-- Override prettier's default indent type
local conform = require("conform")

conform.formatters.black = {
	prepend_args = { "-l", "75", "--target-version", "py311", "--skip-magic-trailing-comma" },
}


conform.formatters.prettier = {
	prepend_args = { "--tab-width", "3" },
}


conform.setup({
	formatters_by_ft = {
		cs = { "clang_format" },
	},
	formatters = {
		clang_format = {
			command = "clang-format",
			args = { "--style={BasedOnStyle: LLVM, BreakBeforeBraces: Attach, IndentWidth: 3}" },
		},
	},
})

conform.formatters.stylua = {}

conform.setup(options)
