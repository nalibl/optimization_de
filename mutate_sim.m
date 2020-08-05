function [ out ] = mutate_sim( pop,R )
%MUTATE_SIM Summary of this function goes here
%   Detailed explanation goes here
num_pix=size(pop,1)*size(pop,2);
num_pix_mod=round(R*num_pix);
out=pop;
for idx=1:size(pop,3)
    pix_mod=randsample(1:num_pix,num_pix_mod);
    mutant=pop(:,:,idx);
    mutant(pix_mod)=exp(1i*2*pi*rand(1,num_pix_mod));
    out(:,:,idx)=mutant;
end
end