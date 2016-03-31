%Assignment Part 1
input=imread('Input_output_images/hubble.tif');
[number,I_new,I_imadjust,RGB_label]=colour(input);
disp('The number of large stars are') ;disp(number)
figure,imshow(I_new),title('coloured hubble image');
imwrite(I_new,'Colured_hubble_image.png');



