local hdirs = require 'handdara.util.dirs'
local M = {}

M.areas = {
    'seal',
    'thesis-ms',
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

local function ask_rg(args)
    local command = { "rg" }
    table.insert(command, "-l")
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
    return ask_rg { pattern }
end

local function run_rg(data)
    assert(#data >= 1) -- args for ripgrep
    return ask_rg(data)
end

local function run_query(query, file_set)
    assert(query.type and query.data)
    assert(not (query.type == "yq" and query.op ~= "transform"))
    local next = file_set or {}
    local function combine_results(new_ls, merge_strat)
        local tmp = {}
        local merge_file = {
            add = function(f) tmp[f] = true end,
            sub = function(f) tmp[f] = next[f] or false end,
            transform = function(l) tmp[l] = true end,
        }
        if merge_strat == 'add' then
            for _, f in ipairs(file_set) do
                table.insert(tmp, f)
            end
            -- elseif merge_strat == 'sub' then
        end
        for _, f in ipairs(new_ls) do
            if string.len(f) > 0 then
                merge_file[merge_strat](f)
            end
        end
        next = tmp
    end
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
            local x = { '^' .. data[1] .. ': *' .. data[2] }
            tmp = run_query({ type = 'rg', data = x, op = 'sub' }, tmp)
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
    combine_results(res.stdout, query.op or 'add')
    return next
end

function M.ask(queries)
    assert(type(queries) == "table")
    assert(type(queries[1]) == "table")
    local pass_thru = {}
    for _, q in ipairs(queries) do
        pass_thru = run_query(q, pass_thru)
    end
    local passed = {}
    for f, in_file_set in pairs(pass_thru) do
        if in_file_set then
            table.insert(passed, f)
        end
    end
    return passed
end

function M.print_result(fs)
    for _, f in ipairs(fs) do
        assert(type(f) == 'string')
        print(f)
    end
end

local function grab_field(field, file)
    local res = M.ask { { type = 'yq', data = { '-r', '.["' .. field .. '"]', file }, op = 'transform' } }
    return res[1]
end

local function render_task(file)
    local ri = grab_field('id', file)
    local rs = grab_field('status', file)
    local rd = grab_field('description', file)
    local rdu = grab_field('due', file)
    return (
        '-   5-stache/' ..
        ri ..
        ": <" ..
        rs ..
        '> ' ..
        rd ..
        ' - ' ..
        rdu
    )
end

function M.print_tasks(fs)
    local output = {}
    for _, f in ipairs(fs) do
        table.insert(output, render_task(f))
    end
    for _, l in ipairs(output) do
        print(l)
    end
end

function M.task_board()
    local ls = {}
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
            table.insert(ts, render_task(f))
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

return M
