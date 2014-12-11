clear all;

debug = 1;
fileName = 'stop.jpg';
binSize = 4;
threshold = 0.38;
dirs = {'a', 'b', 'c', 'd', 'e', 'f', 'run1', 'run2'};

templates = processTemplates(fileName, binSize);

for i = 1 : length(dirs)
    if ~exist([dirs{i} '_result'], 'dir')
        mkdir([dirs{i} '_result']);
    end
    images = dir(dirs{i});
    images(1 : 2) = [];
    for j = 1 : length(images)
        display(['Processing ', images(j).name, '...']);
        img = imread([dirs{i} '\' images(j).name]);
        nhs = normalize_segmentation(img, 'red');
        [noiseRem,cleanImg] = Postprocessing(nhs, 1500, 0.25, 1.3);
        result = classify(img, cleanImg, templates, binSize, threshold, debug);
        imwrite(result, [dirs{i} '_result\' images(j).name]);
    end
end