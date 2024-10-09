training_data = "C:/Users/mansi/OneDrive/Desktop/CMPSC 497/training_data";
good_cookie = "C:/Users/mansi/OneDrive/Desktop/CMPSC 497/training_data/good_cookie";
broken_cookie = "C:/Users/mansi/OneDrive/Desktop/CMPSC 497/training_data/broken_cookie";

allImages = imageDatastore(training_data, 'IncludeSubfolders', true, 'LabelSource', 'foldernames');

% Split data into training (80%)and test (20%) sets
[trainingImages, testImages] = splitEachLabel(allImages, 0.8, 'randomize');

alex = alexnet;

% Review Network Architecture
layers = alex.Layers;

% Modify Pre-trained Network
% AlexNet was trained to recognize 1000 classes, we need to modify it to
% recognize just 5 classes.
layers(23) = fullyConnectedLayer(2); % change this based on # of classes
layers(25) = classificationLayer

% Perform Transfer Learning (can be adjusted)
opts = trainingOptions('sgdm', 'InitialLearnRate', 0.001, ...
'MaxEpochs', 5, 'MiniBatchSize', 10);

% Set custom read function (this code is available in link)
trainingImages.ReadFcn = @readFunctionTrain; % resize

% Train the Network (may take 5 to 15+ minutes)
% Create a new network built on Alexnet w new layers
myNet = trainNetwork(trainingImages, layers, opts);

% Test Network Performance on Test Images
testImages.ReadFcn = @readFunctionTrain; % resize
predictedLabels = classify(myNet, testImages); % test
accuracy = mean(predictedLabels == testImages.Labels)

