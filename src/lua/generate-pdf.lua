-- generate-pdf.lua

-- This grabs the first arg
local cbeta_id = arg[1]
if not cbeta_id then
    print("Usage: lua script.lua <CBETA_ID>")
    os.exit(1)
end

local basex = "./basex/bin/basex"
local publish_dir = "./publish"
local bxs = "./src/bxs/generate-pdf.bxs"

os.execute("mkdir -p " .. publish_dir)

local command = string.format(
    '%s -bpublish-path=%s -bcbeta-id="%s" -c %s',
    basex, publish_dir, cbeta_id, bxs
)
os.execute(command)

os.execute("rm -f " .. publish_dir .. "/*.log " .. publish_dir .. "/*.aux")
