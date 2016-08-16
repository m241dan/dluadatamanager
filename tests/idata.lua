local Data = require( "data" )

local I = Data:new()

I.__index = I

function I:new()
   i = {}
   setmetatable( i, self )

   return i;
end;


return I
