-- Meta class

local function deep_copy(orig)
  local copy
  if type(orig) == "table" then
    copy = {}
    for orig_key, orig_value in next, orig, nil do
      copy[deep_copy(orig_key)] = deep_copy(orig_value)
    end
    setmetatable(copy, deep_copy(getmetatable(orig)))
  else
    copy = orig
  end
  return copy
end

function super(cls)
    m1 = getmetatable(cls)
    return m1
end

function class(constructor, super_obj)
    if super_obj then
        base_obj = super_obj:new()
    else
        base_obj = {}
    end
    function base_obj:new()
        constructor_copy = nil
        if constructor then
            constructor_copy = deep_copy(constructor)
        end
        inner_o = constructor_copy or {}
        setmetatable(inner_o, base_obj)
        base_obj.__index = self
        return inner_o
    end
    base_obj.__call = function(self)
        return self:new()
    end
    --print("return ", inner_o)
    return base_obj
end

ObjectOri = class({name="ObjectOri"})
Object = class({name="Object"}, ObjectOri)

function Object:debugStr()
    print("Class Name:", self.name, "Object ori:", self)
end

Animal = class({name="Animal"}, Object)
Dog = class({name="Dog"}, Animal)
Cat = class({name="Cat"}, Animal)

Object():debugStr()
Animal():debugStr()
Dog():debugStr()
Cat():debugStr()
Cat():debugStr()
Cat():debugStr()
