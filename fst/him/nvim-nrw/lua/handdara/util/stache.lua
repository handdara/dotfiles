local hdirs = require('handdara.util.dirs')
local T = require('handdara.util.type')
local P = require('handdara.util.parse')
local tr = require('handdara.util').trace
local M = { dirs = { data = hdirs.stache.abs } }

---@alias StacheID string
---@alias FilePath string

StacheCache = T.Map:new()
---@param itm ItmDat
local function cacheItem(itm)
    StacheCache[itm['id']] = itm
end

M.stache = hdirs.stache

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

M.itemTypes = {
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
---@field render fun(self:ItmDat):string[]
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

    function itmdat:render()
        if self.stache == 'task' then
            local due_str
            if self.due == 'null' then
                due_str = ''
            else
                due_str = '<' .. self.due .. '> '
            end
            return {
                str = (
                    '-   (' ..
                    self.id ..
                    ") " ..
                    due_str .. '-' ..
                    self.priority .. '- ' ..
                    self.description
                ),
                fields = self,
            }
        elseif self.stache == 'contact' then
            return {
                str = (self.id .. ': ' .. self.description),
                fields = self,
            }
        else
            error('not impl')
        end
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

local function ask_rg(args, searchDir)
    searchDir = searchDir or M.stache.abs
    local command = { "rg" }
    for _, arg in ipairs(args) do
        table.insert(command, arg)
    end
    table.insert(command, searchDir)
    local co = coroutine.create(ask_cr)
    local _, ans = coroutine.resume(co, command)
    assert(coroutine.resume(co))
    return ans
end

-- local function ask_yq(args)
--     local command = { "yq" }
--     for _, arg in ipairs(args) do
--         table.insert(command, arg)
--     end
--     local co = coroutine.create(ask_cr)
--     local _, ans = coroutine.resume(co, command)
--     assert(coroutine.resume(co))
--     return ans
-- end

-- local function run_yq(data)
--     assert(#data >= 3) -- args for yq
--     return ask_yq(data)
-- end

local function run_stache(data)
    assert(string.len(data) >= 1)
    local pattern = [[^stache: *]] .. data
    return ask_rg { '-l', pattern }
end

---@param query table
---@return Set<StacheID>
local function run_query(query)
    assert(query.type and query.data, "failed assertion: query = " .. vim.inspect(query))
    local run = {
        rg = function(data)
            assert(#data >= 1) -- args for ripgrep
            return ask_rg(data)
        end,
        stache = run_stache,
        task = function(data)
            ---@type Set
            local tmp = run_query({ type = 'stache', data = 'task' })
            tmp = tmp:filter(function(itm_id)
                local itm = StacheCache[itm_id]
                    or M.mk_itm_dat(hdirs.stache.abs .. '/' .. itm_id)
                return itm[data[1]] == data[2]
            end)
            local res = {
                stdout = tmp:foldl({}, function(acc, itm_id)
                    table.insert(acc, itm_id)
                    return acc
                end),
                stderr = { '' },
            }
            return res
        end,
    }
    local res = run[query.type](query.data)
    -- assert(#res.stderr == 0 or (#res.stderr == 1 and res.stderr[1] == ''),
    --     'res:' .. vim.inspect(res))
    local res_set = M.mk_itm_set(res.stdout)
    return res_set
end

---@class FilterOp
---@field filt string?
---@field data string?
---@field field string?

---@class SetOp
---@field op string
---@field fromDirs string[]
---@field filter FilterOp

---@param ops SetOp[]
---@return Option<Set<StacheID>>
local function do_query_set_ops(ops)
    if #ops == 0 or #ops[1].fromDirs == 0 then
        return T.None()
    else
        local currset = M.mk_itm_set()
        for _, op in ipairs(ops) do
            local nextset
            if #op.fromDirs == 0 then
                assert(not currset:empty(), 'ops = ' .. vim.inspect(ops) .. '\ncurrset = ' .. vim.inspect(currset))
                -- using the current set instead of pulling from file system
                local cmd = currset:foldl({'-l'},function(acc, id)
                    local itm = M.mk_itm_dat(id)
                    table.insert(acc, itm['path'])
                    return acc
                end)
                -- apply filter
                if op.filter.filt == 'stache' then
                    local pattern = [[^stache: *]] .. op.filter.data
                    table.insert(cmd,2,pattern)
                    local askRes = ask_rg(cmd)
                    assert(askRes.stderr[1] == "", 'std err: ' .. vim.inspect(askRes.stderr))
                    nextset = M.mk_itm_set(askRes.stdout)
                elseif op.filter.filt == 'grep' then
                    table.insert(cmd,2,op.filter.data)
                    local askRes = ask_rg(cmd)
                    assert(askRes.stderr[1] == "", 'ask_rg result: ' .. vim.inspect(askRes))
                    nextset = M.mk_itm_set(askRes.stdout)
                elseif op.filter.filt == 'field' then
                    table.insert(cmd,2,'')
                    local askRes = ask_rg(cmd)
                    assert(askRes.stderr[1] == "")
                    nextset = M.mk_itm_set(askRes.stdout):filter(function(sid)
                        return string.match(StacheCache[sid][op.filter.field], op.filter.data)
                    end)
                else
                    error('not impl')
                end
            else
                -- searching through file system
                nextset = M.mk_itm_set()
                for _, dir in ipairs(op.fromDirs) do
                    if op.filter.filt == 'stache' then
                        local pattern = [[^stache: *]] .. op.filter.data
                        local askRes = ask_rg { '-l', pattern, dir }
                        assert(askRes.stderr[1] == "")
                        nextset = nextset + M.mk_itm_set(askRes.stdout)
                    elseif op.filter.filt == 'grep' then
                        local askRes = ask_rg { '-l', op.filter.data, dir }
                        assert(askRes.stderr[1] == "")
                        nextset = nextset + M.mk_itm_set(askRes.stdout)
                    elseif op.filter.filt == 'field' then
                        local askRes = ask_rg { '-l', '', dir }
                        assert(askRes.stderr[1] == "")
                        nextset = nextset + M.mk_itm_set(askRes.stdout):filter(function(sid)
                            return string.match(StacheCache[sid][op.filter.field], op.filter.data)
                        end)
                    else
                        error('not impl')
                    end
                end
            end
            if op.op == "union" then
                currset = currset + nextset
            elseif op.op == "intersect" then
                currset = currset * nextset
            elseif op.op == "subtract" then
                currset = currset - nextset
            end
        end
        return T.Some(currset)
    end
end

---@class Query
---@field setOps SetOp[]
---@field grpOps string[]
---@field dispOp string

---@param query Query
---@return string[]
local function process_query(query)
    -- do set ops
    local resultSet = do_query_set_ops(query.setOps)

    return T.matchOption(resultSet, function(x)
        ---@cast x Set
        -- TODO: do group ops
        -- for _, grpOp in ipairs(query.grpOps) do
        -- end

        -- display op
        if query.dispOp == 'LIST' then
            return x:foldl({}, function(acc, y)
                local itm = M.mk_itm_dat(y)
                table.insert(acc, itm:render()['str'])
                return acc
            end)
        else
            error('not impl')
        end
    end, function()
        return {'either no set operations were specified or the first set operation has no FROM expr'}
    end)
end

function M.ask(query)
    assert(type(query) == "table")
    local itm_set = run_query(query)
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
    opts = opts or {}
    if opts.stexcl then
        for _, st in pairs(M.statuses) do
            if opts[st] == nil then
                opts[st] = true
            else
                opts[st] = not opts[st]
            end
        end
    elseif opts.only then
        for _, st in pairs(M.statuses) do
            opts[st] = false
        end
        if type(opts.only) == "string" then
            opts[opts.only] = true
        elseif type(opts.only) == "table" then
            for _, value in ipairs(opts.only) do
                opts[value] = true
            end
        end
    else
        for _, st in pairs(M.statuses) do
            if opts[st] == nil then
                opts[st] = true
            end
        end
    end
    local task_ids = M.ask { type = 'stache', data = 'task' }
    local task_itms = task_ids:map(function(id)
        return M.mk_itm_dat(id)
    end)
    local ls = {}
    table.insert(ls, "## tasks")
    table.insert(ls, "")
    -- for each task status type
    for _, st in ipairs(M.statuses) do
        if opts[st] then
            -- get tasks pertaining to status type
            local res = task_itms:filter(function(task) return task['status'] == st end)
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

local function get_buf_stache_blocks(bufnr)
    local ls = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    local block_bounds = {}
    local curr = {}
    for idx, line in ipairs(ls) do
        if table.maxn(curr) == 0 then
            if string.match(line, "^```stache%s*$") then
                table.insert(curr, idx)
            end
        elseif table.maxn(curr) == 1 then
            if string.match(line, "^```%s*$") then
                table.insert(curr, idx - 1)
                table.insert(block_bounds, curr)
                curr = {}
            end
        end
    end
    local blocks = {}
    for _, bounds in ipairs(block_bounds) do
        table.insert(blocks, vim.api.nvim_buf_get_lines(bufnr, bounds[1], bounds[2], false))
    end
    return blocks
end

local function wrap0(x) return x end
local function wrap1(x) return { x } end
---@return Parser
local function mkSetOpP(s)
    local p = P.pstr(s)
    return p + P.ppure(string.lower(s))
end
local pPath = P.pmatch('^[%w%-%_%/]+()')
local pSetOpKW = mkSetOpP('UNION') ^ mkSetOpP('SUBTRACT') ^ mkSetOpP('INTERSECT')
local pWhChar = P.pstr(' ') ^ P.pstr('\t')
local pWhite = P.prep(pWhChar)
local pNewLine = P.pstr('\n')
local pWhSep = pWhChar + pWhite
local pHome = P.pstr('-') + P.ppure(M.stache.abs)
local pDir = pHome ^ pPath ^ (P.pstr('`') + pPath - P.pstr('`'))
local pFrom = P.pstr('FROM') + pWhSep + pDir
local pFroms = P.prep(pWhSep + pFrom):fmap(wrap1)
local pStache = P.pstr('task') ^ P.pstr('data') ^ P.pstr('contact') ^ P.pstr('inventory')
local pFiltStache = (P.pstr('STACHE') + pWhSep + pStache)
    :fmap(function(x)
        return { { filt = 'stache', data = x[1] } }
    end)
local pDblQuotes = P.pstr('"') + P.pmatch('^[^"]+()') - P.pstr('"')
local pFiltGrep = (P.pstr('GREP') + pWhSep + pDblQuotes)
    :fmap(function(re)
        return { { filt = 'grep', data = re[1] } }
    end)
local pFieldStr = P.pmatch('^[%w%_]+()')
local pField = pFieldStr ^ pDblQuotes
local pFiltField = (P.pstr('FIELD') + pWhSep + pField .. pWhSep + pDblQuotes)
    :fmap(function(x)
        return { { filt = 'field', field = x[1], data = x[2] } }
    end)
local pFilters = pFiltStache ^ pFiltGrep ^ pFiltField
local pFilt = (pWhSep + pFilters) ^ P.ppure({})
local pSetOp = (pSetOpKW .. pFroms .. pFilt - pWhite)
    :fmap(function(x)
        return { { op = x[1], fromDirs = x[2], filter = x[3] } }
    end)
local pSetOps = (pSetOp .. P.prep(pNewLine + pSetOp)):fmap(wrap1)
local pGrpField = (P.pstr('GROUP') + pWhSep + P.pstr('FIELD') + pWhSep + pField)
    :fmap(function(x)
        return {{ 'field', x[1] }}
    end)
local pGrpOp = pGrpField ^ P.pstr('GROUP')
local pDispOp = P.pstr('LIST') - pWhite
local pBlk = (
    pSetOps
    .. ( P.prep(pNewLine + pGrpOp - pWhite):fmap(wrap1) )
    .. ( pNewLine + pDispOp)
):fmap(function(x)
    return { setOps = x[1], grpOps = x[2], dispOp = x[3] }
end)

local function run_block(block)
    local resLines = { '```markdown' }
    local blkString = table.concat(block, '\n')
    local processedLines = T.matchOption(pBlk.runParser(blkString),
        function(res)
            local query = res[2]
            return process_query(query)
        end,
        function()
            return { 'Block failed to parse into query!' }
        end)
    for _, line in ipairs(processedLines) do
        table.insert(resLines, line)
    end
    table.insert(resLines, '```')
    return resLines
end

local function runtests(tests, pr)
    local idx = 1
    for name, test in pairs(tests) do
        local prefix = 'test #' .. tostring(idx) .. ':' .. name .. ':'
        pr(prefix .. 'running...')
        test(prefix)
        pr(prefix .. 'passed!')
        idx = idx + 1
    end
end
local tests = {
    test_get_blks = function()
        local testbuf = vim.api.nvim_create_buf(false, true)
        local ls = {
            "```stache",
            "```",
            "",
            "```stache",
            "```",
            "",
            "stache",
            "",
            "``stache",
            "```",
            "",
            "```lua",
            "```",
            "",
            "```stache",
            "UNION FROM - GREP \"regex\"",
            "```"
        }
        vim.api.nvim_buf_set_lines(testbuf, 0, -1, false, ls)
        local blks = get_buf_stache_blocks(testbuf)
        vim.api.nvim_buf_delete(testbuf, { force = true })
        assert(#blks[1] == 0)
        assert(#blks[2] == 0)
        assert(#blks[3] == 1 and blks[3][1] == 'UNION FROM - GREP \"regex\"')
    end,
    test_parse_set_op = function()
        local ts = "UNION FROM `path` FROM `path` STACHE task"
        local res = pSetOp.runParser(ts)
        assert(res._val, 'res._val: ' .. vim.inspect(res._val))
        assert(res._val[2][1]['op'] == 'union')
        assert(res._val[2][1]['fromDirs'][1] == 'path')
        assert(res._val[2][1]['fromDirs'][2] == 'path')
        local ts_ = 'UNION FROM - FIELD id "marrissa"'
        local res_ = pSetOp.runParser(ts_)
        local res_str = 'res_._val: ' .. vim.inspect(res_._val)
        assert(res_._val, res_str)
        assert(res_._val[2][1]['op'] == 'union', res_str)
        assert(res_._val[2][1]['fromDirs'][1] == M.stache.abs, res_str)
        assert(res_._val[2][1]['filter']['field'] == 'id', res_str)
        assert(res_._val[2][1]['filter']['data'] == 'marrissa', res_str)
    end,
    test_parse_set_op_no_fr = function()
        local ts = "UNION STACHE task"
        local res = pSetOp.runParser(ts)
        -- tr('test_parse_set_op_no_fr', res._val)
        assert(res._val)
        assert(res._val[2][1]['op'] == 'union')
    end,
    test_parse_set_op_no_filter = function()
        local ts = "UNION FROM -"
        local res = pSetOp.runParser(ts)
        local resString = 'res = ' .. vim.inspect(res)
        assert(res._val, resString)
        assert(res._val[2][1]['op'] == 'union')
    end,
    test_parse_grep_filter = function()
        local ts = ' GREP "regex"'
        local res = pFilt.runParser(ts)
        local resString = 'res = ' .. vim.inspect(res)
        assert(res._val[2][1]['filt'] == 'grep', resString)
        assert(res._val[2][1]['data'] == 'regex', resString)
    end,
    test_parse_empty_filter = function()
        local ts = ''
        local res = pFilt.runParser(ts)
        assert(res._val, 'res = ' .. vim.inspect(res))
        assert(#res._val[2][1] == 0, 'res = ' .. vim.inspect(res))
    end,
    test_parse_field_filter = function()
        local ts = ' FIELD id "lua pattern"'
        local res = pFilt.runParser(ts)
        local resString = 'res = ' .. vim.inspect(res)
        assert(res._val[2][1]['filt'] == 'field', resString)
        assert(res._val[2][1]['field'] == 'id', resString)
        assert(res._val[2][1]['data'] == 'lua pattern', resString)
    end,
    test_parse_group_ops = function()
        local ts = '\nGROUP\nGROUP FIELD id\nGROUP FIELD id'
        local p = P.prep(pNewLine + pGrpOp)
        ---@type Option
        local res = p.runParser(ts)
        assert(#res._val[2] == 3, 'res = ' .. vim.inspect(res))
        for i = 2, 3 do
            assert(res._val[2][i][1] == 'field')
            assert(res._val[2][i][2] == 'id')
        end
    end,
    test_parse_blk = function()
        local blkLines = {
            'UNION FROM -',
            'INTERSECT GREP "regex"',
            'GROUP',
            'LIST'
        }
        local blk = table.concat(blkLines, '\n')
        local res = pBlk.runParser(blk)
        local res_string = 'test_parse_blk:res = ' .. vim.inspect(res)
        assert(res._val, res_string)
        assert(#res._val[2].setOps == 2, res_string)
        assert(res._val[2].grpOps[1] == 'GROUP', res_string)
        assert(res._val[2].dispOp == 'LIST', res_string)
        -- print(table.concat(run_block(blkLines), '\n'))
    end,
    test_do_query_set_ops__empty = function()
        ---@type SetOp[]
        local setOps = {}
        ---@type Option
        local res = do_query_set_ops(setOps)
        local resStr = 'res = ' .. vim.inspect(res)
        assert(not res._val, resStr)
    end,
    test_do_query_set_ops__empty_fst_fromDirs = function()
        ---@type SetOp[]
        local setOps = {
            { op = 'union', fromDirs = {}, filter = {} }
        }
        ---@type Option
        local res = do_query_set_ops(setOps)
        local resStr = 'res = ' .. vim.inspect(res)
        assert(not res._val, resStr)
    end,
    test_do_query_set_ops__stache_filt = function()
        for _, stacheTypeToSearch in ipairs(M.itemTypes) do
            ---@type SetOp[]
            local setOps = {
                {
                    op = 'union',
                    fromDirs = { M.stache.abs },
                    filter = { filt = 'stache', data = stacheTypeToSearch }
                },
            }
            ---@type Option
            local res = do_query_set_ops(setOps)
            local resStr = 'res = ' .. vim.inspect(res)
            assert(res._val, resStr)
            local els = res._val._elements
            for name, inSet in pairs(els) do
                if inSet then
                    local el = M.mk_itm_dat(name)
                    ---@diagnostic disable-next-line: undefined-field
                    assert(el.stache == stacheTypeToSearch)
                end
            end
        end
    end,
    test_do_query_set_ops__grep_filt = function()
        ---@type SetOp[]
        local setOps = {
            {
                op = 'union',
                fromDirs = { M.stache.abs },
                filter = { filt = 'grep', data = 'marrissa' }
            },
        }
        ---@type Option
        local res = do_query_set_ops(setOps)
        local resStr = 'res = ' .. vim.inspect(res)
        assert(res._val._elements, resStr)
    end,
    test_do_query_set_ops__field_filt = function()
        ---@type SetOp[]
        local setOps = {
            {
                op = 'union',
                fromDirs = { M.stache.abs },
                filter = { filt = 'field', field = 'id', data = 'marrissa' }
            },
        }
        ---@type Option
        local res = do_query_set_ops(setOps)
        local resStr = 'res = ' .. vim.inspect(res)
        assert(res._val, resStr)
        for name, inSet in pairs(res._val._elements) do
            if inSet then
                assert(string.sub(name, 1, 8) == 'marrissa', resStr)
            end
        end
    end,
    test_run_block_contact = function()
        local blkLines = {
            'UNION FROM - FIELD id "marrissa"',
            'GROUP',
            'LIST'
        }
        -- local blk = table.concat(blkLines, '\n')
        local res = run_block(blkLines)
        for _, line in ipairs(res) do
            -- print(line)
            assert(string.len(line) > 0)
        end
    end,
    test_run_blk_in_buf = function()
        local testbuf = vim.api.nvim_create_buf(true, true)
        local ls = {
            "```stache",
            'UNION FROM - STACHE task',
            'INTERSECT FROM - GREP "marrissa"',
            'SUBTRACT FIELD id "life%-"',
            'GROUP FIELD id',
            'LIST',
            "```",
        }
        vim.api.nvim_buf_set_lines(testbuf, 0, -1, false, ls)
        local blks = get_buf_stache_blocks(testbuf)
        vim.api.nvim_buf_delete(testbuf, { force = true })
        local res = run_block(blks[1])
    end,
}

-- runtests(tests, function(_) end)

vim.cmd [[nnoremap <leader><leader>x :%lua<cr>]]

return M
