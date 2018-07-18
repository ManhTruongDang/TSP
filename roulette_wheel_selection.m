function [idx ] = roulette_wheel_selection(num_of_chromosomes, prob_vector)
rand_val = rand;
cum_prob = 0;
for i = 1 : num_of_chromosomes
    cum_prob = cum_prob + prob_vector(i);
    if rand_val < cum_prob
        idx = i;
        break;
    end
end

end

