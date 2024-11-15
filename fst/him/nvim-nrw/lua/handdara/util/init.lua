-- datetime number to string
local function dtnum2str(x)
    local xs = tostring(x)
    if x < 10 then
        return '0' .. xs
    else
        return xs
    end
end

local function timestamp()
    local ts = os.date('*t')
    local months = { 'jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec' }
    local weekdays = { 'Sun', 'Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat' }
    return {
        yr = tostring(ts.year),
        dy = tostring(ts.day),
        mo = months[ts.month],
        wd = weekdays[ts.wday],
        hr = dtnum2str(ts.hour),
        mi = dtnum2str(ts.min),
    }
end

return {
    timestamp = timestamp,
    dtnum2str = dtnum2str,
}
