function [ best ] = CHOOSE_BEST_DECISION_ATTRIBUTE( examples, attributes, binary_targets )
%str = sprintf('    CBD: examples - %d attributes - %d binary_targets - %d. \n', size(examples, 1), length(attributes), length(binary_targets));
%disp(str);
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

p        = sum(examples(:) == 1); %number of positive examples
n        = sum(examples(:) == 0); %number of negative examples
infopn   = INFORMATION(p, n);
bestinfo = 0;
best     = attributes(1);

for i=1:length(attributes) %lets look at each attribute to see which is the beststr 
   % str = sprintf('    i = %d', i);
   % disp(str);
    p0 = 0; n0 = 0;
    p1 = 0; n1 = 0;
    
    for j=1:size(examples, 1)
     %    str = sprintf('    j = %d', j);
     %    disp(str);
        %postive example where attribute is negative
        if binary_targets(j) == 1 && examples(j, attributes(i)) == 0
            p0 = p0 + 1;
        %postive example where attribute is positive
        elseif binary_targets(j) == 1 && examples(j, attributes(i)) == 1
            p1 = p1 + 1;
        %negative example where attribute is negative
        elseif binary_targets(j) == 0 && examples(j, attributes(i)) == 0
            n0 = n0 + 1;
        %negative example where attribute is positive
        elseif binary_targets(j) == 0 && examples(j, attributes(i)) == 1
            n1 = n1 + 1;
        end    
    end
remainder = (((p0 + n0)/(p + n)) * INFORMATION(p0, n0)) + (((p1 + n1)/(p + n)) * INFORMATION(p1, n1));
gain      = infopn - remainder;  

if gain >= bestinfo
   if gain > bestinfo
     best     = attributes(i);
     bestinfo = gain;
   else
     if randi([0,1])   %There is a tie, if 1 swap if 0 leave as is
        best     = attributes(i);
        bestinfo = gain;
     end
   end
end
    
end

end



