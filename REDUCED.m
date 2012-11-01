function [ t2 ] = REDUCED( t1, xset, bset)

max = VALIDATE_ONE(t1, xset, bset);

total_internal_nodes = COUNT_INTERNAL_NODES(t1);
[o, z, m, n] = TreeTraverse2(t1, 0, 0, []);

start_tree = t1;

for i = 1:total_internal_nodes
    if m(i) ~= -1
        node_op   = n(i);
        occurence = sum(n(1:i) == n(i));
        temp_tree = start_tree;
        
        temp_tree = FIND_AND_REPLACE(temp_tree, m(i), n(i), occurence);
        val = VALIDATE_ONE(temp_tree, xset, bset);
        if(val >= max)
           %disp('made a prune!');
           %val
           max = val;
           start_tree = temp_tree;
        end
        
    end
end
t2 = start_tree;
end

function [ftree] = FIND_AND_REPLACE (stree, m, o, occurence)
    if isempty(stree.kids)
       ftree = stree; 
    else
        if stree.op == o
           occurence = occurence - 1;
           if occurence == 0
              ftree = struct('op', [], 'kids', [],'class', m);
              return;
           end
        end
        
        for i = 1:2
            stree.kids{i} = FIND_AND_REPLACE(stree.kids{i}, m, o, occurence);
        end
        ftree = stree;
    end
end

function [n2] = COUNT_INTERNAL_NODES(t)
    if isempty(t.kids)
        n2 = 0;
    else 
        sum = 0;
       for i = 1:2
          sum = sum + COUNT_INTERNAL_NODES(t.kids{i}); 
       end
       n2 = sum + 1;
    end
end



function [ ones, zeros, maxes, ops] = TreeTraverse2(t, o, z, m, n)
if(isempty(t.kids))
   ones  = 0;
   zeros = 0;
   maxes = [];
   ops   = [];
   if(t.class == 1)
    ones   = o + 1; 
   else
    zeros  = z + 1;
   end
else
    kids_zeros = 0;
    kids_ones  = 0;
    kids_maxes = [];
    kids_ops   = [];
    for u = 1:2
           [new_ones, new_zeros, new_maxes, new_ops] = TreeTraverse2(t.kids{u}, o, z, m);
           kids_zeros = kids_zeros + new_zeros;
           kids_ones  = kids_ones  + new_ones;
           kids_maxes = [kids_maxes, new_maxes];
           kids_ops   = [kids_ops, new_ops];
    end
    ones  = o + kids_ones;
    zeros = z + kids_zeros;
    
    
    max01 = SPECIAL_MAX(kids_ones, kids_zeros);
    
    maxes = [kids_maxes, max01]; 
    ops   = [kids_ops,   t.op ];
    
end

end


function [m] = SPECIAL_MAX(o, z)
    if o > z
        m = 1;
    elseif z > o
        m = 0;
    else
        m = -1;
    end
end