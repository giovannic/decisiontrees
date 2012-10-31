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

folds = 10;
fold_size = round(length(y)/10);
predictions = zeros(folds, length(y));

%cross validation
for fold = 1:folds,
    s = ((fold - 1) * fold_size) + 1;
    e = s + fold_size;
    train_x = x(s:e,:);
    for emotion = 1:6,
        train_targets = binary_targets(s:e,emotion);
        t{emotion} = DECISION_TREE_LEARNING(train_x, attributes, train_targets);
    end
    test_x = x;
    test_x(s:e,:) = [];
    predictions(fold, :) = PREDICTIONS_DEPTH(t, test_x);
end