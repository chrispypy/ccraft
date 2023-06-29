os.loadAPI('/mods/H')
os.loadAPI('/mods/M')

function connected(liste, str)
  if not str then str = "" end
  local done = false

  while not done do
  while true do

    if M.detectUp(liste) then
      str = str.."u"
      M.fGo("u")
      break
    end

    M.fGo("r")
    if M.detect(liste) then
      str = str.."rf"
      M.fGo("f")
      break
    else
      M.fGo("l")
    end

    if M.detect(liste) then
      str = str.."f"
      M.fGo("f")
      break
    end

    if M.detectDown(liste) then
      str = str.."f"
      M.fGo("f")
      break
    end

    M.fGo("l")
    if M.detect(liste) then
      str = str.."lf"
      M.fGo("f")
      break
    else
      M.fGo("r")
    end

    -- nothing found, go back
    if #str == 0 then
      done = true
      break
    end
    local last = string.sub(str, -1, -1)
    str = string.sub(str, 1, -2)
    M.fGo( M.rev(last) )

  end -- while true
  end -- while not done

end
