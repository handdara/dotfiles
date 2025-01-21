local M = {}

local function user_cmp_sync(prompt, x, y)
    -- Create a placeholder for the input result
    local result = nil

    -- Create a coroutine
    local co = coroutine.running()
    if not co then
        error("This function must be called from within a coroutine")
    end
    vim.ui.select({ x, y }, {
        prompt = prompt,
        format_item = function(item)
            return '- ' .. item
        end,
    }, function(choice)
        result = choice
        coroutine.resume(co)
    end)
    -- Yield control until the coroutine is resumed
    coroutine.yield()
    return result
end

local function sort(xs, cmp)
    if #xs <= 1 then
        return
    else
        local left, right = {}, {}
        local pivot = xs[1]
        for i = 2, #xs do
            -- cmp  ~  <
            if cmp(pivot, xs[i]) then
                table.insert(right, xs[i])
            else
                table.insert(left, xs[i])
            end
        end
        sort(left, cmp)
        sort(right, cmp)
        for j, v in ipairs(left) do
            xs[j] = v
        end
        xs[#left + 1] = pivot
        for j, v in ipairs(right) do
            xs[j + 1 + #left] = v
        end
    end
end

-- Example usage
local function rank(items, line1, line2)
    local cmp = function(x, y)
        local result = user_cmp_sync("Pick better:", x, y)
        if result then
            return x == result
        else
            vim.notify("cancelled ranker")
            error("cancelled sort")
        end
    end
    sort(items, cmp)
    vim.api.nvim_buf_set_lines(0, line1 - 1, line2, false, items)
end

function M.ranker(line1, line2)
    local items = vim.api.nvim_buf_get_lines(0, line1 - 1, line2, false)
    coroutine.wrap(rank)(items, line1, line2)
end

return M
