local include = require('usr.utils').include
local dap = include('dap')
local dapui = include('dapui')
local dap_virtual = include('nvim-dap-virtual-text')
local osExecute = require('usr.utils').osExecute

----------------------------------------------------------------------
--                            C++ setup                             --

dap.adapters.cppdbg =
{
    id = 'cppdbg',
    type = 'executable',
    command = vim.fn.stdpath('data') .. '/mason/bin/OpenDebugAD7'
}

dap.configurations.cpp = {
    {
        setupCommands = {
            {
                text = '-enable-pretty-printing',
                description =  'enable pretty printing',
                ignoreFailures = false
            },
        },

        name = 'Launch file',
        type = 'cppdbg',
        request = 'launch',
        program = function ()
            return osExecute('fd --search-path \'' .. vim.fn.getcwd() .. '/bin/\'  --type executable')
        end,

        cwd = '${workspaceFolder}',
        stopOnEntry = true,
    },
    {
        name = 'Attach to gdbserver :1234',
        type = 'cppdbg',
        request = 'launch',
        MIMode = 'gdb',
        miDebuggerServerAddress = 'localhost:1234',
        miDebuggerPath = '/usr/bin/gdb',
        cwd = '${workspaceFolder}',
        program = function ()
            return osExecute('fd --search-path \'' .. vim.fn.getcwd() .. '/bin/\'  --type executable')
        end,
    },
}
----------------------------------------------------------------------


----------------------------------------------------------------------
--                         Dap virtual text                         --

dap_virtual.setup {
    enabled = true,                        -- enable this plugin (the default)
    enabled_commands = true,               -- create commands DapVirtualTextEnable, DapVirtualTextDisable, DapVirtualTextToggle, (DapVirtualTextForceRefresh for refreshing when debug adapter did not notify its termination)
    highlight_changed_variables = true,    -- highlight changed values with NvimDapVirtualTextChanged, else always NvimDapVirtualText
    highlight_new_as_changed = false,      -- highlight new variables in the same way as changed variables (if highlight_changed_variables)
    show_stop_reason = true,               -- show stop reason when stopped for exceptions
    commented = true,                     -- prefix virtual text with comment string
    only_first_definition = true,          -- only show virtual text at first definition (if there are multiple)
    all_references = true,                -- show virtual text on all all references of the variable (not only definitions)
    filter_references_pattern = '<module', -- filter references (not definitions) pattern when all_references is activated (Lua gmatch pattern, default filters out Python modules)
    -- experimental features:
    virt_text_pos = 'eol',                 -- position of virtual text, see `:h nvim_buf_set_extmark()`
    all_frames = false,                    -- show virtual text for all stack frames not only current. Only works for debugpy on my machine.
    virt_lines = false,                    -- show virtual lines instead of virtual text (will flicker!)
    virt_text_win_col = nil                -- position the virtual text at a fixed window column (starting from the first text column) ,
                               -- e.g. 80 to position at column 80, see `:h nvim_buf_set_extmark()`
}
----------------------------------------------------------------------


----------------------------------------------------------------------
--                              Dap ui                              --

dapui.setup({
    icons = { expanded = '▾', collapsed = '▸' },
    mappings = {
        -- Use a table to apply multiple mappings
        expand = { '<CR>', '<2-LeftMouse>' },
        open = 'o',
        remove = 'd',
        edit = 'e',
        repl = 'r',
        toggle = 't',
    },
    -- Expand lines larger than the window
    -- Requires >= 0.7
    expand_lines = vim.fn.has('nvim-0.7'),
    -- Layouts define sections of the screen to place windows.
    -- The position can be 'left', 'right', 'top' or 'bottom'.
    -- The size specifies the height/width depending on position. It can be an Int
    -- or a Float. Integer specifies height/width directly (i.e. 20 lines/columns) while
    -- Float value specifies percentage (i.e. 0.3 - 30% of available lines/columns)
    -- Elements are the elements shown in the layout (in order).
    -- Layouts are opened in order so that earlier layouts take priority in window sizing.
    layouts = {
        {
            elements = {
                -- Elements can be strings or table with id and size keys.
                { id = 'scopes', size = 0.25 },
                'breakpoints',
                'stacks',
                'watches',
            },
            size = 40, -- 40 columns
            position = 'left',
        },
        {
            elements = {
                'repl',
                'console',
            },
            size = 0.25, -- 25% of total lines
            position = 'bottom',
        },
    },
    floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = 'single', -- Border style. Can be 'single', 'double' or 'rounded'
        mappings = {
            close = { 'q', '<Esc>' },
        },
    },
    windows = { indent = 1 },
    render = {
        max_type_length = nil, -- Can be integer or nil.
    }
})


-- sync dap ui with dap
dap.listeners.after.event_initialized['dapui_config'] = function()
    dapui.open()
end
dap.listeners.before.event_terminated['dapui_config'] = function()
    dapui.close()
end
dap.listeners.before.event_exited['dapui_config'] = function()
    dapui.close()
end
----------------------------------------------------------------------
