local localSettings = {
  settings = {
    separate_diagnostic_server = false,
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

require("typescript-tools").setup(localSettings)

local toOverride = {
  on_attach = function(client, bufnr)
    client.server_capabilities.documentFormattingProvider = false
  end
}

return toOverride
