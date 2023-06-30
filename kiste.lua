os.loadAPI("/mods/H")
os.loadAPI("/mods/M")

items = {
"sugar_cane",
"oak_log",
"wheat",
}
compost = {
"minecraft:wheat_seeds",
"occultism:datura_seeds",
}
for i=1,#items do
  items[i] = "minecraft:"..items[i]
end

M.fGo(string.rep("f",18))
H.unloadItems(items)
M.fGo("lfruf")
H.unloadItemsDown(compost)
M.fGo("bdlbr")
M.fGo(string.rep("b",18))

