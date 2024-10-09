% load training data
training_data = "C:/Users/mansi/OneDrive/Desktop/CMPSC 497/lab10_training_data";
allImages = imageDatastore(training_data, 'IncludeSubfolders', true,'LabelSource', 'foldernames');

% split training and test images
[trainingImages, testImages] = splitEachLabel(allImages, 0.8, 'randomize');

% load alexnet
alex = alexnet;
layers = alex.Layers

layers(23) = fullyConnectedLayer(4);
layers(25) = classificationLayer

trainingImages.ReadFcn = @readFunctionTrain;
testImages.ReadFcn = @readFunctionTrain; % resize test images (see fcn)

options = trainingOptions('sgdm', ...
'MiniBatchSize',16, ...
'MaxEpochs',10, ...
'InitialLearnRate',0.001, ...
'Shuffle','every-epoch', ...
'ValidationData', testImages, ...
'ValidationFrequency',3, ...
'Verbose',false, ...
'Plots','training-progress');

bottle_net = trainNetwork(trainingImages,layers,options)

predictedLabels = classify(bottle_net, testImages); % run network with test images
accuracy = mean(predictedLabels == testImages.Labels) % find avg # correct
confusionchart(predictedLabels, testImages.Labels) % generate confusion matrix