%% Define all variables and run the training file
global patchSize
global currentCombination
global chnr

%% Uncomment the bands you want to select.

%% For MI
% bandnr = 2:10;
% chnr = 9; % write the number of vis-nir channels we want to arbitrarily select
% vis_nir_combs = nchoosek(bandnr, chnr);
% for i = height(vis_nir_combs)
%     currentCombination = [1 vis_nir_combs(i,:)];
% end

%% For RGB type
currentCombination = [1, 5, 10]; % 3 channels
chnr = length(currentCombination);

patchSizes = [100, 200]; %
addpath('./Networks');
networkNames = {'CustomNetwork' 'MyResNet50' 'MyGoogleNet'}; 
epochs = 30; 
InitialLearnRate = 0.001; 
LossFunction = 'crossentropy';
LearnRateSchedule = "piecewise";
LearnRateDropFactor = 0.2;
LearnRateDropPeriod = 5;
Shuffle = 'every-epoch';
ValidationPatience = 5;
GradientThreshold = Inf; % default value for all the other networks
ExecutionEnvironment = 'gpu';

%Create directory for saving the training plots into

myDir1 = ['TestResults_DL_' num2str(chnr) 'C'];
myDir2 = 'TrainingPlots';
myDir3 = 'Data';
if ~exist(myDir1, 'dir')
    mkdir(['./' myDir1 '/' myDir2])
    mkdir(['./' myDir1 '/' myDir3])
end

% Run the training for the different networks across all patch sizes

for patchSizeNr = 1:length(patchSizes)
    patchSize = patchSizes(patchSizeNr);
    path = ['C:\Patches\Patches' num2str(patchSize)];

    if patchSize == 200
        MiniBatchSize = 64;
    elseif patchSize == 100
        MiniBatchSize = 64;
    else
        MiniBatchSize = 50;
    end

    for networkNameNr = 1:length(networkNames)
        try
            networkName = networkNames{networkNameNr};
            if ~exist(['./' myDir1 '/' myDir3 '/' networkName num2str(patchSize) '.mat'],'file')
                disp([networkName num2str(patchSize) ': starting!']);
            lgraph = feval(networkName);
            [classes, predictedLabels_Test, score_Test, TestLabels, accuracy_Test, mynetOSAug, info] =...
                DeepLearning_File(path, lgraph, patchSize, chnr, epochs, MiniBatchSize, InitialLearnRate,...
                LearnRateSchedule, LearnRateDropFactor, LearnRateDropPeriod, Shuffle, ValidationPatience,...
                GradientThreshold, ExecutionEnvironment);
            save(['./' myDir1 '/' myDir3 '/' networkName num2str(patchSize) '.mat'], '-v7.3');
            currentfig = findall(groot, 'Tag', 'NNET_CNN_TRAININGPLOT_UIFIGURE');
            savefig(currentfig,['./' myDir1 '/' myDir2 '/' networkName num2str(patchSize) '.fig']);
            % saveas(currentfig,['./' myDir '/' networkName num2str(patchSize) '.png']);
            close(currentfig);
            gpuDevice(1);
            else
                disp([networkName num2str(patchSize) ': skipping!']);
            end
        catch
            disp([networkName num2str(patchSize) ' is not working!']);
        end
    end
end
