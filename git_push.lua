
filename = arg[1]
password = ""

print("Commit Nachricht für "..filename..": ")
commit_msg = read()

file = fs.open(shell.dir()..'/'..filename, "r")
content = file.readAll()
file.close()

msg = password.."\n"..filename.."\n"..filename..": "..
      commit_msg.."\n"..content
address = "http://82.165.177.70:8000"

http.post(address, msg)
print("Pray to God it worked /\\")



