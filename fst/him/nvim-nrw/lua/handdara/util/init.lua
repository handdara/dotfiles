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
    local ts = os.date('*t')
    local months = { 'jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec' }
    local weekdays = { 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat' }
    return {
        yr = tostring(ts.year),
        dy = tostring(ts.day),
        mo = months[ts.month],
        mo_num = ts.month,
        wd = weekdays[ts.wday],
        wd_num = ts.wday,
        hr = M.dtnum2str(ts.hour),
        mi = M.dtnum2str(ts.min),
    }
end

return M
