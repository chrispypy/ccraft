url = 'https://raw.githubusercontent.com/chrispypy/ccraft/master/'

if arg[1] == 'push' or arg[1] ==  'commit' then
	print('Leider noch nicht implementiert :(')
elseif arg[1] ~= 'pull' then
	print('unknown argument: '..arg[1])
else
	print(shell.run('wget '..url .. arg[2]..' '..arg[2]))
end


