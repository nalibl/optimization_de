function send_image_slm( in_img,screen_plot,min_delay )
%SEND_IMAGE_SLM Summary of this function goes here
%   Detailed explanation goes here
if nargin<3
    min_delay=1/30;
end
tic;
fullscreen(in_img,screen_plot);
curr_toc=toc;
if curr_toc<min_delay
   pause(min_delay-curr_toc); 
end
end

