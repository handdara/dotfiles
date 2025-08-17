local M = {}

-- datetime number to string
function M.dtnum2str(x)
    local xs = tostring(x)
    if x < 10 then
        return '0' .. xs
    else
        return xs
    end
end

function M.timestamp()
    local ts = os.time()
    return {
        epochtime = ts,
        yr = os.date('%Y',ts),
        dy = os.date('%d',ts),
        mo = os.date('%b',ts),
        month = os.date('%B',ts),
        wk = os.date('%V'),
        mo_num = os.date('%m',ts),
        wd = os.date('%a',ts),
        wd_num = os.date('%u',ts),
        hr = os.date('%H',ts),
        mi = os.date('%M',ts),
        sc = os.date('%S',ts),
        yrdy = os.date('%j',ts),
        qt = os.date('%q',ts),
    }
end

function M.trace(x, msg)
    print((msg or '') .. vim.inspect(x))
    return x
end

function M.trace_notify(msg, x)
    assert(type(msg) == "string")
    vim.notify(msg .. vim.inspect(x))
    return x
end

function M.warn(msg, opts)
    return vim.notify(msg, vim.log.levels.WARN, opts)
end

return M
