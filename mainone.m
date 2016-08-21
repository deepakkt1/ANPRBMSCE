function outpt = mainone(img)
load('test.mat');
load('FinalThetas.mat'); %load Trained Theta matrices
 colorImage = imread('NumberPlate.jpg');
%colorImage = img;
I = rgb2gray(colorImage);
keySet = {1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, ...
    21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36};
valueSet = {0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', ...
    'I', 'J', 'K', 'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};
mapObj = containers.Map(keySet, valueSet);

textBBoxes = sortrows(textBBoxes, 2);
temp = textBBoxes(:,2);
hmin = min(temp);
%[hmax x] = size(img);
hmax = max(temp);
[r c]= find(textBBoxes == hmax);
hmax = hmax + (textBBoxes(r,4));
row1Chars = [];
row2Chars = [];
mid = (hmin + hmax) .* 0.4 ;
for i = 1:length(textBBoxes)
    if (textBBoxes(i, 2) > mid)
        row2Chars = [row2Chars; textBBoxes(i, :)]
    else
                row1Chars = [row1Chars; textBBoxes(i, :)]
    end
end
row1Chars = sortrows(row1Chars, 1);
outpt='';
for(i = 1:length(row1Chars))
img = imcrop(colorImage,row1Chars(i,:)); 

X_test=Image2Matrix1(img);
pred = predict1(Theta1, Theta2, X_test(1,:));

letter = mapObj(pred);    
    fprintf('\n');
    if(letter>'A' && letter <'Z')
        outpt = strcat(outpt,letter);
    else
        outpt = strcat(outpt, num2str(letter));
    end
 end
   
 [yrow2 xrow2] = size(row2Chars)
 if(yrow2~=0)
 row2Chars = sortrows(row2Chars, 1);
 for(i = 1:length(row2Chars))
img = imcrop(colorImage,row2Chars(i,:)); 
X_test=Image2Matrix1(img);
pred = predict1(Theta1, Theta2, X_test(1,:));


letter = mapObj(pred);    
    fprintf('\n');
    if(letter>'A' && letter <'Z')
        outpt = strcat(outpt,letter);
    else
        outpt = strcat(outpt, num2str(letter));
    end
 end
 end