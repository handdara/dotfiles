local hdirs = require 'handdara.util.dirs'
local M = {dirs = {data = hdirs.stache.abs}}

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
        .. '\n\targ: tbl: '.. vim.inspect(tbl or 'tbl not passed')
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
    __eq = function (t1, t2)
        return t1.id == t2.id
    end,
    __concat = function (t1, t2)
        assert(t1 == t2)
        for k, v in pairs(t2) do
            t1[k] = v
        end
        return t1
    end,
}

function M.mk_itm_dat(filepath)
    assert(type(filepath) == "string" and string.len(filepath) > 0,
        'mk_itm_dat: invalid arg: filepath: ' ..  vim.inspect(filepath)
    )
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
    return itmdat
end

local meta_itmset = {
    __is_stache_item_set = true,
    __sub = function(self, rhs)
        assert(getmetatable(self).__is_stache_item_set and getmetatable(rhs).__is_stache_item_set, 'both LHS and RHS must be item sets')
        for _, v in pairs(rhs.els) do
            self:remove(v)
        end
        return self
    end,
    __concat = function (self, rhs)
        for _, itm in pairs(rhs.els) do
            self:insert(itm)
        end
        return self
    end,
}

function M.mk_itm_set(filepaths)
    filepaths = filepaths or {}
    local itmset = {els = {}}
    function itmset:insert(itm)
        for k, el in pairs(self.els) do
            if el == itm then
                self.els[k] = el .. itm
                return self
            end
        end
        self.els[itm.id] = itm
        return self
    end
    function itmset:remove(itm)
        self.els[itm.id] = nil
        return self
    end
    function itmset:has(itm)
        for k, el in pairs(self.els) do
            if k == itm.id then
                return getmetatable(el).__is_stache_item
            end
        end
        return false
    end
    --- foldl: (Set itm, a, (a, itm) -> a) -> a
    ---@param acc any
    ---@param f any
    ---@return table
    function itmset:foldl(acc, f)
        for _, itm in pairs(self.els) do
            acc = f(acc, itm)
        end
        return acc
    end
    setmetatable(itmset, meta_itmset)
    for _, fp in ipairs(filepaths) do
        if string.len(fp) > 0 then
            itmset:insert(M.mk_itm_dat(fp))
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

local function run_rg(data, passin)
    assert(#data >= 1) -- args for ripgrep
    return ask_rg(data)
end

local function run_query(query, file_set)
    assert(query.type and query.data)
    assert(query.type ~= "yq" or query.op == "mtrans")
    local next = file_set or M.mk_itm_set()
    local run = {
        rg = run_rg,
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
            local x = { '-l', '^' .. data[1] .. ': *' .. data[2] }
            tmp = run_query({ type = 'rg', data = x, op = 'mand' }, tmp)
            local res = { stdout = {}, stderr = { '' } }
            for key, _ in pairs(tmp) do
                table.insert(res.stdout, key)
            end
            return res
        end,
    }
    local res = run[query.type](query.data, next)
    assert(#res.stderr == 0 or (#res.stderr == 1 and res.stderr[1] == ''),
        'res:' .. vim.inspect(res))
    local res_set = M.mk_itm_set(res.stdout)
    if query.op == 'mor' or not query.op then
        return next .. res_set
    elseif query.op == 'mtrans' then
        error('mtrans option is a todo')
    elseif query.op == 'mand' then
        error('mand option is a todo')
    elseif query.op == 'msub' then
        return next - res_set
    end
end

function M.ask(queries, itm_set_in)
    assert(type(queries) == "table")
    assert(type(queries[1]) == "table")
    local itm_set = itm_set_in or M.mk_itm_set()
    for _, q in ipairs(queries) do
        itm_set = run_query(q, itm_set)
    end
    return itm_set
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

function M.print_tasks(fs)
    local output = {}
    for _, f in ipairs(fs) do
        local rndr = render_task(f)
        table.insert(output, rndr.str)
    end
    for _, l in ipairs(output) do
        print(l)
    end
end

function M.task_board(opts)
    local ls = {}
    opts = opts or {}
    assert(not(opts.include and opts.exclude))
    table.insert(ls, "## tasks")
    table.insert(ls, "")
    -- for each task status type
    for _, st in ipairs(M.statuses) do
        local ts = {}
        -- pretty print the status type
        table.insert(ts, "### " .. st)
        -- get tasks pertaining to it
        local res = M.ask { { type = 'task', data = { 'status', st } } }
        -- pretty print them
        for _, f in ipairs(res) do
            local rndr = render_task(f)
            table.insert(ts, rndr.str)
        end
        table.sort(ts)
        for _, t in ipairs(ts) do
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
