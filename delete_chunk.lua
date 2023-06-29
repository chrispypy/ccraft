os.loadAPI("mods/H")
os.loadAPI("mods/M")


t = turtle
if not arg[1] then
	error("Dimendsion der Baustelle erforderlich.")
end

DIM = tonumber(arg[1])

if DIM % 2 ~= 0 then
	error("Nur gerade Abmessungen erlaubt.")
end

function delete_three_layers()
	M.fDown(2)

	for i=1,DIM/2 do
		delete_stips()
		if i < DIM/2 then
			M.left()
			M.fForward()
			M.left()
		end
	end
end

function delete_stip()
	for i=1,DIM-1 do
		t.dig()
		t.digDown()
		t.digUp()
		M.fForward()
	end
	
	t.digDown()
	t.digUp()
end

function delete_stips()
	delete_stip()

	M.right()
	t.dig()
	M.fForward()
	M.right()

	delete_stip()
	H.removeTrash()
end

function delete_all_layers()
	while true do
		delete_three_layers()
		M.right()
		M.fForward(M.getY())
		M.fDown()
		M.right()
		a,b = t.inspectDown()
		if b.name and b.name == "minecraft:bedrock" then
			break
		end
	end
	M.forceHome()
end
delete_all_layers()
