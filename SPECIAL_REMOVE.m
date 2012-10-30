function [ ret ] = SPECIAL_REMOVE( items, item_to_remove )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
ret = [];
for i=1:length(items)
   if items(i) ~= item_to_remove
       ret = [ret, items(i)];
   end    
end

end

