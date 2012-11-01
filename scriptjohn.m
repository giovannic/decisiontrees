load cleandata_students.mat;
emotion_to_test_for = input('Enter emotion to test for');
attributes          = 1:45;
posneg              = CREATE_POSNEG(y, emotion_to_test_for);

disp('-----------------Drawing & Printing------------');

xset = x(1:100, :);
bset = posneg(1:100);



tree = DECISION_TREE_LEARNING(x(101:length(x), :), attributes, posneg(101:length(posneg)));
disp('--------------INITAL VALUE---------------------');
value = VALIDATE_ONE(tree, xset, bset);
value
DrawDecisionTree(tree, 'Test');
DrawDecisionTree(REDUCED(tree, xset, bset, value));