
I=imread('/home/freestyler/Courses/test/gray_to_rgb.png');

%%% convert to binary image
bw = im2bw(I, graythresh(I));

%%% Use regionprops to get objects area and count 
[labelBW,no_obj] = bwlabel(bw);
reginfo = regionprops(logical(bw), 'Area');
disp('The number of large stars are') ;disp(no_obj)

%%% Finding relative areas
all_area = [reginfo.Area];
rel_area = all_area(:) ./ max(all_area);

%%% code the relative area as being the hue.To prevent color confusion, we
%%% limit the upper value of the hue.
hue = rel_area * 0.85;
hsvtab = [hue, ones(size(hue,1),2)];
rgbtab = hsv2rgb(hsvtab);

%%%we have an RGB color table we can display the image and activate the colormap
image(labelBW);
colormap(rgbtab);

%%% display on a black background
map = colormap;
map(1,:) = [0,0,0];
colormap(map)
