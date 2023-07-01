os.loadAPI('/mods/H')
os.loadAPI('/mods/M')
HT = 3
LEN = 3

function enterKiste()
    M.go("lf")
end
function exitKiste()
    M.go("br")
end

-- turtle steht vor der Kiste und nimmt anzahl * item raus
-- returnt wieviel tatsächlich genommen wurden
function takeItem(item, anzahl)
    local kiste = peripheral.wrap("front")
    inhalt = kiste.list()
    genommen = 0
    for i=1,#inhalt do
        if item == inhalt[i].name then
            count = inhalt[i].count
            if count < anzahl-genommen then
                pullItems(kiste, i, count)
                genommen = genommen + count
            else
                pullItems(kiste, i, anzahl-genommen)
                break
            end
        end
    end
    return genommen
end

function refuel()
    anzahl = 12
    kohle = "minecraft:coal"
    kohleKiste = liste[kohle]
    if not kohleKiste then return end
    goToKiste( kohleKiste )
    enterKiste()
    takeItem( kohle, anzahl )
    exitKiste()
    M.home()
end

function storeItem(item)
    if not item then return end
    kiste = liste[item]
    if not kiste then return end
    goToKiste( kiste )
    enterKiste()
    unloadToKiste( kiste )
    exitKiste()
    M.home()
end


function goToKiste(kiste)
	if not kiste then
		return
	end
	local x = math.floor(kiste/HT)
	local y = math.mod(kiste, HT)
	M.forward(2*x+1)
	M.up(y)
end

function registerItem(kiste, item)
	liste[item] = kiste
	saveListe(liste)
end

function goToItem(item)
	goToKiste( liste[item] )
end


function scanKiste(kiste)
	local chest = peripheral.wrap('front')
	local contents = chest.list()
	for _,item in pairs(contents) do
		if item then
			registerItem(kiste, item)
		end

	end
	M.back()
	M.right()
end

function unloadToKiste(kiste)
	local inv = H.getInventory()
	for _,item in pairs(inv) do
		if liste[item] == kiste then
			H.unloadItems({item})
		end
	end
end



function main()

	M.right()
	takeAllItems()
	M.left()

	for i=1,16 do
		local item = turtle.getItemDetail(i)
		if item and item.name then
			storeItem(item.name)
		end
	end

	H.unloadItemsDown(H.getInventory())

 kontrolliereKisten()
end

function kontrolliereKisten()
 for i=1,HT*LEN do
  goToKiste(i)
  enterKiste()
  scanKiste()
  exitKiste()
  M.home()
 end
end

function takeAllItems()
	start_slot = turtle.getSelectedSlot()
	for i =1,16 do
		turtle.suck()
	end
	turtle.select(start_slot)
	
end


function saveListe(liste)
	local file = fs.open("/data/storageList.txt","w")
	if not file or H.len(liste) == 0 then
		return false
	end
	file.write(textutils.serialize(liste))
 file.close()
	return true
end


function loadListe()
	local file = fs.open('/data/storageList.txt', 'r')
	if not file then
		return false
	end
 local	liste =  textutils.unserialize(file.readAll())
 file.close()
 return liste
end

liste = loadListe()
main()
