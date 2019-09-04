package.path = './?.lua;./app/?.lua;./lib/?.lua;./lib/?/init.lua;/usr/local/openresty/lualib/?.lua;/opt/openresty/lualib/?.lua;;'
package.cpath = './?.so;./lib/?.so;./lib/resty/iconv/?.so;/usr/local/openresty/lualib/?.so;/home/hkr/git-rock-server-backup/lib/resty/iconv/?.so;/opt/openresty/lualib/?.so;;'

--local redis = require "resty.redis"
--local utility = require "common"
--local cache_key = "flowcounting_msfid_and_time1"
--local connection_name = "_flowcounting_timer_cache"
--local cjson = require("cjson.safe")
--
--local red = redis:new()
--red:set_timeout(1000) -- 1 sec
--local ok, err = red:connect("127.0.0.1", 6399)
--if not ok then
--    ngx.say("failed to connect: ", err)
--    return
--end 

-- local ok, err = red:auth(conf.pwd)
-- if not ok then
--   return nil, err
-- end
-- local timestamp = ngx.now() * 1000
-- local res, err = red:zadd(cache_key, timestamp, 123)
-- print("res: "..res)
-- if err or not res or ngx.null == res then
--     ngx.log(ngx.ERR, "add flowcounting cache msfid("..") failed", err)
--     return 1001
-- end
-- 
-- local res, err = red:zrange(cache_key, 0, 4, 'WITHSCORES')
-- if err or not res or ngx.null == res then
--     print("zrange: "..utility.dump(res))
-- end
-- 
-- if not next(res) then
--     print("zrange is empty")
-- end
-- 
-- local function callback()
--     print("the callback is called: "..ngx.now()*1000)
-- end
-- 
-- ngx.timer.at(1560253055414, callback)
--local test = {}
--table.insert(test, "FlowCounting")
--table.insert(test, "TripWire")
--
--local test_string = cjson.encode(test)
--print("cjson: "..test_string)
--local res, err = red:hset("_cache_msf_with_msfid", "6968713a-c0b5-452f-8442-65ea01f65b96", test_string)
--local res, err = red:hget("_cache_msf_with_msfid", "6968713a-c0b5-452f-8442-65ea01f65b96")
--if res then
--    print("hget: "..res)
--end



-- iconv
local redis = require("iconv")

function check_one(to, from, text)
  print("\n-- Testing conversion from " .. from .. " to " .. to)
  local cd = iconv.new(to .. "//TRANSLIT", from)
  assert(cd, "Failed to create a converter object.")
  local ostr, err = cd:iconv(text)

  if err == iconv.ERROR_INCOMPLETE then
    print("ERROR: Incomplete input.")
  elseif err == iconv.ERROR_INVALID then
    print("ERROR: Invalid input.")
  elseif err == iconv.ERROR_NO_MEMORY then
    print("ERROR: Failed to allocate memory.")
  elseif err == iconv.ERROR_UNKNOWN then
    print("ERROR: There was an unknown error.")
  end
  print(ostr)
end
a = nil
check_one("GBK", "UTF-8", a)
