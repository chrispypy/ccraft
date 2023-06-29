TRASHLIST = {'minecraft:cobblestone',
	     'minecraft:dirt',
	     'minecraft:andesite',
	     'minecraft:diorite',
	     'minecraft:cobbled_deepslate',
	     'minecraft:sand',
	     'minecraft:mossy_cobblestone',
	     'minecraft:gravel',
	     'minecraft:granite',
	     'rootsclassic:verdant_sprig',
	     'rootsclassic:nightshade',
	     'rootsclassic:whitecurrant',
	     'minecraft:stick',
	     'minecraft:tuff',
	     'rootsclassic:blackcurrant',
	     'rootsclassic:redcurrant',

}


function isTrash(item_id)
	for _,trash in pairs(TRASHLIST) do
		if trash == item_id then
			return true
		end
	end

end

function removeTrash()
	local start_slot = turtle.getSelectedSlot()
	inv = getInventory()
	for _,trash in pairs(TRASHLIST) do
		i = find(trash, inv)
		if i then 
			turtle.select(i)
			turtle.drop()
		end
	end
	turtle.select(start_slot)
	cleanInv()
end


function find(item, list)
	for i,v in ipairs(list) do
		if v == item then
			return i
		end
	end
	return false
end

function getIndexOf(list, item)
	local index = {}
	for i,v in ipairs(list) do
		if v == item then table.insert(index, i) end
	end
	return index
end

function len(table)
	local i = 0
	for _,_ in pairs(table) do 
		i = i+1
	end
	return i
end

function getInventory()
	local start_slot = turtle.getSelectedSlot()
	local inventory = {}
	for i=1,16 do
		local item = turtle.getItemDetail(i)
		if item then
			inventory[i] = item.name
		else
			inventory[i] = false
		end

	end
	return inventory
end

function selectItem(item)
	local inv = getInventory()
	local i = find(item, inv)
	if i then
		turtle.select(i)
		return true
	end
	return false

end

function unloadItems(items)
	for _,item in pairs(items) do
		while selectItem(item) do
			turtle.drop()
		end
	end
end

function unloadItemsDown(items)
	for _,item in pairs(items) do
		while selectItem(item) do
			turtle.dropDown()
		end
	end
end

function cleanInv()
	local selected = turtle.getSelectedSlot()
	local inv = getInventory()
	for i=1,#inv do
	local inv = getInventory()
		if inv[i] then
			local index = getIndexOf(inv, inv[i])
			if len(index) > 1 then
				local main_index = index[#index]
				for j=#index-1,1,-1 do
					turtle.select(index[j])
					turtle.transferTo(main_index)
				end
			end
		end

	end
	turtle.select(selected)
end

function saveTable(path, table)
	local file = fs.open(path,"w")
	file.write(textutils.serialize(table))
	file.close()
	return true
end
function loadTable(path)
	local file = fs.open(path,"r")
	local data = file.readAll()
	file.close()
	return textutils.unserialize(data)
end


