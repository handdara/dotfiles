local hdirs = require 'handdara.util.dirs'
local T = require 'handdara.util.type'
-- local tr = require('handdara.util').trace
local M = { dirs = { data = hdirs.stache.abs } }

StacheCache = T.Map:new()
---@param itm ItmDat
local function cacheItem(itm)
    StacheCache[itm['id']] = itm
end

M.areas = {
    'seal',
    'thesis',
    'community',
    'learning',
    'hobbies',
    'fitness',
    'community',
    'life',
}

M.categories = {
    'electronics',
    'appliances',
    'furniture',
    'clothing',
    'books',
    'media',
    'tools',
    'outdoor',
    'vehicles',
    'art',
    'fitness',
    'instruments',
    'fun',
    'diy',
    'office',
    'health',
    'cooking',
    'organization',
}

M.contexts = {
    'laptop',
    'ccrf',
    'home',
    'notebook',
    'cell',
}

M.types = {
    'task',
    'data',
    'contact',
    'inventory',
}

M.statuses = {
    'backburner',
    'open', -- "clarify"
    'ready',
    'to-discuss',
    'blocked', -- "waiting"
    'scheduled',
    'in-progress',
    'delayed',
    'archived',
    'closed',
}

M.tags = {
    data = { 'heartrate' },
}

M.units = {
    temp = { 'farenheit', 'celcius', },
    freq = { 'bpm', 'Hz' },
    velocity = { 'mph', 'mps', 'kph', },
    duration = { 'seconds', 'hours', 'days', 'weeks', 'months', 'years', },
    misc = { 'count', '4-scale' },
}

M.favUnits = {
    M.units.temp[1],
    M.units.freq[1],
    M.units.velocity[1],
    M.units.velocity[2],
    M.units.duration[1],
    M.units.duration[2],
    M.units.duration[3],
    M.units.duration[6],
    M.units.misc[1],
    M.units.misc[2],
}

M.priorities = {
    '1',
    '2',
    '3',
    '4',
}

M.types = {
    date = {
        'birthday',
        'anniversary',
    },
    phone = {
        'cell',
        'home',
        'office',
        'work',
    },
    email = {
        'personal',
        'work',
    },
    address = {
        'personal',
        'office',
    },
}

local function ask_cr(cmd)
    local res = {}
    local function collect(_, data, name)
        res[name] = data
    end
    local j = vim.fn.jobstart(cmd, {
        on_stdout = collect,
        on_stderr = collect,
        stdout_buffered = true,
        stderr_buffered = true,
    })
    vim.fn.jobwait({ j })
    coroutine.yield(res)
end

local function grab_field(field, file, tbl)
    assert(type(file) == 'string' and string.len(file) > 0,
        'grab_field: invalid arg: file: ' .. vim.inspect(file)
        .. '\n\targ: tbl: ' .. vim.inspect(tbl or 'tbl not passed')
    )
    local command = { 'rg', "-NIor=$1", '^' .. field .. ': *(.*)(\t| )*', file }
    local co = coroutine.create(ask_cr)
    local _, ans = coroutine.resume(co, command)
    assert(coroutine.resume(co))
    assert(ans.stderr[1] == "", "rg errored:\n\tans:\n" .. vim.inspect(ans) ..
        "\n\tcommand: " .. vim.inspect(command) ..
        "\n\tfile: " .. vim.inspect(file)
    )
    return ans.stdout[1]
end

---@alias FilePath string

local meta_itmdat = {
    __is_stache_item = true,
    __index = function(tbl, key)
        local fld = grab_field(key, tbl.path, tbl)
        if fld == '~' then
            fld = 'null'
        end
        tbl[key] = fld
        return fld
    end,
    __eq = function(t1, t2)
        return t1.id == t2.id
    end,
    __concat = function(t1, t2)
        assert(t1 == t2)
        for k, v in pairs(t2) do
            t1[k] = v
        end
        return t1
    end,
}

---@class ItmDat
---@field refresh fun(self:ItmDat)
---@operator concat(ItmDat):ItmDat

---@param filepath FilePath
---@return ItmDat
function M.mk_itm_dat(filepath)
    assert(type(filepath) == "string" and string.len(filepath) > 0,
        'mk_itm_dat: invalid arg: filepath: ' .. vim.inspect(filepath)
    )
    local fid = vim.fs.basename(filepath)
    local cacheQuery = StacheCache[fid]
    if cacheQuery then
        return cacheQuery
    end

    local itmdat = {
        path = vim.fs.normalize(filepath),
    }
    function itmdat:refresh()
        local path_ = self.path
        for k, _ in pairs(self) do
            self[k] = nil
        end
        self.path = path_
        setmetatable(self, meta_itmdat)
        assert(self.id == vim.fs.basename(self.path))
    end

    setmetatable(itmdat, meta_itmdat)
    assert(itmdat.id == vim.fs.basename(filepath),
        'assertion failed, id/filepath basename mismatch:\n\t'
        .. vim.inspect(itmdat.id) .. ' /= ' .. vim.inspect(vim.fs.basename(filepath)) .. '\n' ..
        '!!! failing file: ' .. filepath
    )
    cacheItem(itmdat)
    return itmdat
end

function M.mk_itm_set(filepaths)
    filepaths = filepaths or {}
    local itmset = T.Set:new()

    for _, fp in ipairs(filepaths) do
        if string.len(fp) > 0 then
            local new_itm = M.mk_itm_dat(fp)
            itmset:insert(new_itm['id'])
        end
    end
    return itmset
end

local function ask_rg(args)
    local command = { "rg" }
    for _, arg in ipairs(args) do
        table.insert(command, arg)
    end
    table.insert(command, hdirs.stache.abs)
    local co = coroutine.create(ask_cr)
    local _, ans = coroutine.resume(co, command)
    assert(coroutine.resume(co))
    return ans
end

local function ask_yq(args)
    local command = { "yq" }
    for _, arg in ipairs(args) do
        table.insert(command, arg)
    end
    local co = coroutine.create(ask_cr)
    local _, ans = coroutine.resume(co, command)
    assert(coroutine.resume(co))
    return ans
end

local function run_yq(data)
    assert(#data >= 3) -- args for yq
    return ask_yq(data)
end

local function run_stache(data)
    assert(string.len(data) >= 1)
    local pattern = [[^stache: *]] .. data
    return ask_rg { '-l', pattern }
end

local function run_query(query, file_set)
    assert(query.type and query.data)
    assert(query.type ~= "yq" or query.op == "mtrans")
    local next
    if file_set then
        next = file_set
    else
        next = M.mk_itm_set()
    end
    local run = {
        rg = function(data, _)
            assert(#data >= 1) -- args for ripgrep
            return ask_rg(data)
        end,
        yq = function(data, pass_in)
            table.insert(data, 1, '-c')
            for f, in_file_set in pairs(pass_in) do
                if in_file_set then
                    table.insert(data, f)
                end
            end
            local res = run_yq(data)
            return res
        end,
        stache = run_stache,
        task = function(data, passin)
            local tmp = run_query({ type = 'stache', data = 'task' }, passin)
            tmp = tmp:filter(function(itm)
                return itm[data[1]] == data[2]
            end)
            local res = {
                stdout = tmp:foldl({}, function(acc, itm)
                    table.insert(acc, itm.path)
                    return acc
                end),
                stderr = { '' },
            }
            return res
        end,
    }
    local res = run[query.type](query.data, next)
    assert(#res.stderr == 0 or (#res.stderr == 1 and res.stderr[1] == ''),
        'res:' .. vim.inspect(res))
    local res_set = M.mk_itm_set(res.stdout)
    if query.op == 'mor' or not query.op then
        return next + res_set
    elseif query.op == 'mtrans' then
        error('mtrans option is a todo')
    elseif query.op == 'mand' then
        return next * res_set
    elseif query.op == 'msub' then
        return next - res_set
    end
end

function M.ask(queries, itm_set_in)
    assert(type(queries) == "table")
    assert(type(queries[1]) == "table")
    local itm_set
    if itm_set_in then
        itm_set = M.mk_itm_set() + itm_set_in -- shallow copy
    else
        itm_set = M.mk_itm_set()
    end
    for _, q in ipairs(queries) do
        itm_set = run_query(q, itm_set)
    end
    return itm_set
end

function M.quick_get_names(stache_type)
    local res = run_stache(stache_type)
    return res.stdout
end

function M.print_result(fs)
    for _, f in ipairs(fs) do
        assert(type(f) == 'string')
        print(f)
    end
end

local function render_task(file)
    local task
    if type(file) == "string" then
        task = M.mk_itm_dat(file)
    elseif getmetatable(file).__is_stache_item then
        task = file
    else
        error('render_task: file given was neither a stache itm_dat nor a file path')
    end
    assert(task.priority ~= 'null')
    local due_str
    if task.due == 'null' then
        due_str = ''
    else
        due_str = '<' .. task.due .. '> '
    end
    return {
        str = (
            '-   (' ..
            task.id ..
            ") " ..
            due_str .. '-' ..
            task.priority .. '- ' ..
            task.description
        ),
        fields = task
    }
end

function M.task_board(opts)
    local ls = {}
    opts = opts or {}
    assert(not (opts.include and opts.exclude))
    table.insert(ls, "## tasks")
    table.insert(ls, "")
    -- for each task status type
    for _, st in ipairs(M.statuses) do
        -- get tasks pertaining to status type
        local res = M.ask { { type = 'task', data = { 'status', st } } }
        -- pretty print them
        local task_lines = res:foldl({ "### " .. st }, function(acc, itm)
            local rndr = render_task(itm)
            table.insert(acc, rndr.str)
            return acc
        end)
        table.sort(task_lines)
        for _, t in ipairs(task_lines) do
            table.insert(ls, t)
        end
        table.insert(ls, '')
    end
    for _, l in ipairs(ls) do
        print(l)
    end
end

function M.open_item()
    local line_text = vim.api.nvim_get_current_line()
    local task_id = string.match(line_text, '%((.-)%)') or string.match(line_text, 'id: *([%w%-%_]+)')
    if task_id then
        local file = hdirs.stache.abs .. '/' .. task_id
        vim.cmd('edit ' .. file)
    else
        vim.notify('No stache item on current line!')
    end
end

-- function M.print_inv(files)
-- end

return M
