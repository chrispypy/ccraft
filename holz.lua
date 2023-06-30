os.loadAPI("/mods/H")
os.loadAPI("/mods/M")

M.fGo("b")
L = 7
B = 2
sapling = "minecraft:oak_sapling"

for j=1,B do
for i=1,L do
  M.fGo("r")
  a,b = turtle.inspect()
  if b.name and b.name ~= sapling then
    shell.run("baum")
  end
  if H.selectItem( sapling ) then
    turtle.place()
  end
  M.fGo("lbbbb")
end
  M.fGo("flfflf")
end
M.fGo("f")


