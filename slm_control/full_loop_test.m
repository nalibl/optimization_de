tic
x=1:1920;
for i=1:10000
% a=uint8(255*(randi(2,1080,1920)-1));
x_y=256*(sind(x+i*100)+1)/2;
a=uint8(repmat(x_y,[1080,1]));
send_image_slm(a,2,0.1);
end