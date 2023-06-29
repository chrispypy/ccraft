X,Y,Z = 0,0,0
Face = 0



--
--   Face:
--       x+
--       0 
-- y- 3     1 y+
--       2 
--       x-
--

function left(n)
	if not n then n = 1 end
	for i=1,n do
		Face = (Face+3)%4
		turtle.turnLeft()
	end
	return true
end

function right(n)
	if not n then n = 1 end
	for i=1,n do
		Face = (Face+1)%4
		turtle.turnRight()
	end
	return true
end

function down(n)
	if turtle.getFuelLevel() == 0 then turtle.refuel() end
	if not n then n=1 end
	for i=1,n do
		if not turtle.down() then return false end
		Z = Z-1
	end
	return true
end
function up(n)
	if turtle.getFuelLevel() == 0 then turtle.refuel() end
	if not n then n=1 end
	for i=1,n do
		if not turtle.up() then return false end
		Z = Z+1
	end
	return true
end

function forward(n)
	if turtle.getFuelLevel() == 0 then turtle.refuel() end
	if not n then n = 1 end
	for i =1,n do
		if not turtle.forward() then return false end
		if Face == 0 then X = X+1
		elseif Face == 1 then Y = Y+1
		elseif Face == 2 then X = X-1
		elseif Face == 3 then Y = Y-1
		end
	end
	return true
end

function back(n)
	if turtle.getFuelLevel() == 0 then turtle.refuel() end
	if not n then n = 1 end
	for i =1,n do
		if not turtle.back() then return false end
		if Face == 0 then X = X-1
		elseif Face == 1 then Y = Y-1
		elseif Face == 2 then X = X+1
		elseif Face == 3 then Y = Y+1
		end
	end
	return true
end

function fDown(n)
	if turtle.getFuelLevel() == 0 then turtle.refuel() end
	if not n then n=1 end
	local a, b = turtle.inspectDown()
	if b.name and b.name == 'minecraft:bedrock' then return false end
	for i=1,n do
		while not down() do
			turtle.digDown()
		end
		Z = Z-1
	end
	return true
end

function fUp(n)
	if turtle.getFuelLevel() == 0 then turtle.refuel() end
	if not n then n=1 end
	for i=1,n do
		while not up() do
			turtle.digUp()
		end

	end
end

function fForward(n)
	if not n then n = 1 end
	for i =1,n do
		while not forward() do turtle.dig() end
	end
end

function fBack(n)
	if not n then n = 1 end
	for i=1,n do
		while not back() do
			right(2)
			turtle.dig()
			right(2)
		end
	end
end

function go(str)
  for i=1,#str do
    if str[i] == "f" then forward() end
    if str[i] == "b" then back() end
    if str[i] == "u" then up() end
    if str[i] == "d" then down() end
    if str[i] == "r" then right() end
    if str[i] == "l" then left() end
  end
end

function fGo(str)
  for i=1,#str do
    if str[i] == "f" then fForward() end
    if str[i] == "b" then fBack() end
    if str[i] == "u" then fUp() end
    if str[i] == "d" then fDown() end
    if str[i] == "r" then right() end
    if str[i] == "l" then left() end
  end
end



function forceHome()
	while Face ~= 2 and X > 0 do right() end
	fForward(X)
	while Face ~= 0 and X < 0 do right() end
	fForward(-X)
	while Face ~= 3 and Y > 0 do right() end
	fForward(Y)
	while Face ~= 1 and Y < 0 do right() end
	fForward(-Y)
	if Z < 0 then
		fUp(-Z)
	else
		fDown(Z)
	end
end

--
--   Face:
--       x+
--       0 
-- y- 3     1 y+
--       2 
--       x-
--
-- getters

function getFace()
	return Face
end

function getX()
	return X
end
function getY()
	return Y 
end

function getZ()
	return Z 
end
