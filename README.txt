sign_detection
==============

Step 1. mex -setup (This requires that you have a third-party compiler installed on your system. http://www.mathworks.com/support/compilers/R2014b/index.html)
Step 2. mex gradientMex.cpp
Step 3. run

Parameters
debug: 0 (only show detected signs) or 1 (show all regions of interest)
crop: 0 (no cropped images) or 1 (only crop detected signs) or 2 (crop all regions of interest)
fileName: the exemplar image (ex: 'stop.jpg', 'danger.jpg')
binSize: HOG bin size;
threshold: threshold on cos-similarity, from 0 (take everything) to 2 (take nothing)
dirs: folders that contain test images

The color segmentation algorithms and implemtations are from https://sites.google.com/site/mcvibot2011sep/home
The HOG toolbox is from http://vision.ucsd.edu/~pdollar/toolbox/doc/