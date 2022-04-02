local dap = require("dap")

--RUST/C/C++ CONFIGS
dap.adapters.codelldb = require("dots.dap.rust_utils").adapter

dap.adapters.node2 = {
  type = "executable",
  command = "node",
  args = {os.getenv("HOME") .. "/projects/microsoft/vscode-node-debug2/out/src/nodeDebug.js"}
}
dap.configurations.typescript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    --program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal",
    runtimeArgs = {"--nolazy", "-r", "ts-node/register"},
    args = {"${file}", "--transpile-only"},
    skipFiles = {"<node_internals>/**", "node_modules/**"}
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require "dap.utils".pick_process
  }
}

dap.configurations.javascript = {
  {
    name = "Launch",
    type = "node2",
    request = "launch",
    program = "${file}",
    cwd = vim.fn.getcwd(),
    sourceMaps = true,
    protocol = "inspector",
    console = "integratedTerminal"
  },
  {
    -- For this to work you need to make sure the node process is started with the `--inspect` flag.
    name = "Attach to process",
    type = "node2",
    request = "attach",
    processId = require "dap.utils".pick_process
  }
}

dap.configurations.cpp = {
  {
    name = "Launch file",
    type = "codelldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = true
  }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = {
  {
    name = "Launch build",
    type = "codelldb",
    request = "launch",
    cargo = {
      args = {"build"}
    },
    cwd = "${workspaceFolder}",
    stopOnEntry = true
  },
  dap.configurations.cpp[1]
}

--GO CONFIGS
dap.adapters.go = function(callback, _)
  local handle
  local port = 38697
  handle, _ =
    vim.loop.spawn(
    "dlv",
    {
      args = {"dap", "-l", "127.0.0.1:" .. port},
      detached = true
    },
    function(code)
      handle:close()
      print("Delve exited with exit code: " .. code)
    end
  )
  -- Wait 100ms for delve to start
  vim.defer_fn(
    function()
      --dap.repl.open()
      callback({type = "server", host = "127.0.0.1", port = port})
    end,
    100
  )

  --callback({type = "server", host = "127.0.0.1", port = port})
end
-- https://github.com/go-delve/delve/blob/master/Documentation/usage/dlv_dap.md
dap.configurations.go = {
  {
    type = "go",
    name = "Debug",
    request = "launch",
    program = "${file}"
  },
  {
    type = "go",
    name = "Debug test", -- configuration for debugging test files
    request = "launch",
    mode = "test",
    program = "${file}"
  },
  -- works with go.mod packages and sub packages
  {
    type = "go",
    name = "Debug test (go.mod)",
    request = "launch",
    mode = "test",
    program = "./${relativeFileDirname}"
  }
}

vim.api.nvim_set_keymap("n", "<F5>", ":lua require'dap'.continue()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<F9>", ":lua require'dap'.step_back()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<F10>", ":lua require'dap'.step_over()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<F11>", ":lua require'dap'.step_into()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<F12>", ":lua require'dap'.step_out()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>tb", ":lua require'dap'.toggle_breakpoint()<CR>", {silent = true})
vim.api.nvim_set_keymap(
  "n",
  "<leader>sb",
  ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<CR>",
  {silent = true}
)
vim.api.nvim_set_keymap(
  "n",
  "<leader>lp",
  ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<CR>",
  {silent = true}
)
vim.api.nvim_set_keymap("n", "<leader>dr", ":lua require'dap'.repl.open()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>dl", ":lua require'dap'.run_last()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>du", ":lua require'dap'.up()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>dd", ":lua require'dap'.down()<CR>", {silent = true})
vim.api.nvim_set_keymap("n", "<leader>dt", ":lua require'dap'.terminate()<CR>", {silent = true})
