function [ out ] = comp_cost_sim2( pop,target )
%COMP_COST_SIM Summary of this function goes here
%   Detailed explanation goes here
out=squeeze(sum(sum((pop-repmat(target,[1,1,size(pop,3)])).^2)));
end
