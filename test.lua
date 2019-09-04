local _M = { }
_M.a = 0

function _M:new(obj)
	obj = obj or {}
	setmetatable(obj, {__index = self})
	self.b = 0
	return obj
end

function _M:printtbl()
	print("the origin p1:", self.a)
end
	

local p1 = _M:new()
local p2 = _M:new()
print("the origin p1:", p1.b)
print("the origin p2:", p2.b)
p1.b = 2
print("the now p1:", p1.b)
print("the now p2:", p2.b)
