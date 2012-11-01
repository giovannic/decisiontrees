function [f1] = VALIDATE_ONE(tree, examples, binary_targets)
    
    ps = zeros(1,length(binary_targets));
    
    for example = 1:size(examples, 1),
            %for each example walk the tree to give prediction
            t = tree;
            while(~isempty(t.kids)),
                t = t.kids{examples(example,t.op) + 1};
            end
            ps(example) = t.class;
    end
    
    cm = CONFUSION_MATRIX(ps, binary_targets);
    recall_rate = cm(2,2) / sum(cm(2,:)) * 100;
    precision_rate = cm(2,2) / sum(cm(:,2)) * 100;
    f1 = 2 * precision_rate * recall_rate / (precision_rate + recall_rate);
end