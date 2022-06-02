local is_format_ok, lsp_format = pcall(require, "lsp-format")
if not is_format_ok then
  return
end

lsp_format.setup {
  exclude = {
    "tsserver"
  }
}

local function mappings(bufnr)
  local opts = {noremap = true, silent = true, buffer = bufnr}
  local keymap = vim.keymap.set
  keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  --keymap("n", "<S-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  keymap("n", "grn", "<cmd>lua vim.lsp.buf.rename()<CR>", opts)
  keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", opts)
  keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", opts)
  keymap("n", "<leader>sdl", "<cmd>lua vim.diagnostic.open_float()<CR>", opts)
  -- Telescope binds
  keymap("n", "<cr>", "<cmd>lua vim.lsp.buf.code_action({timeout=2000})<cr>", opts)
  keymap("n", "<leader>gr", "<cmd>lua require('telescope.builtin').lsp_references()<cr>", opts)
  keymap("n", "<leader>gi", "<cmd>lua require('telescope.builtin').lsp_implementations()<cr>", opts)
  keymap("n", "<leader>ld", "<cmd>Telescope diagnostics bufnr=0 <cr>", opts)
  keymap("n", "gd", "<cmd>lua require('telescope.builtin').lsp_definitions()<cr>", opts)
end

local function highlight_document(client)
  -- Set autocommands conditional on server_capabilities
  if client.resolved_capabilities.document_highlight then
    vim.api.nvim_exec(
      [[
      augroup lsp_document_highlight
        autocmd! * <buffer>
        autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
        autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
      augroup END
    ]],
      false
    )
  end
end

local M = {}

M.setup = function()
  local signs = {
    {name = "DiagnosticSignError", text = ""},
    {name = "DiagnosticSignWarn", text = ""},
    {name = "DiagnosticSignHint", text = ""},
    {name = "DiagnosticSignInfo", text = ""}
  }

  for _, sign in ipairs(signs) do
    vim.fn.sign_define(sign.name, {texthl = sign.name, text = sign.text, numhl = ""})
  end

  local config = {
    -- disable virtual text
    virtual_text = false,
    -- show signs
    signs = {
      active = signs
    },
    update_in_insert = true,
    underline = true,
    severity_sort = true,
    float = {
      focusable = false,
      style = "minimal",
      border = "rounded",
      source = "always",
      header = "",
      prefix = ""
    }
  }

  vim.diagnostic.config(config)

  vim.lsp.handlers["textDocument/hover"] =
    vim.lsp.with(
    vim.lsp.handlers.hover,
    {
      border = "rounded"
    }
  )

  vim.lsp.handlers["textDocument/signatureHelp"] =
    vim.lsp.with(
    vim.lsp.handlers.signature_help,
    {
      border = "rounded"
    }
  )
end

local on_attach = function(client, bufnr)
  mappings(bufnr)
  highlight_document(client)
  lsp_format.on_attach(client)
end

M.build_on_attach = function(...)
  if select("#", ...) == 0 then
    return on_attach
  end
  local on_attachs = {...}
  local base_on_attach = function(client, bufnr)
    on_attach(client, bufnr)
    for _, v in pairs(on_attachs) do
      if v ~= nil then
        v(client, bufnr)
      end
    end
  end
  return base_on_attach
end

M.on_init = function(client)
  client.config.flags = client.config.flags or {}
  client.config.flags.allow_incremental_sync = true
end

local capabilities = vim.lsp.protocol.make_client_capabilities()

local status_ok, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if not status_ok then
  return
end

M.capabilities = cmp_nvim_lsp.update_capabilities(capabilities)

return M
