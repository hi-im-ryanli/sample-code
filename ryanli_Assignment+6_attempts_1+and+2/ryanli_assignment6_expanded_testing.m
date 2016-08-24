% 
%  ______  __  __  ______  __   __       __      __       ______  ______  ______ __  __  ______  __  ______  __  __  ______    
% /\  == \/\ \_\ \/\  __ \/\ "-.\ \     /\ \    /\ \     /\  ___\/\  __ \/\  == /\ \_\ \/\  == \/\ \/\  ___\/\ \_\ \/\__  _\   
% \ \  __<\ \____ \ \  __ \ \ \-.  \    \ \ \___\ \ \    \ \ \___\ \ \/\ \ \  _-\ \____ \ \  __<\ \ \ \ \__ \ \  __ \/_/\ \/   
%  \ \_\ \_\/\_____\ \_\ \_\ \_\\"\_\    \ \_____\ \_\    \ \_____\ \_____\ \_\  \/\_____\ \_\ \_\ \_\ \_____\ \_\ \_\ \ \_\   
%   \/_/ /_/\/_____/\/_/\/_/\/_/ \/_/     \/_____/\/_/     \/_____/\/_____/\/_/   \/_____/\/_/ /_/\/_/\/_____/\/_/\/_/  \/_/   
%   
% RYAN LI, COPYRIGHT, 2016
% ELEC 345, ASSIGNMENT 6, RICE UNIVERSITY
% FILE 4, Testing Bench for Expanded Data Sets

%% Initialization
clear all;
clc;
warning('off','all')
warning

% models that I computed with ryanli_assignment6_modelling.m
load models.mat
% 8000 clusters that I computed with ryanli_assignment6_cluster.m
load clusters_ANN_10_SIFT.mat
load clusters_ANN_10_SURF.mat
% generating codebook
codebookSIFT = transpose(centersSIFT);
codebookSURF = transpose(centersSURF);
% environment check
try
    disp('Running on Macintosh.');
    run('/Users/RyanLi/Documents/vlfeat-0.9.20/toolbox/vl_setup.m')
    fileFolder_testing = fullfile('/Users/RyanLi/Google Drive/Junior II/ELEC 345/Assignment 6/midterm_data/midterm_data_expanded/TestDataset')
catch err
    disp('Mac File Folder Not Found.')
    disp('Switching to Windows Mode Now.')
    run('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\vlfeat-0.9.20\toolbox\vl_setup.m')
    fileFolder_testing = fullfile('C:\Users\Ryan\Google Drive\Junior II\ELEC 345\Assignment 6\midterm_data\midterm_data_expanded\TestDataset')
end
% initilizing confusion matrix
confusionMatrix = zeros(25,25);
% a reference of the entire classes
classesStrBook = {'basketball', 'bat', 'billiards','binoculars',... 
     'buddha', 'butterfly', 'cactus', 'cake', ...
     'camel', 'car', 'chess', 'computer', ...
    'cowboy', 'diamond', 'guitar', 'truck', ...
    'grasshopper', 'helicopter', 'leopards', 'motorbikes', ...
    'people', 'refrigerator', 'bus', 'screwdriver', ...
    'airplanes'};

%% Computing all the test images with the models
for ii = 1: length(classesStrBook)
    sprintf('Currently Testing Model from %s Class..', classesStrBook{ii})
    dirOutput_testing_temp = dir(fullfile(fileFolder_testing, classesStrBook{ii}, '*.jpg'));
    fileNames_temp= {dirOutput_testing_temp.name}';
    confusionMatrix(ii,:) = testModel( fileNames_temp, codebookSIFT, codebookSURF, models );
end

%% Compute the Accuracry
accuracry = trace(confusionMatrix)/25












