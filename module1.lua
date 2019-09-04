local test = 1
local _M = {}
print("after test", test)
print("after member", _M.member1)
function _M:alter()
    test = test + 1
    self.member1 = self.member1 + 1
    print("in alter, test", test)
    print("in alter, member", self.member1)
end

_M.member1 = 1
print("after", _M.member1)
return _M