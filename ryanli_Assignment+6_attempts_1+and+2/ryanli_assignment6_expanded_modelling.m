% 
%  ______  __  __  ______  __   __       __      __       ______  ______  ______ __  __  ______  __  ______  __  __  ______    
% /\  == \/\ \_\ \/\  __ \/\ "-.\ \     /\ \    /\ \     /\  ___\/\  __ \/\  == /\ \_\ \/\  == \/\ \/\  ___\/\ \_\ \/\__  _\   
% \ \  __<\ \____ \ \  __ \ \ \-.  \    \ \ \___\ \ \    \ \ \___\ \ \/\ \ \  _-\ \____ \ \  __<\ \ \ \ \__ \ \  __ \/_/\ \/   
%  \ \_\ \_\/\_____\ \_\ \_\ \_\\"\_\    \ \_____\ \_\    \ \_____\ \_____\ \_\  \/\_____\ \_\ \_\ \_\ \_____\ \_\ \_\ \ \_\   
%   \/_/ /_/\/_____/\/_/\/_/\/_/ \/_/     \/_____/\/_/     \/_____/\/_____/\/_/   \/_____/\/_/ /_/\/_/\/_____/\/_/\/_/  \/_/   
%   
% RYAN LI, COPYRIGHT, 2016
% ELEC 345, ASSIGNMENT 6, RICE UNIVERSITY
% FILE 3, Finding Models for 25 classes

% clear all;
clc;

%% Initilization
load clusters_ANN_10_SIFT.mat
load clusters_ANN_10_SURF.mat
load import_expanded.mat

codebookSIFT = transpose(centersSIFT);
codebookSURF = transpose(centersSURF);

%% Finding Models for all the Classes
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

for i = 1:length(classes)
    sprintf('Currently Modeling %s Class..', classesStrBook{i})
    models(i,1).name = classesStrBook{i};
    % compute the model from SIFT features
    models(i,1).SIFTmodel = SIFTmodel(classes{i}, codebookSIFT);
    % compute the model from SURF features
    models(i,1).SURFmodel = SURFmodel(classes{i}, codebookSURF);
end
% disp('The Total Time for Modeling is...')


save( 'models.mat', 'models')
