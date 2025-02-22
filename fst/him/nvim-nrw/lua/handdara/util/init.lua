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
    local months = { 'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec' }
    local weekdays = { 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat' }
    local quarter = tostring(math.modf(ts.month / 3) + 1)
    return {
        yr = tostring(ts.year),
        dy = tostring(ts.day),
        mo = months[ts.month],
        wk = M.dtnum2str( math.modf((ts.yday / 7) + 1) ),
        mo_num = ts.month,
        wd = weekdays[ts.wday],
        wd_num = ts.wday,
        hr = M.dtnum2str(ts.hour),
        mi = M.dtnum2str(ts.min),
        sc = M.dtnum2str(ts.sec),
        qt = quarter
    }
end

return M
