function [ out ] = comp_cost_sim( pop,tf,target )
%COMP_COST_SIM Summary of this function goes here
%   Detailed explanation goes here
target_norm=target/sum(abs(target(:)));
out=zeros(1,size(pop,3));
for idx=1:size(pop,3)
    fwd_pop=IF2(tf.*F2(pop(:,:,idx)));
    norm_fwd_pop_individual=fwd_pop/sum(abs(fwd_pop(:)));
    out(idx)=sum(sum((abs(norm_fwd_pop_individual)-target_norm).^2));
end
end
