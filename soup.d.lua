---@meta
soup = {}

---@class Behaviour: table

---@class kernel: Class
---@field systems table<string, Behaviour>
---@overload fun(): kernel
local kernel = {}

function kernel:new() end

function kernel:update(dt) end

function kernel:draw() end

function kernel:add(behaviour) end

function kernel:remove(behaviour) end

function kernel:add_now(behaviour) end

function kernel:remove_now(behaviour) end

function kernel:add_from_system(system_name, ...) end

function kernel:defer(f, ...) end

function kernel:flush(dt) end

---@return entity
function kernel:entity() end

function kernel:add_system(name, system) end

---@class entity: Class
---@field kernel kernel
local entity = {}
function entity:add(behaviour) end

function entity:add_named(name, behaviour) end

function entity:add_from_system(system_name, ...) end

function entity:add_named_from_system(system_name, name, ...) end

function entity:name_for(behaviour) end

function entity:_behaviour_and_name(behaviour_or_name) end

function entity:remove(behaviour_or_name) end

function entity:detach(behaviour_or_name) end

function entity:attach(name_or_behaviour, behaviour_if_named) end

function entity:destroy() end

function entity:error_if_destroyed() end

function entity:publish(event, ...) end

function entity:subscribe(event, f) end

function entity:subscribe_once(event, f) end

function entity:unsubscribe(event, f) end

soup.kernel = kernel
soup.entity = entity

return soup
