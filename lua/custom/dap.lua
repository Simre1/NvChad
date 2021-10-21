local M = {}
M.setup = function()
   local dap = require "dap"

   dap.adapters.python = {
      type = "executable",
      command = "/home/simon/Tools/debugpy/bin/python",
      args = { "-m", "debugpy.adapter" },
   }

   dap.configurations.python = {
      {
         -- The first three options are required by nvim-dap
         type = "python", -- the type here established the link to the adapter definition: `dap.adapters.python`
         request = "launch",
         name = "Launch file",

         -- Options below are for debugpy, see https://github.com/microsoft/debugpy/wiki/Debug-configuration-settings for supported options

         program = "${file}", -- This configuration will launch the current file if used.
         pythonPath = function()
            -- debugpy supports launching an application with a different interpreter then the one used to launch debugpy itself.
            -- The code below looks for a `venv` or `.venv` folder in the current directly and uses the python within.
            -- You could adapt this - to for example use the `VIRTUAL_ENV` environment variable.
            local cwd = vim.fn.getcwd()
            if vim.fn.executable(cwd .. "/venv/bin/python") == 1 then
               return cwd .. "/venv/bin/python"
            elseif vim.fn.executable(cwd .. "/.venv/bin/python") == 1 then
               return cwd .. "/.venv/bin/python"
            elseif os.getenv "CONDA_PYTHON_EXE" then
               return os.getenv "CONDA_PYTHON_EXE"
            else
               return "/usr/bin/python"
            end
         end,
      },
   }

   local opt = { silent = true, noremap = true }

   local map = require("core.utils").map
   map("n", "<leader>dc", ":lua require'dap'.continue()<cr>", opt)
   map("n", "<leader>do", ":lua require'dap'.step_over()<cr>", opt)
   map("n", "<leader>di", ":lua require'dap'.step_into()<cr>", opt)
   map("n", "<leader>du", ":lua require'dap'.step_out()<cr>", opt)
   map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>", opt)
   map("n", "<leader>dbc", ":lua require'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>", opt)
   map("n", "<leader>dbl", ":lua require'dap'.set_breakpoint(nil, nil, vim.fn.input('Log point message: '))<cr>", opt)
   map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>", opt)
   map("n", "<leader>de", ":lua require'dap'.run_last()<cr>", opt)
   map("n", "<leader>ds", ":lua require'custom.dap'.scopes()<cr>", opt)
   map("n", "<leader>dh", ":lua require('dap.ui.widgets').hover()<cr>", opt)
   map("n", "<leader>df", ":lua require'custom.dap'.frames()<cr>", opt)
end

M.scopes = function()
   local widgets = require "dap.ui.widgets"
   local my_sidebar = widgets.sidebar(widgets.scopes)
   my_sidebar.open()
end

M.scopes = function()
   local widgets = require "dap.ui.widgets"
   local my_sidebar = widgets.sidebar(widgets.scopes)
   my_sidebar.open()
end

M.frames = function()
   local widgets = require "dap.ui.widgets"
   local my_sidebar = widgets.sidebar(widgets.frames)
   my_sidebar.open()
end

return M
