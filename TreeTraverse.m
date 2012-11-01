
function [ ones, zeros ] = TreeTraverse(t, o, z)
if(isempty(t.kids))
   ones  = 0;
   zeros = 0;
   if(t.class == 1)
    ones   = o + 1; 
   else
    zeros  = z + 1;
   end
   str = sprintf('Leaf node value: %d Ones: %d Zeros: %d', t.class, ones, zeros);
   disp(str);   
   if(zeros == 2)
       disp('MAKE THIS ZERO!!!!!!!!!!!!!!!'); 
   end
else
    kids_zeros = 0;
    kids_ones  = 0;
    for u = 1:2
           [new_ones, new_zeros] = TreeTraverse(t.kids{u}, o, z);
           kids_zeros = kids_zeros + new_zeros;
           kids_ones  = kids_ones  + new_ones;
    end
    ones  = o + kids_ones;
    zeros = z + kids_zeros;
    str = sprintf('Internal Node value: %d Ones: %d Zeros: %d', t.op, ones, zeros);
    disp(str);
    
    if(ones / (ones + zeros) < 0.1)
       disp('MAKE THIS ZERO!!!!!!!!!!!!!!!!!!!!!'); 
    end    
    
end
end

