local hdirs = require('handdara.util.dirs')
local T = require('handdara.util.type')
local P = require('handdara.util.parse')
local tr = require('handdara.util').trace
local M = { dirs = { data = hdirs.stache.abs } }

---@alias StacheID string
---@alias StacheField string
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

local function wrap0(...) return ... end
local function wrap1(...) return { ... } end
---@param f function
---@param g function?
---@return function
local function compose(f, g)
    assert(type(f) == "function")
    if g then
        assert(type(g) == "function")
        return function(...)
            return f(g(...))
        end
    else
        return function(g_)
            return compose(f, g_)
        end
    end
end
local wrapmap = function(f)
    return compose(wrap1, compose(f, unpack))
end

---@return Parser
local function mkSetOpP(s)
    local p = P.pstr(s)
    return p + P.ppure(string.lower(s))
end
local pYear = P.pmatch('^%d%d%d%d()'):fmap(wrapmap(tonumber))
local pMo = P.pmatch('^%d?%d()'):fmap(wrapmap(tonumber))
local function mkPMo(name)
    local lowered = string.lower(name)
    local capitalized = string.upper(string.sub(name,1,1)) .. string.sub(lowered,2)
    return P.pstr(lowered) ^ P.pstr(capitalized)
end
local pMon = (mkPMo('jan') + P.ppure(1))
    ^ (mkPMo('feb') + P.ppure(2))
    ^ (mkPMo('mar') + P.ppure(3))
    ^ (mkPMo('apr') + P.ppure(4))
    ^ (mkPMo('may') + P.ppure(5))
    ^ (mkPMo('jun') + P.ppure(6))
    ^ (mkPMo('jul') + P.ppure(7))
    ^ (mkPMo('aug') + P.ppure(8))
    ^ (mkPMo('sep') + P.ppure(9))
    ^ (mkPMo('oct') + P.ppure(10))
    ^ (mkPMo('nov') + P.ppure(11))
    ^ (mkPMo('dec') + P.ppure(12))
local pDay = P.pmatch('^%d?%d()'):fmap(wrapmap(tonumber))
local pDate = (pDay .. pMon .. pYear):fmap(compose(wrap1, function(x)
    return {yr = x[3], mo = x[2], da = x[1]}
end))
    ^ (pYear - P.pstr('-') .. pMo - P.pstr('-') .. pDay):fmap(compose(wrap1, function(x)
    return {yr = x[1], mo = x[2], da = x[3]}
end))
local pNullOrDate = (P.pstr('null') + P.ppure({yr = 9999, mo = 12, da = 31})) ^ pDate
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
local pInv = (P.pstr('INV') + pWhSep + P.ppure(true)) ^ P.ppure(false)
local pInvFilt = (pInv .. pFilters):fmap(function(x)
    x[2]['invert'] = x[1]
    return { x[2] }
end)
local pFilt = (pWhSep + pInvFilt) ^ P.ppure({})
local pSetOp = (pSetOpKW .. pFroms .. pFilt - pWhite)
    :fmap(function(x)
        return { { op = x[1], fromDirs = x[2], filter = x[3] } }
    end)
local pSetOps = (pSetOp .. P.prep(pNewLine + pSetOp)):fmap(wrap1)
local pGrpSpl = P.pstr('GROUP') + pWhSep + P.pstr('SPL') + P.ppure(true)
local pGrpNoSpl = P.pstr('GROUP') + P.ppure(false)
local pGrpField = (P.pstr('FIELD') + pWhSep + pField)
local pSort = pWhSep + (P.pstr('ASC') ^ P.pstr('DES'))
    :fmap(function(x) return { string.lower(x[1]) } end)
local pGrpOp = ((pGrpSpl ^ pGrpNoSpl) .. pWhSep + pGrpField .. (pSort ^ P.ppure(nil)) - pWhite)
    :fmap(function(x)
        ---@type GroupOp
        local op = {
            split = x[1],
            field = x[2],
            sort = x[3],
        }
        return { op }
    end)
local pDispOp = P.pstr('LIST') - pWhite
local pBlk = (
    pSetOps
    .. (P.prep(pNewLine + pGrpOp - pWhite):fmap(wrap1))
    .. (pNewLine + pDispOp)
):fmap(function(x)
    return { setOps = x[1], grpOps = x[2], dispOp = x[3] }
end)
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
---@field invert boolean?

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
                -- using the current set instead of pulling from file system
                local rgFlags
                if op.filter.invert then
                    rgFlags = '--files-without-match'
                else
                    rgFlags = '--files-with-matches'
                end
                local cmd = currset:foldl({ rgFlags }, function(acc, id)
                    local itm = M.mk_itm_dat(id)
                    table.insert(acc, itm['path'])
                    return acc
                end)
                -- apply filter
                if op.filter.filt == 'stache' then
                    local pattern = [[^stache: *]] .. op.filter.data
                    table.insert(cmd, 2, pattern)
                    local askRes = ask_rg(cmd)
                    assert(askRes.stderr[1] == "", 'std err: ' .. vim.inspect(askRes.stderr))
                    nextset = M.mk_itm_set(askRes.stdout)
                elseif op.filter.filt == 'grep' then
                    table.insert(cmd, 2, op.filter.data)
                    local askRes = ask_rg(cmd)
                    assert(askRes.stderr[1] == "", 'ask_rg result: ' .. vim.inspect(askRes))
                    nextset = M.mk_itm_set(askRes.stdout)
                elseif op.filter.filt == 'field' then
                    cmd[1] = '--files-with-matches'
                    table.insert(cmd, 2, '')
                    local askRes = ask_rg(cmd)
                    assert(askRes.stderr[1] == "")
                    nextset = M.mk_itm_set(askRes.stdout):filter(function(sid)
                        local matched = string.match(StacheCache[sid][op.filter.field], op.filter.data)
                        if op.filter.invert then
                            return not matched
                        else
                            return matched
                        end
                    end)
                else
                    error('not impl')
                end
            else
                local rgFlags
                if op.filter.invert then
                    rgFlags = '--files-without-match'
                else
                    rgFlags = '--files-with-matches'
                end
                -- searching through file system
                nextset = M.mk_itm_set()
                for _, dir in ipairs(op.fromDirs) do
                    if op.filter.filt == 'stache' then
                        local pattern = [[^stache: *]] .. op.filter.data
                        local askRes = ask_rg { rgFlags, pattern, dir }
                        assert(askRes.stderr[1] == "")
                        nextset = nextset + M.mk_itm_set(askRes.stdout)
                    elseif op.filter.filt == 'grep' then
                        local askRes = ask_rg { rgFlags, op.filter.data, dir }
                        assert(askRes.stderr[1] == "", 'stderr: ' .. vim.inspect(askRes.stderr))
                        nextset = nextset + M.mk_itm_set(askRes.stdout)
                    elseif op.filter.filt == 'field' then
                        local askRes = ask_rg { '-l', '', dir } -- leave this as just the -l arg because inversion happens later
                        assert(askRes.stderr[1] == "")
                        nextset = nextset + M.mk_itm_set(askRes.stdout):filter(function(sid)
                            local matched = string.match(StacheCache[sid][op.filter.field], op.filter.data)
                            if op.filter.invert then
                                return not matched
                            else
                                return matched
                            end
                        end)
                    else
                        error('not impl: op = ' .. vim.inspect(op))
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

---@class GroupOp
---@field field StacheField
---@field sort ('asc'|'des')?
---@field split boolean

---@alias Group {groups:[ string, Group ], opts:table?} | { items:ItmDat[] }

local function compare_dates(lhs, rhs)
    return T.matchOption(pNullOrDate.runParser(lhs),
        function(lres)
            local l = lres[2][1]
            return T.matchOption(pNullOrDate.runParser(rhs),
                function(rres)
                    local r = rres[2][1]
                    ---@cast l {yr:number, mo:number, da:number}
                    ---@cast r {yr:number, mo:number, da:number}
                    local yrEq = l.yr == r.yr
                    local yrMoEq = yrEq and l.mo == r.mo
                    return l.yr < r.yr or (yrEq and l.mo < r.mo) or (yrMoEq and l.da < r.da)
                end,
                function() error('date comparison failed') end)
        end,
        function() error('lhs date comparison failed, lhs: ' .. vim.inspect(lhs)) end)
end

---@param field StacheField
---@param tups [string, any][]
---@param invert boolean
---@return [string, any][]
local function sort_grp(field, tups, invert)
    local comp_1 = function(c)
        return function(ltup, rtup)
            return c(ltup[1], rtup[1])
        end
    end
    local comparison_funcs = { -- is (lhs < rhs) true?
        id = nil,
        due = comp_1(compare_dates),
        created = comp_1(compare_dates),
        modified = comp_1(compare_dates),
        priority = comp_1(function(lhs, rhs)
            local compTbl = {['null'] = 1, ['1'] = 1, ['2'] = 2, ['3'] = 3, ['4'] = 4}
            local l = compTbl[lhs]
            local r = compTbl[rhs]
            -- print(l .. '<' .. r .. '=' .. tostring(l<r))
            return l < r
        end),
        status = comp_1(function(lhs, rhs)
            local lnum, rnum
            for idx, st in ipairs(M.statuses) do
                if st == lhs then
                    lnum = idx
                end
                if st == rhs then
                    rnum = idx
                end
            end
            return lnum < rnum
        end),
    }
    table.sort(tups, comparison_funcs[field])
    if invert then
        local tupsInv = {}
        for _, tup in ipairs(tups) do
            table.insert(tupsInv, 1, tup)
        end
        return tupsInv
    else
        return tups
    end
end

---@param op GroupOp
---@param group Group
---@return Group
local function process_grp_op(op, group)
    if group.groups then
        local newGrps = {}
        for _, tup in ipairs(group.groups) do
            local key = tup[1]
            local grp = tup[2]
            table.insert(newGrps, {key, process_grp_op(op, grp)})
        end
        return { groups = newGrps }
    elseif group.items and op.split then
        local newGrps = {}
        for _, itm in ipairs(group.items) do
            local fld = itm[op.field]
            local grp = newGrps[fld] or { items = {} }
            table.insert(grp.items, itm)
            newGrps[fld] = grp
        end
        local grp = { groups = {} }
        for fld, subgrp in pairs(newGrps) do
            table.insert(grp.groups, { fld, subgrp })
        end
        if op.sort then
            grp.groups = sort_grp(op.field, grp.groups, op.sort == 'des')
        end
        return grp
    elseif group.items and (not op.split) then
        if op.sort then
            -- pack for sorting
            local zipped = {}
            for _, itm in ipairs(group.items) do
                table.insert(zipped, {itm[op.field], itm})
            end
            -- do sort
            zipped = sort_grp(op.field, zipped, op.sort == 'des')
            -- unpack after sorting
            for idx, tup in ipairs(zipped) do
                group.items[idx] = tup[2]
            end
        end
        return group
    else
        error('group had neither "groups" nor "items" field. ')
    end
end

---@class Query
---@field setOps SetOp[]
---@field grpOps GroupOp[]
---@field dispOp string

---@param query Query
---@return string[]
local function process_query(query)
    -- do set ops
    local resultSet = do_query_set_ops(query.setOps)

    return T.matchOption(resultSet, function(x)
        ---@cast x Set
        ---@type Group
        local rootGrp = {
            items = x:foldl({}, function(acc, y)
                table.insert(acc, M.mk_itm_dat(y))
                return acc
            end)
        }
        for _, grpOp in ipairs(query.grpOps) do
            rootGrp = process_grp_op(grpOp, rootGrp)
        end

        -- display op
        if query.dispOp == 'LIST' then
            ---@param level integer
            ---@param grp Group
            ---@return string[]
            local function disp_grps(level, grp)
                local lines = {}
                if grp.items then
                    local preLine = string.rep('    ', math.max(0, level - 1))
                    for _, itm in ipairs(grp.items) do
                        table.insert(lines, preLine .. itm:render()['str'])
                    end
                elseif grp.groups then
                    local preHdr = '##' .. string.rep('#',level) .. ' '
                    for _, grpTuple in pairs(grp.groups) do
                        table.insert(lines, preHdr .. grpTuple[1])
                        for _, subline in ipairs(disp_grps(level+1, grpTuple[2])) do
                            table.insert(lines, subline)
                        end
                    end
                else
                    error('root group has neither items nor subgroups')
                end
                return lines
            end
            return disp_grps(0, rootGrp)
        else
            error('not impl')
        end
    end, function()
        return { 'Failed parse: either no set operations were specified or the first set operation has no FROM expr' }
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

---@class StacheBlock
---@field range [number, number]
---@field lines string[]
---@field output string[]
---@field outReplaceRange [number, number]

local function buf_get_blk_replace_range(bufnr, afterBlockLineNr)
    local remLinesHead = vim.api.nvim_buf_get_lines(bufnr, afterBlockLineNr, afterBlockLineNr + 1, false)
    if remLinesHead[1] and string.match(remLinesHead[1], '^```markdown%s?') then
        local remLinesTail = vim.api.nvim_buf_get_lines(bufnr, afterBlockLineNr + 1, -1, false)
        for idx, line in ipairs(remLinesTail) do
            if string.match(line, '^```%s?') then
                return { afterBlockLineNr, afterBlockLineNr + idx + 1 }
            elseif string.match(line, '^```markdown%s?') then
                break
            end
        end
    end
    return { afterBlockLineNr, afterBlockLineNr }
end

---get stache blocks in a buffer
---@param bufnr number
---@return StacheBlock[]
local function buf_get_blocks(bufnr)
    local ls = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
    ---@type StacheBlock[]
    local sBlks = {}
    local curr = {}
    for idx, line in ipairs(ls) do
        if table.maxn(curr) == 0 then
            if string.match(line, "^```stache%s*$") then
                table.insert(curr, idx)
            end
        elseif table.maxn(curr) == 1 then
            if string.match(line, "^```stache%s*$") then
                curr[1] = idx - 1
            elseif string.match(line, "^```%s*$") then
                table.insert(curr, idx - 1)
                local newBlk = {
                    range = curr,
                    lines = vim.api.nvim_buf_get_lines(bufnr, curr[1], curr[2], false),
                    output = {},
                    outReplaceRange = buf_get_blk_replace_range(bufnr, curr[2] + 1),
                }
                table.insert(sBlks, newBlk)
                curr = {}
            end
        end
    end
    return sBlks
end

---@param blockLines string[]
---@return string[]
local function run_block(blockLines)
    local withoutComments = {}
    for _, line in ipairs(blockLines) do
        if not string.match(line, '^%s*#') then
            table.insert(withoutComments, line)
        end
    end
    local resLines = { '```markdown' }
    local blkString = table.concat(withoutComments, '\n')
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

function M.buf_exec_all_blocks(bufnr)
    bufnr = bufnr or 0
    local blks = buf_get_blocks(bufnr)
    local blkShft = 0
    for _, blk in ipairs(blks) do
        local res = run_block(blk.lines)
        blk.output = res
        vim.api.nvim_buf_set_lines(bufnr, blkShft + blk.outReplaceRange[1], blkShft + blk.outReplaceRange[2], false, res)
        blkShft = blkShft + #res - blk.outReplaceRange[2] + blk.outReplaceRange[1]
    end
    return blks
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
            "```",
            "```markdown",
            "-   ex task",
            "```",
        }
        vim.api.nvim_buf_set_lines(testbuf, 0, -1, false, ls)
        local blks = buf_get_blocks(testbuf)
        vim.api.nvim_buf_delete(testbuf, { force = true })
        assert(#blks[1].lines == 0)
        assert(#blks[2].lines == 0)
        assert(#blks[3].lines == 1 and blks[3].lines[1] == 'UNION FROM - GREP \"regex\"')
        assert(blks[3].outReplaceRange[1] == blks[3].range[2] + 1
            and blks[3].outReplaceRange[2] == blks[3].range[2] + 4)
    end,
    test_parse_dates = function()
        assert(T.matchOption(pDate.runParser('12jun2025'), function(x)
            return x[1] == '' and x[2][1].yr == 2025 and x[2][1].mo == 6 and x[2][1].da == 12
        end, function() return false end))
        assert(T.matchOption(pDate.runParser('3jun2025'), function(x)
            return x[1] == '' and x[2][1].yr == 2025 and x[2][1].mo == 6 and x[2][1].da == 3
        end, function() return false end))
        assert(T.matchOption(pDate.runParser('2025-06-12'), function(x)
            return x[1] == '' and x[2][1].yr == 2025 and x[2][1].mo == 6 and x[2][1].da == 12
        end, function() return false end))
        assert(T.matchOption(pDate.runParser('2025-6-1'), function(x)
            return x[1] == '' and x[2][1].yr == 2025 and x[2][1].mo == 6 and x[2][1].da == 1
        end, function() return false end))
        assert(compare_dates('11jun2025', '12jun2025'))
        assert(compare_dates('11jun2025', 'null'))
        assert(not compare_dates('null', 'null'))
        assert(not compare_dates('null', '1960-01-01'))
        assert(not compare_dates('13jun2025', '12jun2025'))
        assert(not compare_dates('12jun2025', '12jun2025'))
        assert(compare_dates('2024-01-01', '12jun2025'))
        assert(not compare_dates('2024-01-01', '12jun2023'))
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
        local ts = '\nGROUP FIELD id\nGROUP SPL FIELD status\nGROUP FIELD id ASC'
        local p = P.prep(pNewLine + pGrpOp)
        ---@type Option
        local res = p.runParser(ts)
        local resString = 'res = ' .. vim.inspect(res)
        assert(#res._val[2] == 3, resString)
        assert(res._val[2][1]['sort'] == nil, resString)
        assert(res._val[2][1]['field'] == 'id', resString)
        assert(res._val[2][1]['split'] == false, resString)
        assert(res._val[2][2]['sort'] == nil, resString)
        assert(res._val[2][2]['field'] == 'status', resString)
        assert(res._val[2][2]['split'] == true, resString)
        assert(res._val[2][3]['sort'] == 'asc', resString)
        assert(res._val[2][3]['field'] == 'id', resString)
        assert(res._val[2][3]['split'] == false, resString)
    end,
    test_parse_blk = function()
        local blkLines = {
            'UNION FROM -',
            'INTERSECT GREP "regex"',
            'GROUP FIELD id',
            'LIST'
        }
        local blk = table.concat(blkLines, '\n')
        local res = pBlk.runParser(blk)
        local res_string = 'test_parse_blk:res = ' .. vim.inspect(res)
        assert(res._val, res_string)
        assert(#res._val[2].setOps == 2, res_string)
        assert(#res._val[2].grpOps == 1, res_string)
        assert(res._val[2].grpOps[1]['field'] == 'id', res_string)
        assert(res._val[2].grpOps[1]['split'] == false, res_string)
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
                filter = { filt = 'grep', data = 'marrissa', invert = false }
            },
        }
        local setOpsAll = {
            {
                op = 'union',
                fromDirs = { M.stache.abs },
                filter = { filt = 'grep', data = '', invert = false }
            },
        }
        local setOpsInv = {
            {
                op = 'union',
                fromDirs = { M.stache.abs },
                filter = { filt = 'grep', data = 'marrissa', invert = true }
            },
        }
        ---@type Option
        local res = do_query_set_ops(setOps)
        ---@type Option
        local resInv = do_query_set_ops(setOpsInv)
        ---@type Option
        local resAll_ = do_query_set_ops(setOpsAll)
        ---@type Set
        assert(resAll_._val)
        local resAll = resAll_._val
        local resStr = 'res = ' .. vim.inspect(res)
        ---@type Set
        local intersection = (M.mk_itm_set() + res._val) * resInv._val
        ---@type Set
        local union = (M.mk_itm_set() + res._val) + resInv._val
        assert(res._val._elements, resStr)
        assert(intersection:empty())
        resAll:map(function(x)
            assert(union:has(x))
            return x
        end)
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
        local testbuf = vim.api.nvim_create_buf(false, true)
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
        local blks = buf_get_blocks(testbuf)
        local blksStr = 'bnds = ' .. vim.inspect(blks)
        assert(blks[1].range[1] == 1, blksStr)
        assert(blks[1].range[2] == 6, blksStr)
        vim.api.nvim_buf_delete(testbuf, { force = true })
        ---@diagnostic disable-next-line: unused-local
        local res = run_block(blks[1])
    end,
    test_run_all_blocks = function()
        local testbuf = vim.api.nvim_create_buf(false, true)
        local ls = {
            "```stache",
            'UNION FROM - STACHE task',
            '#SUBTRACT FROM - STACHE task',
            'INTERSECT FROM - GREP "marrissa"',
            'SUBTRACT FIELD id "life%-"',
            'GROUP SPL FIELD status DES',
            '#GROUP FIELD priority DES',
            'LIST',
            "```",
        }
        vim.api.nvim_buf_set_lines(testbuf, 0, -1, false, ls)
        local bs = M.buf_exec_all_blocks(testbuf)
        for idx, line in ipairs(bs[1].output) do
            tr(line, 'output['..idx..']:')
        end
        vim.api.nvim_buf_delete(testbuf, { force = true })
        assert(bs[1].range[1] == 1)
        assert(bs[1].range[2] == #ls - 1)
        assert(not string.match(bs[1].output[2], 'fail'))
    end,
}

-- vim.notify('running tests in `fst/him/nvim-nrw/lua/handdara/util/stache.lua`')
-- runtests(tests, function(_) end)
-- runtests({
--     test_top = tests.test_run_all_blocks,
--     test_date = tests.test_parse_dates
-- }, function(_) end)
-- vim.notify('completed tests in `fst/him/nvim-nrw/lua/handdara/util/stache.lua`')
-- vim.cmd [[nnoremap <leader><leader>x :%lua<cr>]]

return M
