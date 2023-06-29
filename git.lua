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
	local src_file = fs.open(shell.dir()..'/temp', 'r')
	local src = src_file.readAll()
	src_file.close()
	shell.run('rm '..shell.dir()..'/temp')
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
			saveFile = api_dir..str
