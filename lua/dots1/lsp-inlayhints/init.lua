local is_lsp_inlayhints_ok, lsp_inlayhints = pcall(require, "lsp-inlayhints")
if not is_lsp_inlayhints_ok then
  return
end

lsp_inlayhints.setup()

local function mappings(bufnr)
  local opts = {noremap = true, silent = true, buffer = bufnr}
  local keymap = vim.keymap.set
  keymap(
    "n",
    "<leader>it",
    function()
      lsp_inlayhints.toggle()
    end,
    opts
  )
  keymap(
    "n",
    "<leader>ir",
    function()
      lsp_inlayhints.reset()
    end,
    opts
  )
end

vim.api.nvim_create_augroup("LspAttach_inlayhints", {})
vim.api.nvim_create_autocmd(
  "LspAttach",
  {
    group = "LspAttach_inlayhints",
    callback = function(args)
      if not (args.data and args.data.client_id) then
        return
      end

      local bufnr = args.buf
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      lsp_inlayhints.on_attach(client, bufnr)
      mappings(bufnr)
    end
  }
)
