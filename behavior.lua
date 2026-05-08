---@class behavior: Class
---@field e entity?
---@field k kernel
local behavior = class { name = 'behavior' }

function behavior:new(args)
    args = args or {}
    table.shallow_overlay(self, args)
    print('[behavior] "' .. self:get_name() .. '" created')
end

---@param f function
---@param ... unknown
function behavior:defer(f, ...)
    self:get_kernel():defer(f, ...)
end

---@param func function|string
---@return function
function behavior:bind(func)
    return G.bind(self, func)
end

---@return string
function behavior:get_name()
    return G.type(self)
end

---@return entity
function behavior:get_entity()
    return assert(self.e)
end

---if you need to optionally check the kernel, use self.k
---@return kernel
function behavior:get_kernel()
    return assert(self.k)
end

---@param e_or_k kernel|entity
---@return self
function behavior:add_to(e_or_k)
    if G.is_class(e_or_k, soup.entity) then
        return self:add_to_entity(e_or_k --[[@as entity]])
    elseif G.is_class(e_or_k, soup.kernel) then
        return self:add_to_kernel(e_or_k --[[@as kernel]])
    end
    error('cannot add to type ' .. G.type(e_or_k))
end

---@param entity entity
---@return self
function behavior:add_to_entity(entity)
    assert(G.is_class(entity, soup.entity))
    local name = self:get_name()
    self.e = entity
    self.k = entity.kernel
    if name then
        assert(
            not ('unnamed class'):match(name),
            'behavior added to entity without a proper name')
        entity:add_named(name, self)
    else
        entity:add(self)
    end
    return self
end

---@param kernel kernel
---@return self
function behavior:add_to_kernel(kernel)
    assert(G.is_class(kernel, soup.kernel))
    kernel:add(self)
    self.k = kernel
    return self
end

function behavior:remove_from(e)
    e = e or self.e
    if e then
        e:remove(self)
    else
        self:get_kernel():remove(self)
    end
end

function behavior:remove()
    self.e = nil
    self.k = nil
end

return behavior
