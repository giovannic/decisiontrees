function [predictions] = PREDICTIONS(t, x2)

predictions = [];
  
for tree = 1:length(t),

  for example = 1:size(x2, 1),
    attribute = t(tree).op;
    while (attribute),
      tree(t) = tree(t).kids{x2(example, attribute)};
    
  end  

end
