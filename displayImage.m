function displayImage(inputImage)
% Displays an image in Gray Scale

k = 1;
temp = [];
for j = 1:50
    for i = 1:50
        temp(i,j) = inputImage(k);
        k = k+1;
    end
end
% The image matrix must be converted from 'double' to 'unit8'
% Because pixel values range from 0 to 255
temp = logical(temp);
imshow(temp);
end
