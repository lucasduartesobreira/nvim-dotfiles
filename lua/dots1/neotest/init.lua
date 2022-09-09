local is_neotest_ok, neotest = pcall(require, "neotest")
if not is_neotest_ok then
  return
end

neotest.setup(
  {
    adapters = {
      require("neotest-jest")(
        {
          jestCommand = "npm test --",
          cwd = function(path)
            print(vim.inspect(path))
            return vim.fn.getcwd()
          end
        }
      ),
      require("neotest-rust")
    }
  }
)

local opts = {silent = true}
local keymap = vim.keymap.set
keymap(
  "n",
  "<leader>ts",
  function()
    neotest.summary.toggle()
  end,
  opts
)
keymap(
  "n",
  "<leader>trf",
  function()
    neotest.run.run(vim.fn.expand("%"))
  end,
  opts
)
keymap(
  "n",
  "<leader>trn",
  function()
    neotest.run.run()
  end,
  opts
)
keymap(
  "n",
  "<leader>to",
  function()
    neotest.output.open({short = true})
  end,
  opts
)
keymap(
  "n",
  "<leader>tjo",
  function()
    neotest.output.open({enter = true})
  end,
  opts
)
keymap(
  "n",
  "<leader>tdn",
  function()
    neotest.run.run({strategy = "dap"})
  end,
  opts
)
keymap(
  "n",
  "]t",
  function()
    neotest.jump.prev({status = "failed"})
  end
)
keymap(
  "n",
  "[t",
  function()
    neotest.jump.next({status = "failed"})
  end
)
