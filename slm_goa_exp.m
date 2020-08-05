%% Parameter definition
seed=load('seed.mat');
res=size(seed);
fertility=round(pop_size/2);
n_iter=500;
pop_size=100;
pop=zeros([res,pop_size]);
R0=0.2;
Rend=0.01;
decay_factor=30;
range=15;
%% Experiment environment initialization
[acq_im_fun,set_cam_exp_ms,set_cam_gain,cam] = init_cam();
set_cam_exp_ms(0.1);
set_cam_gain(0);
tic;
max_freq=1;screen=2;
slm_handle=@(input) send_image_slm(input,screen,max_freq);
%% Generate target of forward model
% Option 1 - generate target by simulation.
% Option 2 - generate target from pattern created by seed and modify.
target=acq_im_fun();
target(target<mean(target(:)))=0;
%% Create main function handle to pass on
comp_cost_handle=@(pop) comp_cost_exp(pop,acq_im_fun,slm_handle,target,mask);
mutate_handle=@(pop,R) mutate_exp( pop,R,range);
%% Generate population from seed
for idx=1:pop_size
    pop(:,:,idx)=mutate_handle(seed,R0);
end
%$ Start optimization
[ out ] = goa_2d( pop_size,comp_cost_handle,mutate_handle,fertility,n_iter,pop,R0,Rend,decay_factor);
%$ Save out to file: goa_2d_dd_mm_HH.mat
save(['goa_2d_',datestr(now,'dd_mm_HH'),'.mat'],'out');
disp('Done!');