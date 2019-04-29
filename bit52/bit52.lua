local M = {}

M.and52 = function(v1, v2)
	local hi = 0x80000000
	local low = 0x7fffffff
	local hi1 = math.floor(v1 / hi)
	local hi2 = math.floor(v2 / hi)
	local low1 = bit.band(v1, low)
	local low2 = bit.band(v2, low)
	local h = bit.band(hi1, hi2)
	local l = bit.band(low1, low2)
	return h*hi + l
end

M.or52 = function(v1, v2)
	local hi = 0x80000000
	local low = 0x7fffffff
	local hi1 = math.floor(v1 / hi)
	local hi2 = math.floor(v2 / hi)
	local low1 = bit.band(v1, low)
	local low2 = bit.band(v2, low)
	local h = bit.bor(hi1, hi2)
	local l = bit.bor(low1, low2)
	return h*hi + l
end

M.xor52 = function(v1, v2)
	local hi = 0x80000000
	local low = 0x7fffffff
	local hi1 = math.floor(v1 / hi)
	local hi2 = math.floor(v2 / hi)
	local low1 = bit.band(v1, low)
	local low2 = bit.band(v2, low)
	local h = bit.bxor(hi1, hi2)
	local l = bit.bxor(low1, low2)
	return h*hi + l
end

M.not52 = function(v1)
	local hi = 0x80000000
	local low = 0x7fffffff
	local hi1 = math.floor(v1 / hi)
	local low1 = bit.band(v1, low)
	local h = bit.bnot(hi1)
	local l = bit.bnot(low1)
	return h*hi + l
end

M.ls52 = function(num, bits)
	return num * math.pow(2, bits)
end

M.rs52 = function(num, bits)
	return math.floor(num / math.pow(2, bits))
end

M.to_num = function(bits)
	local t = 0
	for i,v in ipairs(bits) do
		t = t + v*math.pow(2, #bits-i)
	end
	return t
end

M.to_ary = function(num, bits)
	bits = bits or math.max(1, select(2, math.frexp(num)))
	local t = {}
	for b = bits, 1, -1 do
		t[b] = math.fmod(num, 2)
		num = math.floor((num - t[b]) / 2)
	end
	return t
end

M.reverse = function(num, bits)
	local ary = M.to_ary(num, bits)
	local tmp = {}
	for i=1,#ary do
		table.insert(tmp, ary[#ary-i+1])
	end
	return M.to_num(tmp)
end

return M
