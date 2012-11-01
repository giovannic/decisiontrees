function [p] = PREDICTIONS_DEPTH(t, x2)

    p = zeros(1,size(x2, 1));
    ps = zeros(length(t),size(x2, 1));
    positives = zeros(length(t), 1);
    
    for emotion = 1:length(t),
    %for each tree iterate produce a vector of predictions

        for example = 1:size(x2, 1),
            %for each example walk the tree to give prediction
            depth = 0;
            tree = t{emotion};
            while(~isempty(tree.kids)),
                tree = tree.kids{x2(example,tree.op) + 1};
                depth = depth + 1;
            end
            if (tree.class == 1),
                positives(emotion) = positives(emotion) + 1;
                ps(emotion, example) = 1;
            end
        end
        
    end
    
    for example = 1:size(x2, 1),
            trues = find(ps(:, example));
            [~, best] = max(positives(trues));
            if(~isempty(best)),
                p(example) = best;
            end
    end
    
end