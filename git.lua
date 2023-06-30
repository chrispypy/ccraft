local download_url = 'https://raw.githubusercontent.com/chrispypy/ccraft/master/'
local list_url = 'https://github.com/chrispypy/ccraft'
local prog_dir = '/programs/'
local prog_dir_old = prog_dir..'old/'
local api_dir = '/mods/'
local api_dir_old = api_dir..'old/'



local description = 'Local git client for downloading files from repository ccraft'

local usage = 'Usage: \n'..
	      '>>git pull "file" ["/path/to/savefile"]\n'..
	      '--Downloads file "file" and saves it to "/path/to/savefile".\n'..
	      '>>git pull all\n'..
	      '--Downloads all files in repository and saves them intelligently\n'..
	      '>>git list\n'..
	      '--lists available files in the repository'

local function listFiles(files)
	for i,v in pairs(files) do
		print(tostring(i)..': '..v)
	end
end

local function fetchFiles()
	shell.run('wget '..list_url..' temp')
	local src_file = fs.open('temp', 'r')
	local src = src_file.readAll()
	src_file.close()
	shell.run('rm temp')
	local filename_iter = src:gmatch('\"[^\"/]+\.lua\"')
	local files = {}
	local counter = 1
	while true do
		local filename = filename_iter()
		if not filename then break end
		files[counter] = filename:sub(2,-2)
		counter = counter+1
	end
	return files
end

local allFiles = fetchFiles()
shell.run('clear')

local function contains(elem,list)
	for _,v in pairs(list) do
		if v == elem then
			return true
		end

	end
	return false
end


local function pull(fileName, saveFile)
	if not fileName then
		print('No file name specified, aborting!')
		return
	end
	local file_split = fileName:gmatch("[^.]+")
	local name = file_split()
	if not contains(name..'.lua',allFiles) then
		print(fileName..' not found, aborting!')
		return false
	end
	if not saveFile then
		if #name == 1 then
			saveFile = api_dir..string.upper(name)
			shell.run('rm '..api_dir_old..'.lua')
			shell.run('mv '..saveFile..' '..api_dir_old)
		else 
			saveFile = prog_dir..name..'.lua' 
			shell.run('rm '..prog_dir_old..name..'.lua')
			shell.run('mv '..saveFile..' '..prog_dir_old)

		end
	end
	print('Downloading '..fileName..' to '..saveFile..'...')
	shell.run('wget '..download_url..name..'.lua '..saveFile)
	print('done!')
end

function push(fileName)
	if fileName:sub(1,1) ~= '/' then
		fileName = shell.dir()..'/'..fileName
	end
	file = fs.open(fileName)
	if not file then print('File not found, aborting!') end
	content = file.readAll()
	file.close()
	msg = fileName..'\n'..commit_msg..'\n'..content
	address = 'http://82.167.177.70:8000'
	print('pushing '..fileName..' to remote repository..')
	http.post(adress, msg)
	print('done!')

end


-- start of script

if not fs.exists(prog_dir) then
	print('Program directory not found, creating: '..prog_dir)
	shell.run('mkdir '..prog_dir)
end
if not fs.exists(api_dir) then
	print('Api directory not found, creating: '..api_dir)
	shell.run('mkdir '..api_dir)
end
if not fs.exists(api_dir_old) then
	print('Api old directory not found, creating: '..api_dir_old)
	shell.run('mkdir '..api_dir_old)
end
if not fs.exists(prog_dir_old) then
	print('Program old directory not found, creating: '..prog_dir_old)
	shell.run('mkdir '..prog_dir_old)
end
local cmd = arg[1]

if not cmd then
	print('Missing command, run git help for advice!')
	return
end


if cmd == 'help' then
	shell.run('clear')
	print(description)
	print(usage)
	return
end

if cmd == 'list' then
	shell.run('clear')
	listFiles(allFiles)
	return
end

if cmd == 'pull' then
	shell.run('clear')
	local file = arg[2]
	local dest = arg[3]
		if file == 'all' then
			local files = fetchFiles()
			for _,fileName in pairs(files) do
				pull(fileName)
			end

		else

			pull(file, dest)
		end
	return
end

if cmd == 'push' then
	local file = arg[2]
	push(file)
end








