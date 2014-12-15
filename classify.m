function [  ] = classify(img, cleanImg, templates, binSize, threshold, ...
                         dirName, fileName, debug, crop)
f = figure;
imshow(img);
[labelMap, num] = bwlabel(cleanImg, 8);
for n = 1 : num
    display(['--Working on region ', num2str(n),'/', num2str(num), '...']);
    
    [r, c] = find(labelMap == n);
    r1 = min(r);
    r2 = max(r);
    c1 = min(c);
    c2 = max(c);
    
    roi = img(r1 : r2, c1 : c2, :);
    if crop == 2
        imwrite(roi, [dirName '_cropped/' fileName(1 : end - 4) '_' num2str(n) '.jpg']);
    end
    if debug == 1
        rectangle('Position', [c1, r1, c2 - c1, r2 - r1], 'EdgeColor', 'blue', 'LineWidth', 1);
    end
    
    roi_gray = im2double(rgb2gray(roi));
    roi_gray = imresize(roi_gray, [32 32], 'nearest');
    H = hog(single(roi_gray), binSize);
        
    if(min(pdist2(templates, H(:)', 'cosine')) < threshold)
        rectangle('Position', [c1, r1, c2 - c1, r2 - r1], 'EdgeColor', 'red', 'LineWidth', 1);
        if crop == 1
            imwrite(roi, [dirName '_cropped/' fileName(1 : end - 4) '_' num2str(n) '.jpg']);
        end
    end
end
saveas(f, [dirName '_result/' fileName]);
close(f);