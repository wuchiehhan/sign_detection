function result = classify(img, cleanImg, templates, binSize, threshold, debug)
[labelMap, num] = bwlabel(cleanImg, 8);
for n = 1 : num
    display(['--Working on region ', num2str(n),'/', num2str(num), '...']);
    [r, c] = find(labelMap == n);
    r1 = min(r);
    r2 = max(r);
    c1 = min(c);
    c2 = max(c);
    
    roi = img(r1 : r2, c1 : c2, :);
    %imwrite(roi, ['images/' filename(1 : end - 4) '_' num2str(n) '.jpg']);
    if debug == 1
        img(r1 : r2, c1, 1) = 0;
        img(r1 : r2, c1, 2) = 0;
        img(r1 : r2, c1, 3) = 255;

        img(r1 : r2, c2, 1) = 0;
        img(r1 : r2, c2, 2) = 0;
        img(r1 : r2, c2, 3) = 255;

        img(r1, c1 : c2, 1) = 0;
        img(r1, c1 : c2, 2) = 0;
        img(r1, c1 : c2, 3) = 255;

        img(r2, c1 : c2, 1) = 0;
        img(r2, c1 : c2, 2) = 0;
        img(r2, c1 : c2, 3) = 255;
    end
    
    roi = im2double(rgb2gray(roi));
    roi = imresize(roi, [32 32], 'nearest');
    H = hog(single(roi), binSize);
        
    if(min(pdist2(templates, H(:)', 'cosine')) < threshold)
        img(r1 : r2, c1, 1) = 255;
        img(r1 : r2, c1, 2) = 0;
        img(r1 : r2, c1, 3) = 0;

        img(r1 : r2, c2, 1) = 255;
        img(r1 : r2, c2, 2) = 0;
        img(r1 : r2, c2, 3) = 0;
            
        img(r1, c1 : c2, 1) = 255;
        img(r1, c1 : c2, 2) = 0;
        img(r1, c1 : c2, 3) = 0;
            
        img(r2, c1 : c2, 1) = 255;
        img(r2, c1 : c2, 2) = 0;
        img(r2, c1 : c2, 3) = 0;
    end
end
result = img;