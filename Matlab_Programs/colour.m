
function [number,I_new,I_imadjust,RGB_label] = colour(I1)

figure, imshow(I1), title('original image');

%%%contrast gray scale image
I_imadjust=imadjust(I1);
figure, imshow(I_imadjust), title('contrast of image');

%%%conversion of gray to rgb 3d format
size(I_imadjust,3);
[m,n,r]=size(I_imadjust);
rgb=zeros(m,n,3);
rgb(:,:,1)=I_imadjust;
rgb(:,:,2)=rgb(:,:,1);
rgb(:,:,3)=rgb(:,:,1);
I_new=rgb/255;
figure,imshow(I_new),title('converted rgb');
imwrite(I_new,'gray_to_rgb.png');

%%%correcting non uniform illumination
background = imopen(I1,strel('disk',15));
I2 = I1 - background;
I3=imadjust(I2);
figure, imshow(I3), title('non uniform illumination corrected');

%Create a new binary image by thresholding the adjusted image. Remove background
%noise with bwareaopen.
level = graythresh(I3);
bw = im2bw(I3,level);
bw = bwareaopen(bw, 50);

%number of objects in the image
cc = bwconncomp(bw);
number  = cc.NumObjects;

%number ofobjects in image using regionprops
s  = regionprops(bw, 'Area');
N_objects = numel(s);

%Colouring using label2rgb method, objects are displayed with different
%colours
labeled=labelmatrix(cc);
RGB_label = label2rgb(labeled, @spring, 'c', 'shuffle');
imshow(RGB_label,'InitialMagnification','fit')
imwrite(RGB_label,'labeled.png');

for n=1:number
    so(n)=numel(cc.PixelIdxList{n});
end
so=sort(so);

%set the threshold
th0=43;
th1=92;
th2=150;
th3=1373;

%colour the stars based on their sizes manually
for i=1:number
    if ((th0<= numel(cc.PixelIdxList{1,i})) & (numel(cc.PixelIdxList{1,i}) <= th1))
        for j=1:numel(cc.PixelIdxList{1,i})
            I_new(cc.PixelIdxList{1,i}(j))=.173;
        end
    end
    if ((th1 < numel(cc.PixelIdxList{1,i})) & (numel(cc.PixelIdxList{1,i}) <= th2))
        for j=1:numel(cc.PixelIdxList{1,i})
            I_new(cc.PixelIdxList{1,i}(j))=2.56;
        end
    end
    if ((th2 < numel(cc.PixelIdxList{1,i})) & (numel(cc.PixelIdxList{1,i}) <= th3))
        for j=1:numel(cc.PixelIdxList{1,i})
            I_new(cc.PixelIdxList{1,i}(j))=0.2;
        end
    end
end
figure,imshow(I_new),title('Coloured hubble image');
end

