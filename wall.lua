zz = false

if #arg > 0 then
	if arg[1] == "zickzack" then
		zz = true
	end
end

print("Wie hoch soll die Mauer sein?\n")
height = tonumber(read())

print("\nWie lang soll die Mauer werden?\n")
lenght = tonumber(read())


print("ich brauche ca. ".. height*lenght.." FUEL und Blöcke!")

function go_to_floor()
	while true do
		if not turtle.detectDown() then
			turtle.down()
		else
			break
		end
	end
end

function select_slot()
	for i=1,16 do
		if turtle.getItemCount(i) > 0 then
			turtle.select(i)
			return
		end
	end
end


function build_strip()
	for i=1,height do
		select_slot()
		turtle.digUp()
		turtle.up()
		turtle.placeDown()
	end
	while true do
		if turtle.detect() then
			turtle.digUp()
			turtle.up()
		else
			break
		end
	end
	turtle.forward()
	go_to_floor()
end

function build_wall()
	go_to_floor()
	for i=1,lenght do
		build_strip()
	end
end

build_wall()
