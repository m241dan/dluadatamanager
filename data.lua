----------------------------------------------------------------
-- This is to act as a sort of virtual class/wrapper for data --
-- For optimization, data that inherits from this would be    --
-- best.                                                      --
----------------------------------------------------------------

local D = {}

D.__index = D -- for OOP mimicing

function D:new( i_path )
   -- OOP stuff
   local d = {}
   setmetatable( d, self )

   -- locals
   d.i_path = i_path or "none" 	-- interpreter path
   d.type = "bland"  		-- meaning there is nothing special about this data

   return d
   
end;

return D
