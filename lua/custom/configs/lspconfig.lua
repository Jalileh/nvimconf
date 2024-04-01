local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

local cmp_nvim_lsp = require "cmp_nvim_lsp"
-- if you just want default config for the servers then put them in a table
local servers = { "html", "cssls", "tsserver", "pyright" }
for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

lspconfig.bashls.setup {

  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  on_attach = on_attach, -- Assign the defined on_attach function
  capabilities = cmp_nvim_lsp.default_capabilities(),
  flags = {
    debounce_text_changes = 150,
  },
}

lspconfig.clangd.setup {
  on_attach = function(client, bufnr)
    print "clangd attached" -- Move print statement inside the on_attach function
    on_attach(client, bufnr) -- Call the original on_attach function

    -- Your custom on_attach function here
    -- You can define custom key mappings, highlight settings, etc.

    -- Merge capabilities
    client.resolved_capabilities.document_formatting = true
    client.resolved_capabilities.document_range_formatting = true

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

-- local clangd_config = {
--   on_attach = function(client, bufnr)
--     print("clangd attached")
--     -- Your custom on_attach function here
--     -- You can define custom key mappings, highlight settings, etc.
--   end,
--   capabilities = cmp_nvim_lsp.default_capabilities(),
--   cmd = {
--     "clangd",
--     "--background-index",
--     "--header-insertion=iwyu",
--     "--completion-style=detailed",
--     "--function-arg-placeholders",
--     "-j4",
--     "--fallback-style=llvm",
--   },
--   root_dir = lspconfig.util.root_pattern(".git", "compile_commands.json", "CMakeLists.txt"),
--   settings = {
--     clangd = {
--       compileCommandsDirectory = "build",
--       indexer = {
--         threads = 4,
--         background = true,
--         trace = "verbose",
--         pchStorage = "memory",
--       },
--     },
--   },
--   init_options = {
--     usePlaceholders = true,
--     completeUnimported = true,
--     clangdFileStatus = true,
--   },
-- }

-- lspconfig.clangd.setup(clangd_config)

-- below one is broken cus gpt is tarded

-- lspconfig.clangd.setup {
--   on_attach = function(client, bufnr)
--     -- Your custom on_attach function here
--     -- You can define custom key mappings, highlight settings, etc.
--   end,
--   capabilities = cmp_nvim_lsp.default_capabilities(), -- Enable LSP capabilities for nvim-cmp
--   cmd = {
--     "clangd",
--     "--background-index", -- Index files in the background
--     "--header-insertion=iwyu", -- Use include-what-you-use for header insertion
--     "--completion-style=detailed", -- Detailed completion
--     "--function-arg-placeholders", -- Show function argument placeholders
--     "-j4", -- Use multiple threads
--     "--fallback-style=llvm", -- Fallback to LLVM style
--   },
--   root_dir = function(fname)
--     -- Use lspconfig.util.root_pattern to find the root directory
--     return require("lspconfig.util").root_pattern(
--       "Makefile",
--       "configure.ac",
--       "configure.in",
--       "config.h.in",
--       "meson.build",
--       "meson_options.txt",
--       "build.ninja"
--     )(fname) or require("lspconfig.util").root_pattern("compile_commands.json", "compile_flags.txt")(
--       fname
--     ) or require("lspconfig.util").find_git_ancestor(fname)
--   end,kkaakkkkkkkk
--   settings = {
--     -- Additional settings for clangd
--     -- You can customize these settings based on your project requirements
--     clangd = {
--       compileCommandsDirectory = "build", -- Specify the directory containing compile_commands.json
--       indexer = {
--         threads = 4, -- Number of indexing threads
--         background = true, -- Enable background indexing
--         trace = "verbose", -- Set indexing trace level
--         pchStorage = "memory", -- Set precompiled headers storage mode
--       },
--     },
--   },
--   init_options = {
--     -- Initialize options for clangd
--     usePlaceholders = true, -- Enable placeholders for code completion
--     completeUnimported = true, -- Complete unimported symbols
--     clangdFileStatus = true, -- Enable file status tracking
--   },
-- }

-- lspconfig.pyright.setup { blabla}
