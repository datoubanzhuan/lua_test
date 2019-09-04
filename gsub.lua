function string.tohex(str)
    return (str:gsub('.', function (c)
        return string.format('%02X', string.byte(c))
    end))
end
a = 1

print(string.tohex(a))

print(a)
