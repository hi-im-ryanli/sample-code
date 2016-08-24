function [ model ] = SURFmodel( className, codebook )
%histModel Find histogram for a given class according to class
% %   INPUT:
%         className - class name that for modeling, shoudl be M*1 struct data type
%         codebook - the codebook that you computed from kmeans cluster,
%                       should be 128*N, N is your cluster size
%     OUTPUT:
%         model - a 1 * N model, N is your cluster size . 

%% Historgram and Bin Analysis with
% "Find how many SIFT features from that class?s 
% training images belong to each of the SIFT descriptor clusters"
% For this reduced data set, it menas that bins number are 1000

% modelling for className
tic;
final_idx = [];
for i = 1:length(className)
    % query points for className class
    query_pt_className = transpose(className(i,1).SURFDescriptor);
    % knn-search for each image.
    [tempIdx,tempDistance] = knnsearch( codebook, query_pt_className);
    className(i,1).idx = tempIdx;
    className(i,1).distance = tempDistance;
end
% find metrics for thresholding
for i = 1:length(className)
    distanceMean(i) = mean(className(i,1).distance);
end
className_std = std(distanceMean); % standard diviation
className_mean = mean(distanceMean); % mean
% thresholding
for i = 1:length(className)
    j=1;
    while j <= length(className(i,1).distance)
        if abs( className(i,1).distance(j) - className_mean ) >= className_std
            % set it as bad feature
            className(i,1).idx(j) = [];
            className(i,1).distance(j) = [];
        end
        j = j + 1;
    end
    % making the final matrix of index
    final_idx = vertcat( final_idx, className(i,1).idx);
end
% Creating Histogram
ux = [1:length(codebook)];
counts = hist(final_idx,ux);
bins = unique(final_idx);
normalize_factor = length(bins);
model = (counts / normalize_factor);

end

