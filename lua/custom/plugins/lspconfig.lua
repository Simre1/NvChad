
local M = {};

M.setup_lsp = function (on_attach, capabilities)

  local lsp_config = require("lspconfig")
  local servers = {"hls", "rust_analyzer"};

  for _, lsp in ipairs(servers) do
  lsp_config[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
    -- root_dir = vim.loop.cwd,
    flags = {
       debounce_text_changes = 150,
    }
  }
  end
end

return M
