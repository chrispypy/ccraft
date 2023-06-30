os.loadAPI("/mods/M")

MAX = 15 -- max height
UP = 0 -- actual height

for i=1,MAX do
  turtle.dig()
  M.fGo("u")
  UP = UP + 1
  if not turtle.detect() then
    break
  end
end

M.fGo(string.rep("d",UP))


