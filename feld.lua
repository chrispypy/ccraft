os.loadAPI("/mods/H")
os.loadAPI("/mods/M")

L = 8
B = 8
seeds = "minecraft:wheat_seeds"

M.fGo("fffffffru")

for j=1,B do
for i=1,L do
  a,b = turtle.inspectDown()
  if b and b.state and b.state.age == 7 then
    turtle.digDown()
  end
  if H.selectItem( seeds ) then
    turtle.placeDown()
  end
  M.fGo("f")
end
M.fGo(string.rep("b",L))
M.fGo("lfr")
end
M.fGo("dlbbbbbbb")
M.fGo(string.rep("b",B))

