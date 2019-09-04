local function test()
    print("n is:")
    local function _inner()
        print("n in inner is:")
    end
    _inner()
    return _inner
end

local p1 = test()
