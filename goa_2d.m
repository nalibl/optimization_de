function [ out ] = goa_2d( pop_size,comp_cost,mutate,fertility,n_iter,pop,R0,Rend,decay_factor)
%GOA_2D Genetic optimization algorithm for 2D arrays.
%   Based on - https://doi.org/10.1364/OE.20.004840
%   Inputs:
%       pop_size - size of population to evolve, scalar.
%       comp_cost - handle to function that computes the cost of single
%       population member. Computes for both single and multi individual.
%       mutate - handle to function that mutates an individual according to
%       mutation parameter. Usage: mutate(offspring,R).
%       fertility - fertilityity rate, corresponds to the amount of offspring
%       that are made at each generation.
%       n_iter - number of generations.
%       init_pop - initial population.
%       R0,Rend,decay_factor - these parameters determine the mutation
%       parameter R by R=(R0-Rend)*exp(-n/decay_factor)+Rend
%       pop - population seed.
%   Outputs:
%       out - computed best fit for cost function.
offspring=zeros(size(pop,1),size(pop,2),fertility);
% Initial cost of seed population
pop_cost=comp_cost(pop);
[pop_cost,pop_cost_ind]=sort(pop_cost,'descend');
pop=pop(:,:,pop_cost_ind);
benchmark=pop_cost(end);
% Utility functions for readability
choose_parents=@(pop_cost) randsample(1:pop_size, 2, true, 1./pop_cost-min(1./pop_cost));
gen_rand_template=@() randi(2,size(pop,1))-1;
gen_offspring=@(ma,pa,T) ma.*T+pa.*(1-T);
mutation_param=@(n) (R0-Rend)*exp(-n/decay_factor)+Rend;
% Waitbar
h = waitbar(0,'Best score (lower is better):1');
% Algorithm outer loop
for gen=1:n_iter
    %% Update waitbar
    waitbar(gen/n_iter,h,['Best score (lower is better):',sprintf('%g',pop_cost(end)/benchmark)]);
    %% Create offspring
    R=mutation_param(gen);
    for n_off=1:fertility
        parents=choose_parents(pop_cost);
        T_mat=gen_rand_template();
        offspring(:,:,n_off)=gen_offspring(pop(:,:,parents(1)),pop(:,:,parents(2)),T_mat);
    end
    offspring=mutate(offspring,R);
    %% Compute offspring cost and replace worse parents
    offspring_cost=comp_cost(offspring);
    %% Ana's version - replace based on offspring cost.
%     for n_off=1:fertility
%         [pop_max,pop_max_pos]=max(pop_cost);
%         if offspring_cost(n_off)<pop_max
%             pop(pop_max_pos)=offspring(n_off);
%             pop_cost(pop_max_pos)=offspring_cost(n_off);
%         end
%     end
    %% Paper version - replaces regardless of cost.
    [pop_cost,pop_cost_ind]=sort(pop_cost,'descend');
    pop=pop(:,:,pop_cost_ind);
    pop_cost(1:fertility)=offspring_cost;
    pop(:,:,1:fertility)=offspring;
end
delete(h);
[~,pop_cost_best]=min(pop_cost);
out=pop(:,:,pop_cost_best);
end





