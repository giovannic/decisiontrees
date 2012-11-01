function [ best ] = CHOOSE_BEST_DECISION_ATTRIBUTE( examples, attributes, binary_targets )
%str = sprintf('    CBD: examples - %d attributes - %d binary_targets - %d. \n', size(examples, 1), length(attributes), length(binary_targets));
%disp(str);
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

biggest = 0;
best    = [];

%num_examples = size(examples, 1);

for i = 1:length(attributes)
    np = sum(binary_targets(:) == 1);
    nn = sum(binary_targets(:) == 0);
    
    ptne = 0;
    ntpe = 0;
    ptpe = 0;
    ntne = 0;
    
    test = sum(examples(:, attributes(i)) == 1);
    
    for j = 1:size(examples, 1)
       if binary_targets(j)     == 1 && examples(j, attributes(i)) == 0
           ptne = ptne + 1;
       elseif binary_targets(j) == 1 && examples(j, attributes(i)) == 1
           ptpe = ptpe + 1;
       elseif binary_targets(j) == 0 && examples(j, attributes(i)) == 1
           ntpe = ntpe + 1;
       elseif binary_targets(j) == 0 && examples(j, attributes(i)) == 0
           ntne = ntne + 1;
       end
       
    end
   
  all_gain = ENTROPY((np/(np + nn)), (nn/(np + nn)));
  
  if ptpe == 0 || ntpe == 0
     active_gain = 0;
  else
     active_gain = ENTROPY((ptpe/(ntpe + ptpe)), (ntpe/(ntpe + ptpe)));
  end
    if ptne == 0 || ntne == 0
        dormant_gain = 0;
    else
        dormant_gain = ENTROPY((ptne/(ntne + ptne)), (ntne/(ntne + ptne)));
    end
  gain(i) = all_gain - ((ntpe + ptpe)/(np + nn))*active_gain - ((ntne + ptne)/(np + nn))*dormant_gain;
  
 
  if gain(i) > biggest
     biggest = gain(i);
     best    = attributes(i);
  end
  
end

if biggest < 0.07,
    best = [];
end
end



