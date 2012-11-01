%Load in clean data
load cleandata_students.mat;

%Create a row vector of attributes
attributes = 1:45;

%binary targets
binary_targets = zeros(length(y),6);

%Turns emotions (y) 1-6 into 1,0 row vector for 
for emotion = 1:6,
    binary_targets(:,emotion) = CREATE_POSNEG(y, emotion);
end

disp('--------------------STARTING ALGORITHM-----------------------');
for emotion = 1:6,
    str = sprintf('CALLING DTL: examples - %d attributes - %d binary_targets - %d. \n', size(x, 1), length(attributes), length(binary_targets));
    disp(str);
    t{emotion} = DECISION_TREE_LEARNING(x, attributes, binary_targets(:,emotion));
    %t{emotion} = REDUCED(t{emotion}, x, binary_targets(:,emotion));
    DrawDecisionTree(t{emotion}, emolab2str(emotion));
end