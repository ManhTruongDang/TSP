%% Travelling salesman problem
clear 
clc
rng('default');

%% Configurable parameters
num_of_chromosomes = 20;
crossover_rate = 0.75;
mutation_rate = 0.2;
num_of_elites = 1;

num_of_cities = 30;
max_coordinate = 5;

%% Initialize the cities
city_list = cell(1, num_of_cities);
for i = 1 : num_of_cities
    city.x = -max_coordinate + rand*(2*max_coordinate);
    city.y = -max_coordinate + rand*(2*max_coordinate);
    city_list{i} = city;
    plot(city.x, city.y, 'r*');
    hold on
    % text(city.x, city.y, ['City ' int2str(i)]);
end

%% Initialize the population
population = cell(1, num_of_chromosomes);
for i = 1 : num_of_chromosomes    
    population{i} = randperm(num_of_cities);
end

%% It's show time!
fitness_scores = zeros(1, num_of_chromosomes);
tour_lengths = zeros(1, num_of_chromosomes);
iter_num = 1;
while 1
    % Test each chromosome to see how good it is at solving the problem 
    % at hand and assign a fitness score accordingly. The fitness score 
    % is a measure of how good that chromosome is at solving the problem 
    new_population = cell(1, num_of_chromosomes);
    current_best = [];
    best_fitness_score = -1;
    longest_tour_length = -1;
    for i = 1 : num_of_chromosomes 
        chromosome_id = i;
        tour_length_of_chromosome = tour_length(population{i}, ...
            city_list, iter_num, chromosome_id);
        tour_lengths(i) = tour_length_of_chromosome;
        fitness_scores(i) = tour_length_of_chromosome;        
        if longest_tour_length < tour_length_of_chromosome
            longest_tour_length = tour_length_of_chromosome;
        end
%         if best_fitness_score < fitness_score_of_chromosome
%             current_best = population{i};
%             current_best_idx = i;
%             best_fitness_score = fitness_score_of_chromosome;
%         end        
    end
    % With TSP, we should subtract the tour distance for each solution to
    % the worst one. 
    for i = 1 : num_of_chromosomes
        fitness_scores(i) = longest_tour_length - fitness_scores(i);
        if best_fitness_score < fitness_scores(i)
            current_best = population{i};
            current_best_idx = i;
            best_fitness_score = fitness_scores(i);
        end 
    end
    % pause(0.5);
    fprintf('Iteration %d, number %d, tour length %f \n', iter_num, current_best_idx, tour_lengths(current_best_idx));    
    fprintf('%d ', population{current_best_idx});
    fprintf('\n');
    new_idx = 1;
    % Elitism
%     new_population{new_idx} = current_best;
%     new_idx = new_idx + 1;
    [~, fitness_scores_sorted_idx] =sort(fitness_scores, 'descend');
    for m = 1 : num_of_elites
        new_population{new_idx} = population{fitness_scores_sorted_idx(m)};
        new_idx = new_idx + 1;
    end
    
    while 1        
        % Select two members from the current population        
        if sum(fitness_scores)==0
            prob_vector = ones(1, num_of_chromosomes) * (1 / num_of_chromosomes);
        else
            prob_vector = fitness_scores ./ sum(fitness_scores);
        end  
        [member_1_index, member_2_index ] = select_2_members_using_roulette_wheel(num_of_chromosomes, prob_vector);
        member_1 = population{member_1_index};
        member_2 = population{member_2_index};

        % Depending on the crossover rate crossover the bits from each chosen 
        % chromosome at a randomly chosen point
        [new_member_1, new_member_2] = crossover(member_1, member_2, crossover_rate);

        % Step through the chosen chromosomes bits and flip depending on the
        % mutation rate.
        [new_member_1, new_member_2] = mutation(new_member_1, new_member_2, mutation_rate);
        
        new_population{new_idx} = new_member_1;
        new_idx = new_idx + 1;
        new_population{new_idx} = new_member_2;
        new_idx = new_idx + 1;        
        if new_idx > num_of_chromosomes
            iter_num = iter_num + 1;      
            population = new_population;
            break;
        end
    end
    % close    
end