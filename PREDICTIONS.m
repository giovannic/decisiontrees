function [predictions] = PREDICTIONS(t, x2)

predictions = zeros(length(x2), 1);
positive = [];
negative = [];

for example = 1:size(x2, 1),
  
  for emotion = 1:length(t),
      trees(emotion).no = emotion;
      trees(emotion).tree = t{emotion};
  end
  
  while (isempty(positive) && ~isempty(trees))
    %while no positive matches and there are trees left
    %breadth first search

    for i = 1:length(trees),
      
      attribute = trees(i).tree.op;
      
      if (isempty(attribute))
	  %leaf
	    if (trees(i).tree.class == 1)
	      positive = [positive; trees(i).no];
        else
	      negative = [negative; i];
	    end
      else
	    %walk the tree
        branch = x2(example, attribute) + 1;
	    trees(i).tree = trees(i).tree.kids{branch};
      end

    end
    
    %remove negatives
    trees(negative) = [];
    negative = [];

  end  
  
  %if positive is empty?
  predictions(example) = positive(randi(1:length(positive)));

end
