clear all;

% this will apply the color segmentation and the image calssification on
% images

% 0 (show only sign detection) or 1(show all roi)
debug = 1;
% the following is the exemplar:
fileName = 'stop.jpg';
% HOG bin size, from 1 to size(image).
binSize = 4;
% threshold on cos-similarity, from 0 (take everything) to 2 (take nothing)
threshold = 0.38;
% test images
%dirs = {'a', 'b', 'c', 'd', 'e', 'f', 'run1', 'run2'};
dirs = {'run2'};



templates = processTemplates(fileName, binSize);

for i = 1 : length(dirs)
    if ~exist([dirs{i} '_result'], 'dir')
        mkdir([dirs{i} '_result']);
    end
    images = dir(dirs{i});
    images(1 : 2) = [];
    for j = 1 : length(images)
        display(['Processing ', images(j).name, '...']);
        img = imread([dirs{i} '/' images(j).name]);
        % color segmentation
        nhs = normalize_segmentation(img, 'red');
        [noiseRem,cleanImg] = Postprocessing(nhs, 1500, 0.25, 1.3);
        % image cvlassification
        result = classify(img, cleanImg, templates, binSize, threshold, debug);
        imwrite(result, [dirs{i} '_result/' images(j).name]);
    end
end