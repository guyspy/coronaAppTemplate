local M = {}

M.fileExists = function(fileName, base)
  assert(fileName, "fileName is missing")
  local base = base or system.ResourceDirectory
  local filePath = system.pathForFile( fileName, base )
  local exists = false

  if (filePath) then -- file may exist. won't know until you open it
    local fileHandle = io.open( filePath, "r" )
    if (fileHandle) then -- nil if no file found
      exists = true
      io.close(fileHandle)
    end
  end

  return(exists)
end

M.printTable = function ( table, stringPrefix )
  if not stringPrefix then
    stringPrefix = "### "
  end
  if type(table) == "table" then
    for key, value in pairs(table) do
      if type(value) == "table" then
        print(stringPrefix .. tostring(key))
        print(stringPrefix .. "{")
        M.printTable(value, stringPrefix .. "   ")
        print(stringPrefix .. "}")
      else
        print(stringPrefix .. tostring(key) .. ": " .. tostring(value))
      end
    end
  end
end



return M