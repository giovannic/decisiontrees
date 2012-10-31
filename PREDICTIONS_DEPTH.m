function [ps] = PREDICTIONS_DEPTH(t, x2)

    ps = zeros(size(x2, 1),1);

    for emotion = 1:length(t),
    %for each tree iterate produce a vector of predictions

        for example = 1:size(x2, 1),
            %for each example walk the tree to give prediction
            tree = t{emotion};
            while(~isempty(tree.kids)),
                tree = tree.kids{x2(example,tree.op) + 1};
            end
            if (ps(example) == 0 || randi(0:1)),
                ps(example) = emotion;
            end
        end 
    end
    
end
