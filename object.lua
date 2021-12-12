--[[
  Simple object-oriented library for lua
  created by @jotapapel, 2021
--]]

local function _setfenv(a,b)for c=1,math.huge do local d=debug.getupvalue(a,c)if d==nil then break elseif d=="_ENV"then debug.upvaluejoin(a,c,function()return b end,1)break end end;return a end
local function def(a,b,c)(setfenv or _setfenv)(b,setmetatable(c or{self=a},{__index=_G,__newindex=a}))()return a end

local object = def({}, function()
	local function get(self, key) return self[key] end
	local function set(self, properties) for key, value in pairs(properties) do self[key] = value end end
	local function hash(self) return tostring(self):match("^.-%s(.-)$") end

	function create(prototype, ...)
		local object = setmetatable({prototype = prototype}, {__index = prototype})
		if prototype.constructor then prototype.constructor(object, ...) end
		return object
	end

	function prototype(arg1, arg2)
		local super, fn = arg2 and arg1, (arg1 and arg2) or arg1
		local prototype = setmetatable({super = super, get = get, set = set, hash = hash}, {__index = super, __call = self.create})
		return def(prototype, fn, {self = prototype, super = super})
	end
end);

return object
