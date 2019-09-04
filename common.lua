
local _M = {
    _VERSION = '0.01'
}

-- Convert table to string to help printing and debugging.
function _M.dump(v)
    if not __dump then
    	function __dump(v, t, p)    
			local k = p or "";

			if type(v) ~= "table" then
				table.insert(t, k .. " : " .. tostring(v));
			else
				for key, value in pairs(v) do
					__dump(value, t, k .. "[" .. key .. "]");
				end
			end
		end
	end 
	local t = {'\n'};
	__dump(v, t);
    return table.concat(t, "\n->> ") .. '\n'
end

-- Remove spaces around the word
function _M.trim(s)
    return (ngx.re.gsub(s, "^\\s*(.*?)\\s*$", "$1", "jo"))
end


-- source: https://github.com/bigplum/lua-resty-mongol/issues/33
local function _convertHexStringToNormal(str)
    return (str:gsub(
        "..",
        function(cc)
            return string.char(tonumber(cc, 16))
        end
    ))
end



-- 将数字字符串转换为数字 --
function _M.convert_string_to_number(num)
    local number
    local convert = function()
        number = tonumber(num)
    end
    if num then
        pcall(convert)
    end
    return number
end

local function _positive_integer(num)
    local pattern = '^[1-9][0-9]*$'
    return string.find(num, pattern)
end

-- 分页数据处理 --
function _M.deal_page(page_no, page_size)
    
    local no = page_no
    local size = page_size

    -- 判断page_no是否为空或者正整数，是则返回默认值1
    if not no or not _positive_integer(no) then
        no = 1
    end

    -- 判断page_size是否为空或者正整数，是则返回默认值10
    if not size or not _positive_integer(size) then
        size = 10
    end
   
    return tonumber(no), tonumber(size)
end


function _M.redis_channelname(ip, port)
    return table.concat({"client", ngx.re.gsub(ip, "\\.", "_", "jo"), port}, "_")
end

function _M.convert_address_to_channelname(address)
    return "client".."_"..ngx.re.gsub(address, "\\.", "_", "jo")
end

-- 将yyyy-MM-dd HH:mm:ss时间格式的字符串装换成时间戳
function _M.convert_string_to_timestamp(str)
    local y, mon, d, h, min, sec
    y = string.sub(str, 1, 4)
    mon = string.sub(str, 6, 7)
    d = string.sub(str, 9, 10)
    h = string.sub(str, 12, 13)
    min = string.sub(str, 15, 16)
    sec = string.sub(str, 18, 19)
    local timestamp = os.time({year = y, month = mon, day = d, hour = h, min = min, sec = sec}) * 1000

    return timestamp
end

-- 将字符串转换成Unicode格式
function _M.convert_string_to_unicode(str)
    local tag = '\\u'
    local step = 4
    local index = 0
    local a, b
    local s = ''

    for i=1, #str, 4 do
        a = string.sub(str, i,i +1)
        b = string.sub(str, i + 2,i + 3)
        s = s .. tag .. b .. a
    end

    return s
end

-- merge the src_tbl to dest_tbl, not working with number index
function _M.merge_table(dest_tbl, src_tbl)
    for k,v in pairs(src_tbl) do
        dest_tbl[k] = v
    end
end

-- bind the function and object. eg. bind(obj, "obj_function")
-- @t: object
-- @k: function(character stirng)
function _M.bind(t, k)
    return function(...) return t[k](t, ...) end
end



return _M
