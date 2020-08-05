function [ out ] = comp_cost_exp(pop,acq_im_fun,slm_handle,target,mask)
%COMP_COST_EXP computes the cost of each member of the population w.r.t
%target.
%   Inputs:
%       pop - 3D aray containing the SLM population
%       target - output to reach.
%       acq_im_fun - function handle to acquiring an image from camera
%       slm_handle - function handle to displaying an image to SLM
%       mask - binary mask, size of size(pop(:,:,1)), that specifies areas
%       to ignore in calculation of cost.
%   Outputs:
%       out - vector of size size(pop,3) containing the Euclidean distance
%       between population and target.
target_norm=target/max(abs(target(:)));
out=zeros(1,size(pop,3));
for idx=1:size(pop,3)
    slm_handle(pop(:,:,idx));
    fwd_pop=acq_im_fun();
    norm_fwd_pop_individual=fwd_pop/max(abs(fwd_pop(:)));
    out(idx)=sum(sum((abs(norm_fwd_pop_individual(mask))-target_norm(mask)).^2));
end
end
