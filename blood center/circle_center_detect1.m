close all; clc
B_Mode_after_image = rgb2gray(imread('1004_after2.bmp'));
B_Mode_before_image = rgb2gray(imread('1004_before1.bmp'));

% [A,B]= imcrop(B_Mode_image);

pixel = 40/400;
fillted_after_image1 = B_Mode_after_image(31:430,121:585);
fillted_after_image2 = medfilt2(adapthisteq(fillted_after_image1));

fillted_before_image1 = B_Mode_before_image(31:430,121:585);
fillted_before_image2 = medfilt2(adapthisteq(fillted_before_image1));

[BW_after_image,masked_after_image] = segment_circle_Image(fillted_after_image2);
after_len = length(find(BW_after_image==1));
after_distance = (after_len*pixel*pixel)/2;

[BW_before_image,masked_before_image] = segmentImage(fillted_before_image2);
before_len = length(find(BW_before_image==1));
before_distance = (before_len*pixel*pixel)/2;

BW_subcribe_image = imfuse(BW_before_image,BW_after_image,'falsecolor','Scaling','joint','ColorChannels',[1 2 0]);
subcribe_len = length(find(BW_before_image-BW_after_image));
subcribe_distance = (subcribe_len*pixel*pixel)/2;

