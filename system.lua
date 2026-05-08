---@class system: behavior
---@field k kernel
local system = class { name = 'system', extends = G.behavior }

function system:new(args)
    args = args or {}
    table.shallow_overlay(self, args)
    print('[system] "' .. self:type() .. '" created')
end

function system:get_entity()
    error('cannot get an entity from a system.')
end

---@param kernel kernel
---@param name string
function system:register(kernel, name)
    self.k = kernel
    assert(
        name and not ('unnamed class'):match(name),
        'system added to kernel without a proper name')
    print('[system] "' .. name .. '" registered')
end

---@param kernel kernel
function system:add_to(kernel)
    return self:add_to_kernel(kernel)
end

function system:add_to_entity()
    error('cannot add a system to an entity.')
end

function system:add_to_kernel(kernel)
    assert(G.is_class(kernel, soup.kernel))
    kernel:add_system(self:get_name(), self)
    return self
end

---@param ... unknown
---@return behavior
function system:create(...)
    error('undefined create method')
end

---@param entity entity
---@param ... unknown
---@return behavior
function system:create_for(entity, ...)
    return self:create(...):add_to_entity(entity)
end

return system
