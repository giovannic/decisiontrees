
function [ tree ] = DECISION_TREE_LEARNING( examples, attributes, binary_targets )
if all((binary_targets) == binary_targets(1))
    %all examples have the same value of binary_targets
    tree = struct('op', [], 'kids', [],'class', binary_targets(1));
elseif isempty(attributes)
    %attributes is empty
    tree = struct('op', [], 'kids', [], 'class', mode(binary_targets));
else
    best_attribute = CHOOSE_BEST_DECISION_ATTRIBUTE(examples, attributes, binary_targets);   %implement
    for u = 0:1,
        [sub_examples, sub_targets] = FILTER(examples, best_attribute, u, binary_targets);
        if isempty(sub_examples)
         %   tree.kids{u + 1} = struct('op', [], 'kids', [],'class', mode(binary_targets));
            tree = struct('op', [], 'kids', [],'class', mode(binary_targets));
            return;
        else
            sub_attributes = attributes;
            sub_attributes(sub_attributes == best_attribute) = [];
            tree.kids{u + 1} = DECISION_TREE_LEARNING(sub_examples, sub_attributes, sub_targets);
        end
    end
       
    tree.op    = best_attribute;
    tree.class = [];
end
end

