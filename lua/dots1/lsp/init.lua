local handlers = require("dots1.lsp.handlers")
local setup = require("dots1.lsp.setup_servers")

handlers.setup()
setup.run()

require("dots1.lsp.null_ls")
