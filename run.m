% Apply the color segmentation and the image classification on images
clear all;

%% Parameters
% 0 (only show detected signs) or 1 (show all regions of interest)
debug = 1;
% 0 (no cropped images) or 1 (only crop detected signs) or 
% 2 (crop all regions of interest)
crop = 2;
% the following is the exemplar
fileName = 'stop.jpg';
% HOG bin size, from 1 to size(image).
binSize = 4;
% threshold on cos-similarity, from 0 (take everything) to 2 (take nothing)
threshold = 0.38;
% test images
%dirs = {'a', 'b', 'c', 'd', 'e', 'f', 'run1', 'run2'};
dirs = {'run2'};


%% demo
templates = processTemplates(fileName, binSize);

for i = 1 : length(dirs)
    if ~exist([dirs{i} '_result'], 'dir')
        mkdir([dirs{i} '_result']);
    end
    if crop ~= 0 && ~exist([dirs{i} '_cropped'], 'dir')
        mkdir([dirs{i} '_cropped']);
    end
    images = dir(dirs{i});
    images(1 : 2) = [];
    for j = 1 : length(images)
        display(['Processing ', images(j).name, '...']);
        img = imread([dirs{i} '/' images(j).name]);
        % color segmentation
        nhs = normalize_segmentation(img, 'red');
        [noiseRem,cleanImg] = Postprocessing(nhs, 1500, 0.25, 1.3);
        % image classification
        classify(img, cleanImg, templates, binSize, threshold,...
                 dirs{i}, images(j).name, debug, crop);
    end
end