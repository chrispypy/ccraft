os.loadAPI("/mods/H")
os.loadAPI("/mods/M")

-- D=128 => 513 Fuel

N = 1
if arg[1] then
  N = tonumber(arg[1])
end

liste = {}
nix = "nix"
D = 16 -- wie tief runter
print("Wie tief runter? ")
D = read()
HOCH = -8 -- wie weit hochholen
HOCH = 0 -- FIXME auf 0 lassen bitte, geht noch nicht
MAX_TRY = 20

function runter()
  local a,b = turtle.inspectDown()
  local name = b.name
  if not name then name = nix end
  if name == "minecraft:bedrock" then return false end
  if name == "minecraft:stone" then name = "minecraft:cobblestone" end
  if name == "minecraft:deepslate" then name = "minecraft:cobbled_deepslate" end
  if name == "minecraft:grass_block" then name = "minecraft:dirt" end

  local try = 0
  while not M.down() do
    turtle.digDown()
    try = try+1
    if try > MAX_TRY then
      return false
    end
  end

  table.insert(liste, 1, name)
  return true
end

function ONCE()
liste = {}
for d=1,D do
  if not runter() then
    break end end
print(#liste)
for h=1,#liste-HOCH do
  while not M.up() do
    turtle.digUp() end end
for d=1,#liste do
  if H.selectItem( liste[d] ) then
    turtle.placeDown()
  end
  M.fUp()
end
M.fForward()
for i=1,#liste-HOCH do M.fDown() end
for i=1,HOCH-#liste do M.fUp() end
end


for i=1,N do
  ONCE()
end



