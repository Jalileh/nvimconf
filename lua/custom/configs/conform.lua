--type conform.options
local options = {
  lsp_fallback = true,

  formatters_by_ft = {
    lua = { "stylua" },
    cpp = { { "clangd", "clang-format", "clang", "LSP" } },
    javascript = { "prettier" },

    python = { { "pyright", "black" } },
    css = { "prettier" },
    html = { "prettier" },

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
require("conform").formatters.prettier = {
  prepend_args = { "--tab-width", "3" },
}

require("conform").setup(options)
