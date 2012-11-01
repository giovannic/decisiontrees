function [ps] = PRED_SIMUL(t, x2)

    ps = zeros(1, size(x2, 1));
    for example = 1:size(x2, 1)
        curr_trees = cell(1, length(t));
        for i = 1:length(t)
            curr_trees{i} = t{i};
        end
        neg_trees = [];
        result = [];
        while ps(example) == 0
            for i = 1:length(curr_trees)
                if(~any(i==neg_trees))
                    %check all trees on each iteration unless already
                    %gotten to 0 node
                    this_tree = i;
                    node = curr_trees{i};
                    attribute = node.op;
                    if( ~x2(example, attribute) )
                        %take left (0) branch
                        curr_trees{i} = curr_trees{i}.kids{1};
                    else
                        curr_trees{i} = curr_trees{i}.kids{2};                    
                    end
                    if curr_trees{i}.class == 1
                        result = [result, i];
                    elseif curr_trees{i}.class == 0
                        neg_trees = [neg_trees i];
                    end
                end
            end
            if ~isempty(result)
                %----need to make random
                emotion = result( randi( 1:length( result) ) );
                ps(example) = emotion;
            end
            if isempty(result) && length(neg_trees) == length(curr_trees)
                ps(example) = NaN;
            end
        end
    end

end