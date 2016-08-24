% 
%  ______  __  __  ______  __   __       __      __       ______  ______  ______ __  __  ______  __  ______  __  __  ______    
% /\  == \/\ \_\ \/\  __ \/\ "-.\ \     /\ \    /\ \     /\  ___\/\  __ \/\  == /\ \_\ \/\  == \/\ \/\  ___\/\ \_\ \/\__  _\   
% \ \  __<\ \____ \ \  __ \ \ \-.  \    \ \ \___\ \ \    \ \ \___\ \ \/\ \ \  _-\ \____ \ \  __<\ \ \ \ \__ \ \  __ \/_/\ \/   
%  \ \_\ \_\/\_____\ \_\ \_\ \_\\"\_\    \ \_____\ \_\    \ \_____\ \_____\ \_\  \/\_____\ \_\ \_\ \_\ \_____\ \_\ \_\ \ \_\   
%   \/_/ /_/\/_____/\/_/\/_/\/_/ \/_/     \/_____/\/_/     \/_____/\/_____/\/_/   \/_____/\/_/ /_/\/_/\/_____/\/_/\/_/  \/_/   
%   
% RYAN LI, COPYRIGHT, 2016
% ELEC 345, ASSIGNMENT 6, RICE UNIVERSITY
% FILE 3, Finding Clusters from the SIFT features

clear all;
clc;
%% Import Data From ryanli_assignment6_expanded_importing.m
load import_expanded.mat;

try
    run('/Users/RyanLi/Documents/vlfeat-0.9.20/toolbox/vl_setup.m')
    fileFolder_training = fullfile('/Users/RyanLi/Documents/midterm_data/midterm_data_reduced/TrainingDataset')
catch err
    disp('Mac File Folder Not Found.')
    disp('Switching to Windows Mode Now.')
    run('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\vlfeat-0.9.20\toolbox\vl_setup.m')
    fileFolder_training = fullfile('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\midterm_data\midterm_data_reduced\TrainingDataset')
end
%% Cluster SIFT Features
% N_SIFT = 4000; % cluster size for SIFT
% N_SURF = 2000; % cluster size for SURF

N = 8000;

try
    disp('Using Legacy Bag of Features Data.');
    load 'bagofFeatures_expanded_SIFT.mat'
    load 'bagofFeatures_expanded_SURF.mat'
catch err
    disp('Legacy Bag of Features Data Not Found.')
    %% initialization
    tic; % Start stopwatch timer for the clustering progress
    disp('Start Clustering Analysis...')
    classes = {basketball, bat, billiards,binoculars,... 
         buddha, butterfly, cactus, cake, ...
         camel, car, chess, computer, ...
        cowboy, diamond, guitar, truck, ...
        grasshopper, helicopter, leopards, motorbikes, ...
        people, refrigerator, bus, screwdriver, ...
        airplanes};

    classesStrBook = {'basketball', 'bat', 'billiards','binoculars',... 
         'buddha', 'butterfly', 'cactus', 'cake', ...
         'camel', 'car', 'chess', 'computer', ...
        'cowboy', 'diamond', 'guitar', 'truck', ...
        'grasshopper', 'helicopter', 'leopards', 'motorbikes', ...
        'people', 'refrigerator', 'bus', 'screwdriver', ...
        'airplanes'};
    bagofFeatures_expanded_SIFT = [];
    bagofFeatures_expanded_SURF = [];
    % creating the bag of features
    for y = 1: length(classes)
        sprintf('Analysis on %s...',classesStrBook{y})
        classTemp = classes{y};
        for i = 1:length(classTemp)
            bagofFeatures_expanded_SIFT = horzcat(bagofFeatures_expanded_SIFT, classTemp(i,1).SIFTDescriptor);
            bagofFeatures_expanded_SURF = horzcat(bagofFeatures_expanded_SURF, classTemp(i,1).SURFDescriptor);
        end
    end
    % save the bag computed to save computational time
    save ('bagofFeatures_expanded_SIFT.mat', 'bagofFeatures_expanded_SIFT')
    save ('bagofFeatures_expanded_SURF.mat', 'bagofFeatures_expanded_SURF')
end

% [centersSIFT,assignmentSIFT] = vl_kmeans(bagofFeatures_expanded_SIFT, N, 'Initialization', 'plusplus', 'Algorithm', 'ANN','MaxNumComparisons', ceil(N / 50));
% [centersSURF,assignmentSURF] = vl_kmeans(bagofFeatures_expanded_SURF, N, 'Initialization', 'plusplus', 'Algorithm', 'ANN','MaxNumComparisons', ceil(N / 50));

% [centersSIFT,assignmentSIFT] = vl_kmeans(bagofFeatures_expanded_SIFT, N, 'Initialization', 'plusplus', 'Algorithm', 'Elkan');
% [centersSURF,assignmentSURF] = vl_kmeans(bagofFeatures_expanded_SURF, N, 'Initialization', 'plusplus', 'Algorithm', 'Elkan');

[centersSIFT,assignmentSIFT] = vl_kmeans(bagofFeatures_expanded_SIFT, N, 'Initialization', 'plusplus', 'Algorithm', 'ANN','MaxNumComparisons', ceil(N / 10));
[centersSURF,assignmentSURF] = vl_kmeans(bagofFeatures_expanded_SURF, N, 'Initialization', 'plusplus', 'Algorithm', 'ANN','MaxNumComparisons', ceil(N / 10));

disp('Clustering Analysis Done.')
disp('The Total Time Consumed for SIFT Feature Clustering...')
toc % Terminate stopwatch timer

save('clusters_ANN_10_SIFT.mat', 'centersSIFT')
save('clusters_ANN_10_SURF.mat', 'centersSURF')
