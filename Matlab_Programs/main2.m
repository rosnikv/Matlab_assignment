%Assignment Part 2
input=imread('Input_output_images/hubble.tif');
[I_new1]=red(input);
figure,imshow(I_new1),title('Red coloured hubble image');
imwrite(I_new1,'Red_Colured_hubble_image.png');