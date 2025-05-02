local M = {}

function M.runtests(tests, printFn)
    local idx = 1
    for name, test in pairs(tests) do
        local prefix = 'test #' .. tostring(idx) .. ':' .. name .. ':'
        printFn(prefix .. 'running...')
        if test(prefix) then
            printFn(prefix .. 'passed.')
        else
            printFn(prefix .. 'FAILED!!! 🟥')
        end
        idx = idx + 1
    end
end

function M.mkNotifier()
    return {
        lines = {},
        addline = function(self, line)
            table.insert(self.lines, line)
        end,
        notify = function(self)
            for _, line in ipairs(self.lines) do
                -- vim.notify(line)
                vim.print(line)
            end
        end,
    }
end

return M
