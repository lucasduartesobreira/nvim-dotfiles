require("ultest").setup(
  {
    builders = {
      ["typescript#jest"] = function(cmd)
        table.insert(cmd, 2, "--testTimeout=300000")
        return {
          dap = {
            name = "Launch",
            type = "node2",
            request = "launch",
            --program = "${file}",
            cwd = vim.fn.getcwd(),
            sourceMaps = true,
            protocol = "inspector",
            console = "integratedTerminal",
            runtimeArgs = {"--inspect-brk"},
            args = cmd,
            port = 9229
          }
        }
      end,
      ["rust#cargotest"] = function(cmd)
        local test_name = cmd[3]
        return {
          dap = {
            name = "Debug build",
            type = "codelldb",
            request = "launch",
            cargo = {
              args = {"test", test_name},
              executableArgs = {test_name, "--exact", "--include-ignored"},
              filter = {
                kind = {"lib"}
              }
            },
            cwd = "${workspaceFolder}",
            args = {},
            stopOnEntry = false,
            sourceLanguages = {"rust"}
          }
        }
      end,
      ["javascript#jest"] = function(cmd)
        print(vim.inspect(cmd))
        table.insert(cmd, 2, "--runInBand")
        table.insert(cmd, 3, "--detectOpenHandles")
        table.insert(cmd, 4, "--forceExit")
        return {
          dap = {
            name = "Launch",
            type = "node2",
            request = "launch",
            cwd = vim.fn.getcwd(),
            protocol = "inspector",
            console = "integratedTerminal",
            sourceMaps = true,
            runtimeArgs = {"--inspect-brk"},
            args = cmd,
            port = 9229
          }
        }
      end
    }
  }
)
