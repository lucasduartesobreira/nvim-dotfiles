vim.api.nvim_create_user_command(
  "LspStop",
  function(info)
    local clients = info.fargs
    if #clients == 0 then
      clients =
        vim.iter(vim.lsp.get_clients({bufnr = vim.api.nvim_get_current_buf()})):map(
        function(client)
          return client.name
        end
      ):totable()
    end
    for _, name in ipairs(clients) do
      if vim.lsp.config[name] == nil then
        vim.notify(("Invalid server name '%s'"):format(name))
      else
        vim.lsp.enable(name, false)
      end
    end
  end,
  {
    desc = "Disable and stop the given client",
    nargs = "?"
  }
)

local localSettings = {
  settings = {
    separate_diagnostic_server = true,
    tsserver_max_memory = 6192,
    tsserver_file_preferences = {
      includeCompletionsForModuleExports = true,
      includeInlayParameterNameHints = "all",
      includeInlayParameterNameHintsWhenArgumentMatchesName = false,
      includeInlayFunctionParameterTypeHints = true,
      includeInlayVariableTypeHints = true,
      includeInlayVariableTypeHintsWhenTypeMatchesName = false,
      includeInlayPropertyDeclarationTypeHints = true,
      includeInlayFunctionLikeReturnTypeHints = true,
      includeInlayEnumMemberValueHints = true
    },
    tsserver_format_preferences = {
      insertSpaceAfterCommaDelimiter = false,
      insertSpaceAfterConstructor = false,
      insertSpaceAfterSemicolonInForStatements = false,
      insertSpaceBeforeAndAfterBinaryOperators = false,
      insertSpaceAfterKeywordsInControlFlowStatements = false,
      insertSpaceAfterFunctionKeywordForAnonymousFunctions = false,
      insertSpaceBeforeFunctionParenthesis = false,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyParenthesis = false,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyBrackets = false,
      insertSpaceAfterOpeningAndBeforeClosingNonemptyBraces = false,
      insertSpaceAfterOpeningAndBeforeClosingEmptyBraces = false,
      insertSpaceAfterOpeningAndBeforeClosingTemplateStringBraces = false,
      insertSpaceAfterOpeningAndBeforeClosingJsxExpressionBraces = false,
      insertSpaceAfterTypeAssertion = false,
      placeOpenBraceOnNewLineForFunctions = false,
      placeOpenBraceOnNewLineForControlBlocks = false,
      semicolons = "ignore",
      indentSwitchCase = false
    },
    tsserver_plugins = {
      -- for TypeScript v4.9+
      "@styled/typescript-styled-plugin"
      -- or for older TypeScript versions
      -- "typescript-styled-plugin",
    }
  }
}

--require("typescript-tools").setup(localSettings)

local toOverride = {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end
}

return toOverride
