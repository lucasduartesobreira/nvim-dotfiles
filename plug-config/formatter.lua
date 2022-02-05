local prettierFmt = function()
  return {
    exe = "npx prettier",
    args = {"--stdin-filepath", vim.api.nvim_buf_get_name(0), "--single-quote"},
    stdin = true
  }
end

local eslintFmt = function()
  return {
    exe = "npx eslint",
    args = {"--stdin", "--stdin-filename", vim.api.nvim_buf_get_name(0), "--fix-dry-run"},
    stdin = true
  }
end

require("formatter").setup(
  {
    logging = false,
    filetype = {
      javascript = {
        -- prettier
        prettierFmt,
        eslintFmt
      },
      typescript = {prettierFmt, eslintFmt},
      rust = {
        -- Rustfmt
        function()
          return {
            exe = "rustfmt",
            args = {"--emit=stdout"},
            stdin = true
          }
        end
      },
      lua = {
        -- luafmt
        function()
          return {
            exe = "luafmt",
            args = {"--indent-count", 2, "--stdin"},
            stdin = true
          }
        end
      },
      go = {
        function()
          return {
            exe = "gofmt -s",
            stdin = true
          }
        end,
        function()
          return {
            exe = "goimports",
            stdin = true
          }
        end
      }
    }
  }
)

--Option to format write or just write
vim.api.nvim_exec(
  [[
let g:enable_auto_format_write = 1
function! FormatWriteConditional()
    if g:enable_auto_format_write
        execute 'FormatWrite'
    else
        execute 'w'
    endif
endfunction
augroup FormatAutogroup
  autocmd!
  autocmd BufWritePost *.js,*.ts,*.rs,*.lua,*.go call FormatWriteConditional()
augroup END
]],
  true
)
