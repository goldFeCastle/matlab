img = imread('hand_vessle1.jpg');
% figure('Name','Raw','NumberTitle','off'); imshow(img);
img_Hsv = rgb2hsv(img);
% figure('Name','HSV Color','NumberTitle','off'); imshow(img_Hsv);

[H,S,V] = size(img_Hsv);
color_space = zeros(H,S);
for x_space = 1:H
    for y_space = 1:S
        if img_Hsv(x_space,y_space,1)<0.60 && img_Hsv(x_space,y_space,1)>0.20
            img_Hsv(x_space,y_space,2) = 1;
            img_Hsv(x_space,y_space,2) = 0;
            img_Hsv(x_space,y_space,3) = 0;
        else
            img_Hsv(x_space,y_space,1:3) = 0;
        end
    end
end
gray_img = rgb2gray(img_Hsv);
level = graythresh(gray_img);
binary = im2bw(gray_img,level);
figure('Name','Binary','NumberTitle','off'); imshow(binary);
[Crop_image,Rect] = imcrop(binary);
rect = round(Rect);

Crop_image = bwareaopen(Crop_image,500);
Crop_image = imfill(Crop_image,'holes');
% figure('Name','Croped','NumberTitle','off'); imshow(Crop_image);
Center_line = bwmorph(Crop_image,'skel',inf);
Center_line = bwmorph(Center_line,'branchpoints');
imshow(Center_line);

