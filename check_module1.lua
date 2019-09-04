package.path = "./?.lua;"..package.path
local test_module = require("module1")

test_module:alter()

os.execute("sleep "..60)