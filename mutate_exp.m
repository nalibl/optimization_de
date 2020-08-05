function [ out ] = mutate_exp( pop,R,range )
%MUTATE_EXP mutates offspring of GOA
%   Inputs:
%       pop - population to mutate
%       R - percentage of pixels to mutate
%       range - positive integer, range of mutation (+-)
%   Outputs
%       out - mutated population
num_pix=size(pop,1)*size(pop,2);
num_pix_mod=round(R*num_pix);
out=zeros(size(pop));
% Pre-generate random values.
random_nums=randi(2*range+1,num_pix_mod,size(pop,3))-(range+1);
for idx=1:size(pop,3)
    pix_mod=randsample(1:num_pix,num_pix_mod);
    mutant=pop(:,:,idx);
    mutant(pix_mod)=cast(mutant(pix_mod)-random_nums(:,idx),'uint8');
    out(:,:,idx)=mutant;
end
end