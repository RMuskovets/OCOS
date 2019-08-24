local files = {
	"init.lua"
}

local repo = "RMuskovets/OCOS"

local fs = require "filesystem"

function print(...)
	local args = table.pack(...)
	local stdout = io.stdout
	local pre = ""
	for i = 1, args.n do
		stdout:write(pre, (assert(tostring(args[i]), "'tostring' must return a string to 'print'")))
		pre = "\t"
	end
	stdout:write("\n")
	stdout:flush()
end

for index, file in pairs(files) do
	local handle=component.proxy(component.list("internet")()).request("https://raw.githubusercontent.com/"..repo..[[/master/]]..file)
	local data, chunk = ""
	while true do chunk=handle.read(math.huge) if chunk then data=data..chunk else break end end handle.close()
	local fh = io.open(file, "w")
	if not fh:write(data) then
		print("Failed writing file " .. file)
	end
	fh:close()
end