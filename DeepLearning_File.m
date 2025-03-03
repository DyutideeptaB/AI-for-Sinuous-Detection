function [classes, predictedLabels_Test, score_Test, TestLabels, accuracy_Test, mynetOSAug, info] =... 
    DeepLearning_File(path, lgraph, patchSize, chnr, epochs, MiniBatchSize, InitialLearnRate,...
    LearnRateSchedule, LearnRateDropFactor, LearnRateDropPeriod, Shuffle, ValidationPatience,...
    GradientThreshold, ExecutionEnvironment)

%% Set up our training data

ImageLocation = path; %define the location the main folder names Patches

% allImages = imageDatastore(ImageLocation, 'IncludeSubfolders', true,...
%     'LabelSource', 'foldernames','FileExtensions','.img', 'ReadFcn', @readPatch);
allImages = imageDatastore(ImageLocation, 'IncludeSubfolders', true,...
    'LabelSource', 'foldernames', 'FileExtensions', '.img', 'ReadFcn', @readPatchWithProcessing);
classes = unique(allImages.Labels);

%% Creating the validation (15 %), testing (15%) and training image dataset (70 %)
[trainingImages, ValidationImages, TestImages] = splitEachLabel(allImages, 0.7, 0.15, 0.15, "randomized");

%% Oversampling sinuous rille images (minority classes) within the training data only
idx = trainingImages.Labels == ['sinuous-rille-' num2str(patchSize) '-' num2str(patchSize)];
rilleds = subset(trainingImages,idx);

if patchSize == 25 %Oversampled 9 times
    trainingImagesOS = imageDatastore(cat(1, trainingImages.Files, rilleds.Files, rilleds.Files, rilleds.Files,...
    rilleds.Files, rilleds.Files, rilleds.Files, rilleds.Files, rilleds.Files, rilleds.Files),...
    'FileExtensions','.img', 'ReadFcn',@readPatchWithProcessing);
    trainingImagesOS.Labels = cat(1, trainingImages.Labels, rilleds.Labels, rilleds.Labels, rilleds.Labels,...
    rilleds.Labels, rilleds.Labels, rilleds.Labels, rilleds.Labels, rilleds.Labels, rilleds.Labels);
end

if patchSize == 50 %Oversampled 7 times
    trainingImagesOS = imageDatastore(cat(1, trainingImages.Files, rilleds.Files, rilleds.Files, rilleds.Files,...
    rilleds.Files, rilleds.Files, rilleds.Files, rilleds.Files),...
    'FileExtensions','.img', 'ReadFcn',@readPatchWithProcessing);
    trainingImagesOS.Labels = cat(1, trainingImages.Labels, rilleds.Labels, rilleds.Labels, rilleds.Labels,...
    rilleds.Labels, rilleds.Labels, rilleds.Labels, rilleds.Labels);
end

if patchSize == 100 %Oversampled 5 times
    trainingImagesOS = imageDatastore(cat(1, trainingImages.Files, rilleds.Files, rilleds.Files, rilleds.Files,...
    rilleds.Files, rilleds.Files),...
    'FileExtensions','.img', 'ReadFcn',@readPatchWithProcessing);
    trainingImagesOS.Labels = cat(1, trainingImages.Labels, rilleds.Labels, rilleds.Labels, rilleds.Labels,...
    rilleds.Labels, rilleds.Labels);
end

if patchSize == 200 %Oversampled 2 times
    trainingImagesOS = imageDatastore(cat(1, trainingImages.Files, rilleds.Files, rilleds.Files),...
    'FileExtensions','.img', 'ReadFcn',@readPatchWithProcessing);
    trainingImagesOS.Labels = cat(1, trainingImages.Labels, rilleds.Labels, rilleds.Labels);
end

if patchSize == 500 %Oversampled 1 times
    trainingImagesOS = imageDatastore(cat(1, trainingImages.Files, rilleds.Files),...
    'FileExtensions','.img', 'ReadFcn',@readPatchWithProcessing);
    trainingImagesOS.Labels = cat(1, trainingImages.Labels, rilleds.Labels);
end

%% Create augmented datastore for the oversampled training image datastore
imageAugmenter = imageDataAugmenter('RandRotation',[-10,10]);
imageSize = [patchSize patchSize chnr];
trainingImagesOSAug = augmentedImageDatastore(imageSize, trainingImagesOS, "DataAugmentation", imageAugmenter);
ValidationImagesAug = augmentedImageDatastore(imageSize, ValidationImages, "DataAugmentation", imageAugmenter);
TestImagesAug = augmentedImageDatastore(imageSize, TestImages, "DataAugmentation", imageAugmenter);

%% Creating The Network Parameters
ValFrequency = floor(numel(trainingImagesOSAug.Files)/ MiniBatchSize);

% Defining the options for training the network
opts = trainingOptions('adam', 'InitialLearnRate', InitialLearnRate,...
    'LearnRateSchedule', LearnRateSchedule,...
    'LearnRateDropFactor', LearnRateDropFactor,...
    'LearnRateDropPeriod', LearnRateDropPeriod,...
    'GradientThreshold', GradientThreshold,...
    'MaxEpochs', epochs,...
    'MiniBatchSize', MiniBatchSize,...
    'ExecutionEnvironment',ExecutionEnvironment, ...
    'Shuffle',Shuffle, ...
    'ValidationData', ValidationImagesAug, ...
    'ValidationFrequency', ValFrequency, ...
    'ValidationPatience', ValidationPatience,...
     Plots = 'training-progress', Verbose = true);

%% Assigning weighted classification
numClasses = numel(classes);

%% Changing the input and output layers of the pre-trained networks
if isequal(lgraph, CustomNetwork()) 
    lgraph = layerGraph(lgraph);
    % Replacing Input Layer
    inLayer = imageInputLayer([patchSize patchSize chnr]);
    name1 = lgraph.Layers(1).Name;
    lgraph = replaceLayer(lgraph, name1, inLayer);
else
    inLayer = imageInputLayer([patchSize patchSize chnr]);
    name1 = lgraph.Layers(1).Name;
    lgraph = replaceLayer(lgraph, name1, inLayer);
end


%% Calling the Network to run
[mynetOSAug, info] = trainNetwork(trainingImagesOSAug, lgraph, opts); %defining network and the information to be printed with it

%% Labels
TestLabels = TestImages.Labels;

%% Measure network accuracy on test data
[predictedLabels_Test, score_Test] = classify(mynetOSAug, TestImages);
accuracy_Test = mean(predictedLabels_Test == TestLabels);