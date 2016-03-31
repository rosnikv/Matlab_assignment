function [I_new1]=red(I11)

%conversion gray to rgb
size(I11,3);
[m,n,r]=size(I11);
rgb=zeros(m,n,3);
rgb(:,:,1)=I11;
rgb(:,:,2)=rgb(:,:,1);
rgb(:,:,3)=rgb(:,:,1);
I_new1=rgb/255;
%%figure,imshow(I_new1),title('converted rgb');

%%%contrast gray scale image
I_imadjust=imadjust(I11);

%%%correcting non uniform illumination
background = imopen(I11,strel('disk',15));
I21 = I11 - background;
I31=imadjust(I21);

%Create a new binary image by thresholding the adjusted image. Remove background 
%noise with bwareaopen.
level1 = graythresh(I31);
bw1 = im2bw(I31,level1);
bw1 = bwareaopen(bw1, 50);

%number of objects in the image
cc2 = bwconncomp(bw1);
number2  = cc2.NumObjects;

for n=1:30
    so(n)=numel(cc2.PixelIdxList{n});
end

so=sort(so);
th1=92;
th2=150;
th3=1373;

%colour the stars those have above thresold with 'red color'

for i=1:30
    if (numel(cc2.PixelIdxList{1,i}) <= th1)
        for j=1:numel(cc2.PixelIdxList{1,i})
            I_new1(cc2.PixelIdxList{1,i}(j))=255;
        end
    end
    if ((th1 < numel(cc2.PixelIdxList{1,i})) & (numel(cc2.PixelIdxList{1,i}) <= th2))
        for j=1:numel(cc2.PixelIdxList{1,i})
            I_new1(cc2.PixelIdxList{1,i}(j))=255;
        end
    end
    if ((th2 < numel(cc2.PixelIdxList{1,i})) & (numel(cc2.PixelIdxList{1,i}) <= th3))
        for j=1:numel(cc2.PixelIdxList{1,i})
            I_new1(cc2.PixelIdxList{1,i}(j))=1;
        end
    end
end

figure,imshow(I_new1),title('Red Coloured hubble image');
%%%imwrite(I_new1,'Red_coloured_hubble.png');
            
end




