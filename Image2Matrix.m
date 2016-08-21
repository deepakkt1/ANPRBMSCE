function finalData = image2Matrix(img)
% Function to read the images used for training the Neural Network
% The training images stored in the Train directory
% Returns a matrix containing the training images
% NOTE: The returned matrix must be converted from 'unit8' to 'double'

finalData=[];
    currentImageRGB = img;
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
