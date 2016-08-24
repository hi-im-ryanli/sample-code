function [ confusionRow ] = testModel( images, codebookSIFT, codebookSURF, models )
%testModel 
% Compare each image in the set of images with all the 
% 25 models
%   INPUT:
%       images - a grouping of images (data type 'cell') belonging to one classes
%   OUTPUT:
%       confusionRow - a row of the confusion matrix(25*25), 
%                       confusionRow has size 1 * 25.

%% Find images catagories
% disp('Start Analyzing Histogram on the Testing Sets.')
classesStrBook = {'basketball', 'bat', 'billiards','binoculars',... 
     'buddha', 'butterfly', 'cactus', 'cake', ...
     'camel', 'car', 'chess', 'computer', ...
    'cowboy', 'diamond', 'guitar', 'truck', ...
    'grasshopper', 'helicopter', 'leopards', 'motorbikes', ...
    'people', 'refrigerator', 'bus', 'screwdriver', ...
    'airplanes'};
confusionRow = zeros(1,25);

%% Finding SIFT Features for the images, 
for i = 1:length(images)
    imageTemp = imread(images{i});
    % convert to grayscale
    if size(imageTemp, 3) > 1
        imageTemp = rgb2gray(imageTemp);
    end
    % finding sift features
    imageTemp = single(imageTemp);
    % SIFT
    [f,d] = vl_sift(imageTemp);
    % SURF
    ipts = OpenSurf(imageTemp);
    % Storing to struct for analysis
    groupImage(i,1).name = images{i};
    groupImage(i,1).metadata = f;
    groupImage(i,1).SIFTDescriptor = single(d);
    groupImage(i,1).SURFDescriptor = reshape([ipts.descriptor],[64 length(ipts)]);
end

%% Build model for each image to compare
for i = 1:length(groupImage)
    %% SIFT Model Testing
    % query points for each class
    query_pt_SIFT = transpose(groupImage(i,1).SIFTDescriptor);
    % knn-search for each image.
    [tempIdx_SIFT,tempDistance_SIFT] = knnsearch( codebookSIFT, query_pt_SIFT);
    % thresholding
    tempStd_SIFT = std(tempDistance_SIFT);
    tempMean_SIFT = mean(tempDistance_SIFT);
    j=1;
    while j <= length(tempDistance_SIFT)
        if abs(tempDistance_SIFT(j) - tempMean_SIFT ) >= tempStd_SIFT
            % set it as bad feature
           tempIdx_SIFT(j) = [];
           tempDistance_SIFT(j) = [];
        end
        j = j + 1;
    end
    normalize_factor_SIFT = length(tempIdx_SIFT); 
    ux_SIFT = single([1:length(codebookSIFT)]);
    counts_SIFT = hist(tempIdx_SIFT,ux_SIFT);
    model_SIFT = double(counts_SIFT / normalize_factor_SIFT);
    % compare similarity
    similaritySIFT = zeros(1,25);
    for ii = 1: 25
        similaritySIFT(ii) = abs(corr2(model_SIFT, models(ii).SIFTmodel));
    end

    %% SURF Model Testing
     % query points for each class
    query_pt = transpose(groupImage(i,1).SURFDescriptor);
    % knn-search for each image.
    [tempIdx,tempDistance] = knnsearch( codebookSURF, query_pt);
    % thresholding
    tempStd = std(tempDistance);
    tempMean = mean(tempDistance);
    i=1;
    while i <= length(tempDistance)
        if abs(tempDistance(i) - tempMean ) >= tempStd
            % set it as bad feature
           tempIdx(i) = [];
           tempDistance(i) = [];
        end
        i = i + 1;
    end
    normalize_factor = length(tempIdx); 
    ux = single([1:length(codebookSURF)]);
    counts = hist(tempIdx,ux);
    model = double(counts / normalize_factor);
    % compare similarity
    similaritySURF = zeros(1,25);
    for yy = 1: 25
        similaritySURF(yy) = abs(corr2(model, models(yy).SURFmodel));
    end

    %% Make the best decision from the two descriptor modeling
    % similarity = (similaritySURF + similaritySIFT) / 2;
    % similarity = similaritySURF .* similaritySIFT;
    % similarity = similaritySIFT;
    % similarity = similaritySURF;
    
    similarity= max(similaritySURF, similaritySIFT);

    [maxVal, maxIdx] = max(similarity);
    % the maxIdx variable correspond to the index in the classesStrBook,
    confusionRow(maxIdx) = confusionRow(maxIdx) + 1;
end
% confusionRow
confusionRow = confusionRow / length(groupImage);

end

