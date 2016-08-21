function finalData = imageRead()
% Function to read the images used for training the Neural Network
% The training images stored in the Train directory
% Returns a matrix containing the training images
% NOTE: The returned matrix must be converted from 'unit8' to 'double'

% Link to directory where images are stored
imageFiles = dir('test/*.jpg');
fileID = fopen('nexp.txt','w');

% Number of training images
nFiles = length(imageFiles);
finalData = [];
for ii = 1:nFiles
    currentFilename = strcat('test/',imageFiles(ii).name);
    disp(currentFilename);
   na=length(currentFilename);
   n=na-4;
   % disp(currentFilename(n));
    fprintf(fileID,currentFilename(n));

    currentImageRGB = imread(currentFilename);
    currentImageRGB = im2double(currentImageRGB);
    % imshow(currentImageRGB);
    [p, q, r] = size(currentImageRGB);
    if(r==3)
        dataImage = rgb2gray(currentImageRGB);
    end
    dataImage = imresize(dataImage, [50 50]);
   % displayImage(dataImage);
   % disp(size(dataImage));
   % imshow(dataImage);
	% A vector corresponding to each image
    temp = dataImage(:)';
     finalData = [finalData ; temp];
end
fclose(fileID);
end
