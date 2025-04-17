local tr = require('handdara.util').trace_notify
---@class M
local M = {}

---@class Some
---@field _l "some"
---@field val any

---@class None
---@field _l "none"

--@alias Option None|Some

---Creates a new Some
---@param x any
---@return Some
function M.Some(x)
    return { _l = "some", val = x }
end

---Creates a new None
---@return None
function M.None()
    return { _l = "none" }
end

---@generic A, B
---@class Foldable<A>
---@field foldl fun(self:Foldable<`A`>, acc0: `B`, f:fun(acc:`B`, el:`A`):`B`):`B`

---@generic T
---@class Set<T>: Foldable
---@field _elements table<`T`, boolean>
---@field new fun(self:Set):Set
---@field insert fun(self:Set, element: `T`):Set
---@field has fun(self:Set, element: `T`):boolean
---@field remove fun(self:Set, element: `T`):Set
---@operator add(Set): Set
local Set = {}

local Set_mt = {
    __index = Set,
    __add = function(self, rhs)
        for element, is_in_rhs in pairs(rhs._elements) do
            if is_in_rhs then
                self:insert(element)
            end
        end
        return self
    end,
    __sub = function (self, rhs)
        for element, is_in_rhs in pairs(rhs._elements) do
            if is_in_rhs then
                self:remove(element)
            end
        end
        return self
    end,
    __mul = function (self, rhs)
        for element, el_is_in_lhs in pairs(self._elements) do
            if not (el_is_in_lhs and rhs:has(element)) then
                self:remove(element)
            end
        end
        return self
    end,
}

setmetatable(Set, Set_mt)

---@return Set
function Set:new()
    local inst = setmetatable({ _elements = {} }, getmetatable(self))
    return inst
end

function Set:insert(x)
    self._elements[x] = true
    return self
end

function Set:has(x)
    return self._elements[x]
end

function Set:remove(x)
    self._elements[x] = false
    return self
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
local test_out = {}
runtests({
    test_set_init = function(prefix)
        local x = Set:new()
        assert(type(x) == 'table', prefix .. ":Set builtin type should be a table!")
    end,
    test_set_insert = function(prefix)
        local x = Set:new()
        assert(x.insert, prefix .. ":Set should have an insert method!")
        x = x:insert(0)
        assert(x._elements[0], prefix .. ":Set should contain `0`! set = " .. vim.inspect(x))
    end,
    test_set_has = function(prefix)
        local x = Set:new()
        assert(x.has, prefix .. ":Set should have a has method!")
        x = x:insert(0)
        assert(x:has(0), prefix .. ":Set should contain `0`! set = " .. vim.inspect(x))
        assert(not x:has(1), prefix .. ":Set should not contain `1`! set = " .. vim.inspect(x))
    end,
    test_set_remove = function(prefix)
        local x = Set:new()
        assert(x.remove, prefix .. ":Set should have a has method!")
        x = x:insert(0)
        assert(x:has(0), prefix .. ":Set should contain `0`! set = " .. vim.inspect(x))
        x = x:remove(0)
        assert(not x:has(0), prefix .. ":Set should not contain `0`! set = " .. vim.inspect(x))
    end,
    test_set_addition = function(prefix)
        local x = Set:new()
        local y = Set:new()
        assert(getmetatable(x).__add, prefix .. ":Set should have an __add metamethod!")
        x = x:insert(0)
        x = x:insert(1)
        y = y:insert(1)
        y = y:insert(2)
        local z = x + y
        assert(z:has(0) and z:has(1) and z:has(2),
            prefix .. ":Set should not contain `1`, `2` and `3`! set = " .. vim.inspect(z))
    end,
    test_set_difference = function(prefix)
        local x = Set:new()
        local y = Set:new()
        assert(getmetatable(x).__sub, prefix .. ":Set should have an __sub metamethod!")
        x = x:insert(0)
        x = x:insert(1)
        y = y:insert(1)
        y = y:insert(2)
        local z = x - y
        assert(z:has(0) and (not z:has(1)) and (not z:has(2)),
            prefix .. ":Set should contain only `0`! z = " .. vim.inspect(z))
    end,
    test_set_intersect = function(prefix)
        local x = Set:new()
        local y = Set:new()
        assert(getmetatable(x).__mul, prefix .. ":Set should have an __mul metamethod!")
        x = x:insert(0)
        x = x:insert(1)
        x = x:insert(42)
        y = y:insert(1)
        y = y:insert(42)
        local z = x * y
        assert(z:has(1) and z:has(42) and (not z:has(0)) and (not z:has(2)),
            prefix .. ":Set should contain only `1`! z = " .. vim.inspect(z))
    end,
}, function(msg)
    table.insert(test_out, ('testing type.lua:' .. msg))
end)
-- for _, line in pairs(test_out) do
--     print(line)
-- end

M = {
    Set = Set
}
return M
