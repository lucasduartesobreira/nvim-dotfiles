local dap = require("dap")

--RUST/C/C++ CONFIGS
dap.adapters.lldb = {
  type = "executable",
  command = "lldb-vscode", -- adjust as needed
  name = "lldb"
}

dap.configurations.cpp = {
  {
    name = "Launch",
    type = "lldb",
    request = "launch",
    program = function()
      return vim.fn.input("Path to executable: ", vim.fn.getcwd() .. "/", "file")
    end,
    cwd = "${workspaceFolder}",
    stopOnEntry = false,
    args = {},
    -- if you change `runInTerminal` to true, you might need to change the yama/ptrace_scope setting:
    --
    --    echo 0 | sudo tee /proc/sys/kernel/yama/ptrace_scope
    --
    -- Otherwise you might get the following error:
    --
    --    Error on launch: Failed to attach to the target process
    --
    -- But you should be aware of the implications:
    -- https://www.kernel.org/doc/html/latest/admin-guide/LSM/Yama.html
    runInTerminal = false
  }
}

dap.configurations.c = dap.configurations.cpp
dap.configurations.rust = dap.configurations.cpp

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
