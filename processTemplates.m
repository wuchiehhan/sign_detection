function [ feat ] = processTemplates(fileName, binSize)

sign = imread(fileName);
mask = 255 * ones(size(sign));
angle = -5: 5 : 5;
for i = 1 : length(angle)
    sign_r = imrotate(sign, angle(i));
    mask_r = imrotate(mask, angle(i));
    sign_r(mask_r == 0) = 255;
    images{i} = sign_r;
    %figure;
    %imshow(sign_r);
end

feat = [];
for i = 1 : length(images)
    %img = rgb2hsv(images{i});
    %img = img(:, :, 2);
    
    %nhs = normalize_segmentation(images{i}, 'red');
    %[noiseRem,cleanImg] = Postprocessing(nhs, 4, 0.25, 1.3);
    img = im2double(rgb2gray(images{i}));
    %img(cleanImg == 0) = 0;
    
    %val = mean(img(:));
    %img = im2bw(img, val);
    img = imresize(img, [32 32], 'nearest');
    H = hog(single(img), binSize);
    feat = [feat; H(:)'];
    %figure;
    %imshow(hogDraw(H));
end
end

