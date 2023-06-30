
function dig(c)
  if c == "f" then turtle.dig() end
  if c == "d" then turtle.digDown() end
  if c == "u" then turtle.digUp() end
end

if arg[1] == nil then return end
for i = 1,#arg[1] do
  dig(arg[1]:sub(i,i))
end

