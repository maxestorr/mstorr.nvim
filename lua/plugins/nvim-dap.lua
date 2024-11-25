return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "mfussenegger/nvim-dap-python",
            "rcarriga/nvim-dap-ui",
            "theHamsta/nvim-dap-virtual-text",
            "nvim-neotest/nvim-nio",
            "williamboman/mason.nvim",
        },
        config = function()
            local dap = require("dap")
            local ui = require("dapui")
            local dap_python = require("dap-python")
            local dap_virtual_text = require("nvim-dap-virtual-text")
            local keymap = vim.keymap

            ui.setup()
            dap_python.setup("~/.local/share/nvim/mason/bin/debugpy")
            dap_virtual_text.setup()

            -- require("nvim-dap-virtual-text").setup({
            --     -- This just tries to mitigate the chance that I leak tokens here. Probably won't stop it from happening...
            --     display_callback = function(variable)
            --         local name = string.lower(variable.name)
            --         local value = string.lower(variable.value)
            --         if name:match("secret") or name:match("api") or value:match("secret") or value:match("api") then
            --             return "*****"
            --         end
            --
            --         if #variable.value > 15 then
            --             return " " .. string.sub(variable.value, 1, 15) .. "... "
            --         end
            --
            --         return " " .. variable.value
            --     end,
            -- })

            keymap.set("n", "<space>b", dap.toggle_breakpoint, { desc = "Debug toggle breakpoint" })
            keymap.set("n", "<space>dr", dap.run_to_cursor, { desc = "Debug run to cursor" })

            keymap.set("n", "<F1>", dap.continue, { desc = "Debug continue" })
            keymap.set("n", "<F2>", dap.step_into, { desc = "Debug step into" })
            keymap.set("n", "<F3>", dap.step_over, { desc = "Debug step over" })
            keymap.set("n", "<F4>", dap.step_out, { desc = "Debug step out" })
            keymap.set("n", "<F5>", dap.step_back, { desc = "Debug step back" })
            keymap.set("n", "<F13>", dap.restart, { desc = "Debug restart" })

            -- Eval var under cursor
            keymap.set("n", "<space>?", function()
                ui.eval(nil, { enter = true })
            end)

            keymap.set("n", "<space>dpr", dap_python.test_method, { desc = "Debug python test method" })
            keymap.set("n", "<space>dpc", dap_python.test_class, { desc = "Debug python test class" })

            dap.listeners.before.attach.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.launch.dapui_config = function()
                ui.open()
            end
            dap.listeners.before.event_terminated.dapui_config = function()
                ui.close()
            end
            dap.listeners.before.event_exited.dapui_config = function()
                ui.close()
            end
        end,
    },
}
