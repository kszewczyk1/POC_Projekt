Image_org = imread('27S.bmp');
Image = histeq(Image_org);
Image = imresize(Image,0.8);

h = fspecial('average', 5);
Image = imfilter(Image, h);

Image_gray = rgb2gray(Image);

Image_gray = medfilt2(Image_gray);

I_thresh = graythresh(Image_gray);
Image_thresh = imbinarize(Image_gray, I_thresh);

se = strel('rectangle', [7 7]);
Image_open = imclose(Image_thresh,se);
Image_open = imopen(Image_open,se);

Image_open = imcomplement(Image_open);

Regions = regionprops(Image_open,'Eccentricity','BoundingBox');
Eccentricities = [Regions.Eccentricity];
Ecc_find = find(Eccentricities);
Ecc_regions = Regions(Ecc_find);

figure, imshow(Image);

for i = 1 : length(Ecc_find)
    x = Ecc_regions(i).BoundingBox;
    
    h = rectangle('Position', x);
    set(h,'EdgeColor',[0 1 0]);
end

figure;
for i = 1 : length(Ecc_find)
    x = Ecc_regions(i).BoundingBox;
    crop = imcrop(Image, [x]);
    subplot(5,5,i);
    imshow(crop);
end