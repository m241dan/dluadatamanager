----------------------------------------------------------------
-- This is to act as a sort of virtual class/wrapper for data --
-- For optimization, data that inherits from this would be    --
-- best.                                                      --
----------------------------------------------------------------
local LFS = require( "lfs" )
local Luatils = require( "luautils" )

local D = {}

D.all = {}
D.__index = D -- for OOP mimicing
D.type = "basic"
D.interp_path = "none"
D.save_loc = "./"
D.save_name = "default"

function D:raw()
   -- OOP stuff
   local d = {}
   setmetatable( d, self )

   return d
   
end;

function D:new()
   local d = D:raw()
   D.all[#D.all+1] = d
   return d
end;

function D:save()
   local f = io.open( self.save_loc .. self.save_name .. ".lua", "w" )
   -- sanity check
   if( not f ) then
      print( self.type .. ": could not execute save function." )
      return
   end

   Luatils.save( self, f )
   f:close()
end;

function D.load( path )
   local d = dofile( path )

   if( not d ) then
      print( "Could not load " .. path .. "." )
      return nil
   end

   setmetatable( d, self )

   return d
end;

-- This is meant to just be a default fallback. Data types that inherit from this class should define their own serialize method, it'll be faster
function D:serialize()
   local lib_name = getmetatable( self )
   lib_name = table.getKey( package.loaded, lib_name )
   if( not lib_name ) then
      return "COULD_NOT_FIND"
   end

   return lib_name .. ".load( \"" .. self.save_loc .. self.save_name .. ".lua\" )"

end;

function D:setSaveName( name )
   if( type( name ) ~= "string" ) then
      print( "D:setSaveName: argument passed must be a string." )
      return
   end
   self.save_name = name
end;

function D:setSaveLoc( path )
   if( not LFS.dir( path ) ) then
      print( "Directory " .. path .. " does not exist, cannot set as new save location." )
      return
   end
   self.save_loc = path
end;

function D:setInterp( path )
   if( not Luatils.fileExists( path ) ) then
      print( "File " .. path .. " does not exist, cannot set the new interp." )
      return   
   end
   self.interp_path = path
end;

return D
