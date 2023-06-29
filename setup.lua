print('initializing...')
url = ('https://github.com/chrispypy/ccraft/blob/master/')
os.sleep(.1)
print('preparing to install vim...')
shell.run('pastebin run eX0BrfjA')
print('setting up directories...')
os.sleep(.3)
shell.run('mkdir mods')
shell.run('mkdir programs')
print('Downloading files from git...')
shell.run('wget https://github.com/chrispypy/ccraft/blob/master/git.lua programs/git.lua')
for _, name in pairs({'delete_chunk', 'wall', 'h.lua', 'm.lua'}) do
	shell.run('programs/git pull' .. name)
end





