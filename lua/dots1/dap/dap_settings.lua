local adapters = {
  codelldb = require("dots1.dap.rust_utils").adapter,
  node2 = {
    type = "executable",
    command = "node",
    args = { os.getenv("HOME") .. "/projects/microsoft/vscode-node-debug2/out/src/nodeDebug.js" }
  },
  go = function(callback, _)
    local handle
    local port = 38697
    handle, _ = vim.loop.spawn(
      "dlv",
      {
        args = { "dap", "-l", "127.0.0.1:" .. port },
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
        callback({ type = "server", host = "127.0.0.1", port = port })
      end,
      100
    )

    --callback({type = "server", host = "127.0.0.1", port = port})
  end
}

local configs = {
  typescript = {
    {
      name = "Launch",
      type = "node2",
      request = "launch",
      --program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      console = "integratedTerminal",
      runtimeArgs = { "--nolazy", "-r", "ts-node/register" },
      args = { "${file}", "--transpile-only" },
      skipFiles = { "<node_internals>/**", "node_modules/**" }
    },
    {
      -- For this to work you need to make sure the node process is started with the `--inspect` flag.
      name = "Attach to process",
      type = "node2",
      request = "attach",
      processId = require "dap.utils".pick_process
    }
  },
  javascript = {
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
  },
  rust = {
    {
      name = "Launch build",
      type = "codelldb",
      request = "launch",
      cargo = {
        args = { "build" }
      },
      cwd = "${workspaceFolder}",
      stopOnEntry = true
    },
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
  },
  go = {
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
}

return {
  adapters = adapters,
  configuration = configs
}
