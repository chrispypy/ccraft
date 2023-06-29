local progs = {'delete_chunk', 'wall'}
local apis = {'h.lua','m.lua'}
local function loading(text,n)
	for i=1,n-1 do
		local x,y = term.getCursorPos()
		print(text..string.rep('.',i))
		os.sleep(.2)
		term.setCursorPos(x,y)
		term.clearLine()
	end
	os.sleep(.2)
	print(text..string.rep('.',n))
end

local function done()
	print('done!')
end

loading('initializing', 4)
done()
url = ('https://github.com/chrispypy/ccraft/blob/master/')
os.sleep(.1)
loading('preparing to install vim', 3)
shell.run('pastebin run eX0BrfjA')
loading('setting up directories', 3)
shell.run('mkdir mods')
print('created directory mods')
shell.run('mkdir programs')
print('created directory programs')
loading('preparing to install local git client', 3)
shell.run('wget https://github.com/chrispypy/ccraft/blob/master/git.lua programs/git.lua')
done()
for _, name in pairs({'delete_chunk', 'wall', 'h.lua', 'm.lua'}) do
	shell.run('programs/git pull' .. name)
end





