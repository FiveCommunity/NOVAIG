SERVER = IsDuplicityVersion()
CLIENT = not SERVER

function table.maxn(t)
	local max = 0
	for k,v in pairs(t) do
		local n = tonumber(k)
		if n and n > max then max = n end
	end
	return max
end

local modules = {}
function module(rsc, path)
	if path == nil then
		path = rsc
		rsc = "vrp"
	end

	local key = rsc..path
	local module = modules[key]
	if module then
		return module
	else
		local code = LoadResourceFile(rsc, path..".lua")
		if code then
			local f,err = load(code, rsc.."/"..path..".lua")
			if f then
				local ok, res = xpcall(f, debug.traceback)
				if ok then
					modules[key] = res
					return res
				else
					error("error loading module "..rsc.."/"..path..":"..res)
				end
			else
				error("error parsing module "..rsc.."/"..path..":"..debug.traceback(err))
			end
		else
			error("resource file "..rsc.."/"..path..".lua not found")
		end
	end
end

local function wait(self)
	local rets = Citizen.Await(self.p)
	if not rets then
		rets = self.r 
	end
	return table.unpack(rets,1,table.maxn(rets))
end

local function areturn(self, ...)
	self.r = {...}
	self.p:resolve(self.r)
end

function async(func)
	if func then
		Citizen.CreateThreadNow(func)
	else
		return setmetatable({ wait = wait, p = promise.new() }, { __call = areturn })
	end
end

function parseInt(v)
	local n = tonumber(v)
	if n == nil then 
		return 0
	else
		return math.floor(n)
	end
end

function parseDouble(v)
	local n = tonumber(v)
	if n == nil then n = 0 end
	return n
end

function parseFloat(v)
	return parseDouble(v)
end

local sanitize_tmp = {}
function sanitizeString(str, strchars, allow_policy)
	local r = ""
	local chars = sanitize_tmp[strchars]
	if chars == nil then
		chars = {}
		local size = string.len(strchars)
		for i=1,size do
			local char = string.sub(strchars,i,i)
			chars[char] = true
		end
		sanitize_tmp[strchars] = chars
	end

	size = string.len(str)
	for i=1,size do
		local char = string.sub(str,i,i)
		if (allow_policy and chars[char]) or (not allow_policy and not chars[char]) then
			r = r..char
		end
	end
	return r
end

function splitString(str, sep)
	if sep == nil then sep = "%s" end

	local t={}
	local i=1

	for str in string.gmatch(str, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end

	return t
end

function joinStrings(list, sep)
	if sep == nil then sep = "" end

	local str = ""
	local count = 0
	local size = #list
	for k,v in pairs(list) do
		count = count+1
		str = str..v
		if count < size then str = str..sep end
	end
	return str
end

function convertSeconds(seconds)
	local seconds = tonumber(seconds)
  
	if seconds <= 0 then
	  return "00:00";
	else
	  hours = string.format("%02.f", math.floor(seconds/3600));
	  mins = string.format("%02.f", math.floor(seconds/60 - (hours*60)));
	  return hours.." hora(s) "..mins.." minuto(s)"
	end
end

function generateStringNumber(format)
	local abyte = string.byte("A")
	local zbyte = string.byte("0")
	local number = ""
	for i=1,#format do
		local char = string.sub(format,i,i)
    	if char == "D" then number = number..string.char(zbyte+math.random(0,9))
		elseif char == "L" then number = number..string.char(abyte+math.random(0,25))
		else number = number..char end
	end
	return number
end

function table.contains(table, element)
	for _, value in pairs(table) do
	  if value == element then
		return true
	  end
	end
	return false
end
  

if CLIENT then
	function isTableEquals(t1, t2)
		local ty1 = type(t1)
		local ty2 = type(t2)
		if ty1 ~= ty2 then return false end
		
		if ty1 ~= 'table' and ty2 ~= 'table' then return t1 == t2 end
		
		for k1, v1 in pairs(t1) do
			local v2 = t2[k1]
			if v2 == nil or not isTableEquals(v1, v2) then return false end
		end
		
		for k2, v2 in pairs(t2) do
			local v1 = t1[k2]
			if v1 == nil or not isTableEquals(v1, v2) then return false end
		end
		return true
	end
end