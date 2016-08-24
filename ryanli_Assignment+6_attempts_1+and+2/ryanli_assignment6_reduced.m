% 
%  ______  __  __  ______  __   __       __      __       ______  ______  ______ __  __  ______  __  ______  __  __  ______    
% /\  == \/\ \_\ \/\  __ \/\ "-.\ \     /\ \    /\ \     /\  ___\/\  __ \/\  == /\ \_\ \/\  == \/\ \/\  ___\/\ \_\ \/\__  _\   
% \ \  __<\ \____ \ \  __ \ \ \-.  \    \ \ \___\ \ \    \ \ \___\ \ \/\ \ \  _-\ \____ \ \  __<\ \ \ \ \__ \ \  __ \/_/\ \/   
%  \ \_\ \_\/\_____\ \_\ \_\ \_\\"\_\    \ \_____\ \_\    \ \_____\ \_____\ \_\  \/\_____\ \_\ \_\ \_\ \_____\ \_\ \_\ \ \_\   
%   \/_/ /_/\/_____/\/_/\/_/\/_/ \/_/     \/_____/\/_/     \/_____/\/_____/\/_/   \/_____/\/_/ /_/\/_/\/_____/\/_/\/_/  \/_/   
%   
% RYAN LI, COPYRIGHT, 2016
% ELEC 345, ASSIGNMENT 6, RICE UNIVERSITY
% FILE 1, Algorithm on Reduced Set of Images

clear all
close all
clc

warning('off','all')
warning

%% Training Data Importing and SIFT Processing (Reduced Data Set)

% I have two computers, thus I need this to accomondate two different
% enviornments
try
    run('/Users/RyanLi/Documents/vlfeat-0.9.20/toolbox/vl_setup.m')
    fileFolder_training = fullfile('/Users/RyanLi/Documents/midterm_data/midterm_data_reduced/TrainingDataset')
catch err
    disp('Mac File Folder Not Found.')
    disp('Switching to Windows Mode Now.')
    run('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\vlfeat-0.9.20\toolbox\vl_setup.m')
    fileFolder_training = fullfile('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\midterm_data\midterm_data_reduced\TrainingDataset')
end

% Buddha Images
disp('Start Image Importing and SIFT...')
dirOutput_training_buddha = dir(fullfile(fileFolder_training,'022.buddha-101','*.jpg'));
fileNames_buddha= {dirOutput_training_buddha.name}';
disp('Analyzing Buddha Set...')
for i = 1:length(fileNames_buddha)
    imageTemp = imread(fileNames_buddha{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    buddha(i,1).name = fileNames_buddha{i};
    buddha(i,1).metadata = f;
    buddha(i,1).descriptor = single(d);
end
% Butterfly Images
dirOutput_training_butterfly = dir(fullfile(fileFolder_training,'024.butterfly','*.jpg'));
fileNames_butterfly= {dirOutput_training_butterfly.name}';
disp('Analyzing Butterfly Set...')
for i = 1:length(fileNames_butterfly)
    imageTemp = imread(fileNames_butterfly{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    butterfly(i,1).name = fileNames_butterfly{i};
    butterfly(i,1).metadata = f;
    butterfly(i,1).descriptor = single(d);
end
% Airplane Images
dirOutput_training_airplanes = dir(fullfile(fileFolder_training,'251.airplanes','*.jpg'));
fileNames_airplanes= {dirOutput_training_airplanes.name}';
disp('Analyzing Airplane Set...')
for i = 1:length(fileNames_airplanes)
    imageTemp = imread(fileNames_airplanes{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    airplane(i,1).name = fileNames_airplanes{i};
    airplane(i,1).metadata = f;
    airplane(i,1).descriptor = single(d);
end
disp('Train Image Import and SIFT Processing Done.')

%% Cluster SIFT Features
N = 1000; % cluster size
tic; % Start stopwatch timer for the clustering progress
disp('Start Clustering Analysis...')
bagofFeatures = [];
for i = 1:length(buddha)
    bagofFeatures = horzcat(bagofFeatures, buddha(i,1).descriptor);
end
for i = 1:length(butterfly)
    bagofFeatures = horzcat(bagofFeatures, butterfly(i,1).descriptor);
end
for i = 1:length(airplane)
    bagofFeatures = horzcat(bagofFeatures, airplane(i,1).descriptor);
end
[centers,assignment] = vl_kmeans(bagofFeatures, N, 'Initialization', 'plusplus', 'Algorithm', 'Elkan');

disp('Clustering Analysis Done.')
disp('The Total Time Consumed for SIFT Feature Clustering...')
toc % Terminate stopwatch timer

%% Historgram and Bin Analysis with
disp('Start Histogram Analysis...')
% "Find how many SIFT features from that class?s 
% training images belong to each of the SIFT descriptor clusters"
% For this reduced data set, it menas that bins number are 1000
codebook = transpose(centers);

% modelling for buddha
disp('Start Analyzing Histogram on Buddha Class.')
tic;
final_idx = [];
for i = 1:length(fileNames_buddha)
    % query points for buddha class
    query_pt_buddha = transpose(buddha(i,1).descriptor);
    % knn-search for each image.
    [tempIdx,tempDistance] = knnsearch( codebook, query_pt_buddha);
    buddha(i,1).idx = tempIdx;
    buddha(i,1).distance = tempDistance;
end
% find metrics for thresholding
for i = 1:length(fileNames_buddha)
    distanceMean(i) = mean(buddha(i,1).distance);
end
buddha_std = std(distanceMean); % standard diviation
buddha_mean = mean(distanceMean); % mean
% thresholding
for i = 1:length(buddha)
    j=1;
    while j <= length(buddha(i,1).distance)
        if abs( buddha(i,1).distance(j) - buddha_mean ) >= buddha_std
            % set it as bad feature
            buddha(i,1).idx(j) = [];
            buddha(i,1).distance(j) = [];
        end
        j = j + 1;
    end
    % making the final matrix of index
    final_idx = vertcat( final_idx, buddha(i,1).idx);
end
% Creating Histogram
ux = [1:N];
counts = hist(final_idx,ux);
bins = unique(final_idx);
normalize_factor = length(bins);
model_buddha = (counts / normalize_factor);
% % plot the histogram
% figure
% hist(model_buddha,N);
% title('Histogram for Buddha Class');
% toc;

% modelling for Butterfly
disp('Start Analyzing Histogram on Butterfly Class.')
tic;
final_idx = [];
for i = 1:length(fileNames_butterfly)
    % query points for buddha class
    query_pt = transpose(butterfly(i,1).descriptor);
    % knn-search for each image.
    [tempIdx,tempDistance] = knnsearch( codebook, query_pt);
    butterfly(i,1).idx = tempIdx;
    butterfly(i,1).distance = tempDistance;
end
% find metrics for thresholding
for i = 1:length(fileNames_butterfly)
    distanceMean(i) = mean(butterfly(i,1).distance);
end
butterfly_std = std(distanceMean); % standard diviation
butterfly_mean = mean(distanceMean); % mean
% thresholding
for i = 1:length(butterfly)
    j=1;
    while j <= length(butterfly(i,1).distance)
        if abs( butterfly(i,1).distance(j) - butterfly_mean ) >= butterfly_std
            % set it as bad feature
            butterfly(i,1).idx(j) = [];
            butterfly(i,1).distance(j) = [];
        end
        j = j + 1;
    end
    % making the final matrix of index
    final_idx = vertcat( final_idx, butterfly(i,1).idx);
end
% Creating Histogram
ux = [1:N];
counts = hist(final_idx,ux);
bins = unique(final_idx);
normalize_factor = length(bins);
model_butterfly = (counts / normalize_factor);
% % plot the histogram
% figure
% hist(model_butterfly,N);
% title('Histogram for Butterfly Class');
% toc;

% modelling for Airplane
disp('Start Analyzing Histogram on Airplanes Class.')
tic;
final_idx = [];
for i = 1:length(fileNames_airplanes)
    % query points for buddha class
    query_pt = transpose(airplane(i,1).descriptor);
    % knn-search for each image.
    [tempIdx,tempDistance] = knnsearch( codebook, query_pt);
    airplane(i,1).idx = tempIdx;
    airplane(i,1).distance = tempDistance;
end
% find metrics for thresholding
for i = 1:length(fileNames_airplanes)
    distanceMean(i) = mean(airplane(i,1).distance);
end
airplane_std = std(distanceMean); % standard diviation
airplane_mean = mean(distanceMean); % mean
% thresholding
for i = 1:length(airplane)
    j=1;
    while j <= length(airplane(i,1).distance)
        if abs( airplane(i,1).distance(j) - airplane_mean ) >= airplane_std
            % set it as bad feature
            airplane(i,1).idx(j) = [];
            airplane(i,1).distance(j) = [];
        end
        j = j + 1;
    end
    % making the final matrix of index
    final_idx = vertcat( final_idx, airplane(i,1).idx);
end
% Creating Histogram
ux = [1:N];
counts = hist(final_idx,ux);
bins = unique(final_idx);
normalize_factor = length(bins);
model_airplane = (counts / normalize_factor);
% % plot the histogram
% figure
% hist(model_airplane,N);
% title('Histogram for Airplane Class');
% toc;
figure 
subplot(3,1,1)
hist(model_buddha,N);
title('Histogram For Buddha Classes')
subplot(3,1,2)
hist(model_butterfly,N);
title('Histogram For Butterfly Classes')
subplot(3,1,3)
hist(model_airplane,N);
title('Histogram For Airplane Classes')

%% TESTING
% ==============================================================
disp('')
disp('===========================')
disp('Starting Testing Process...')

%% Find the SIFT feature descriptors within each test image
% importing test images
try
    % windows directory
    disp('Using Windows Directory')
    fileFolder_testing_1 = fullfile('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\midterm_data\midterm_data_reduced\TestDataset_1')
    dirOutput_testing_1 = dir(fullfile(fileFolder_testing_1,'*.jpg'));
    fileNames_testing_1= {dirOutput_testing_1.name}';

    fileFolder_testing_2 = fullfile('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\midterm_data\midterm_data_reduced\TestDataset_2')
    dirOutput_testing_2 = dir(fullfile(fileFolder_testing_2,'*.jpg'));
    fileNames_testing_2= {dirOutput_testing_2.name}';

    fileFolder_testing_3 = fullfile('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\midterm_data\midterm_data_reduced\TestDataset_3')
    dirOutput_testing_3 = dir(fullfile(fileFolder_testing_3,'*.jpg'));
    fileNames_testing_3= {dirOutput_testing_3.name}';
catch err
    % mac directory
    disp('Using Windows Directory')
end
% finding SIFT featires
disp('Start Test Image SIFT Analysis...')
% test image 1
disp('Analyzing Test Set 1...')
tic;
for i = 1:length(fileNames_testing_1)
    imageTemp = imread(fileNames_testing_1{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    test1(i,1).name = fileNames_testing_1{i};
    test1(i,1).metadata = f;
    test1(i,1).descriptor = single(d);
end

% test image 2
disp('Analyzing Test Set 2...')
for i = 1:length(fileNames_testing_2)
    imageTemp = imread(fileNames_testing_2{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    test2(i,1).name = fileNames_testing_2{i};
    test2(i,1).metadata = f;
    test2(i,1).descriptor = single(d);
end

% test image 3
disp('Analyzing Test Set 3...')
for i = 1:length(fileNames_testing_3)
    imageTemp = imread(fileNames_testing_3{i});
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    imageTemp = single(imageTemp);
    [f,d] = vl_sift(imageTemp);
    test3(i,1).name = fileNames_testing_3{i};
    test3(i,1).metadata = f;
    test3(i,1).descriptor = single(d);
end
toc;
disp('Test Image Import and SIFT Processing Done.')


%% Find images catagories
disp('Start Analyzing Histogram on the Training Sets.')
% codebook_test = transpose(testCenters);
confusionMatrix = zeros(3,3);

% test 1
tic;
disp('Test Group 1 Analysis.')
buddha_match = 0;
butterfly_match = 0;
airplane_match = 0;

for i = 1:length(fileNames_testing_1)
    % query points for buddha class
    query_pt = transpose(test1(i,1).descriptor);
    % knn-search for each image.
    [tempIdx,tempDistance] = knnsearch( codebook, query_pt);
    % thresholding
    tempStd = std(tempDistance);
    tempMean = mean(tempDistance);
    j=1;
    while j <= length(tempDistance)
        if abs(tempDistance(j) - tempMean ) >= tempStd
            % set it as bad feature
           tempIdx(j) = [];
           tempDistance(j) = [];
        end
        j = j + 1;
    end
    normalize_factor = length(tempIdx); 
    ux = single([1:N]);
    counts = hist(tempIdx,ux);
    model = double(counts / normalize_factor);
    % compare similarity
    sim1 = abs(corr2(model, model_buddha));
    sim2 = abs(corr2(model, model_butterfly));
    sim3 = abs(corr2(model, model_airplane));
    match = max([sim1 sim2 sim3]);
    if sim1 == match
        buddha_match = buddha_match + 1;
    elseif sim2 == match
        butterfly_match = butterfly_match + 1;
    else 
        airplane_match = airplane_match + 1;
    end
end
disp('Match Percentage for Test Group 1')
confusionMatrix(1,1) = buddha_match / length(fileNames_testing_1);
confusionMatrix(1,2) = butterfly_match / length(fileNames_testing_1);
confusionMatrix(1,3) = airplane_match / length(fileNames_testing_1);

% test 2
tic;
disp('Test Group 2 Analysis.')
buddha_match = 0;
butterfly_match = 0;
airplane_match = 0;

for i = 1:length(fileNames_testing_2)
    % query points for buddha class
    query_pt = transpose(test2(i,1).descriptor);
    % knn-search for each image.
    [tempIdx,tempDistance] = knnsearch( codebook, query_pt);
    % thresholding
    tempStd = std(tempDistance);
    tempMean = mean(tempDistance);
    j=1;
    while j <= length(tempDistance)
        if abs(tempDistance(j) - tempMean ) >= tempStd
            % set it as bad feature
           tempIdx(j) = [];
           tempDistance(j) = [];
        end
        j = j + 1;
    end
    normalize_factor = length(tempIdx); 
    ux = single([1:N]);
    counts = hist(tempIdx,ux);
    model = double(counts / normalize_factor);
    % compare similarity
    sim1 = abs(corr2(model, model_buddha));
    sim2 = abs(corr2(model, model_butterfly));
    sim3 = abs(corr2(model, model_airplane));
    match = max([sim1 sim2 sim3]);
    if sim1 == match
        buddha_match = buddha_match + 1;
    elseif sim2 == match
        butterfly_match = butterfly_match + 1;
    else 
        airplane_match = airplane_match + 1;
    end
end
disp('Match Percentage for Test Group 2')
confusionMatrix(2,1) = buddha_match / length(fileNames_testing_2);
confusionMatrix(2,2) = butterfly_match / length(fileNames_testing_2);
confusionMatrix(2,3) = airplane_match / length(fileNames_testing_2);

% test 3
tic;
disp('Test Group 3 Analysis.')
buddha_match = 0;
butterfly_match = 0;
airplane_match = 0;

for i = 1:length(fileNames_testing_3)
    % query points for buddha class
    query_pt = transpose(test3(i,1).descriptor);
    % knn-search for each image.
    [tempIdx,tempDistance] = knnsearch( codebook, query_pt);
    % thresholding
    tempStd = std(tempDistance);
    tempMean = mean(tempDistance);
    j=1;
    while j <= length(tempDistance)
        if abs(tempDistance(j) - tempMean ) >= tempStd
            % set it as bad feature
           tempIdx(j) = [];
           tempDistance(j) = [];
        end
        j = j + 1;
    end
    normalize_factor = length(tempIdx); 
    ux = single([1:N]);
    counts = hist(tempIdx,ux);
    model = double(counts / normalize_factor);
    % compare similarity
    sim1 = abs(corr2(model, model_buddha));
    sim2 = abs(corr2(model, model_butterfly));
    sim3 = abs(corr2(model, model_airplane));
    match = max([sim1 sim2 sim3]);
    if sim1 == match
        buddha_match = buddha_match + 1;
    elseif sim2 == match
        butterfly_match = butterfly_match + 1;
    else 
        airplane_match = airplane_match + 1;
    end
end
disp('Match Percentage for Test Group 3')
confusionMatrix(3,1) = buddha_match / length(fileNames_testing_3);
confusionMatrix(3,2) = butterfly_match / length(fileNames_testing_3);
confusionMatrix(3,3) = airplane_match / length(fileNames_testing_3);
        
disp('The Confusion Matrix is:')
confusionMatrix
disp('The Overall Accuracy is:')
accuracy = mean([confusionMatrix(1,1),confusionMatrix(2,2),confusionMatrix(3,3)])


%% Finish Running Notification
% just to let me know this program is done running
beep


















