function [score] = fitness_score(chromosome, city_list, iter_num, chromosome_id)
num_of_cities = numel(city_list);
dist_of_2_cities = @(city_1, city_2) sqrt((city_1.x - city_2.x).^2 + (city_1.y - city_2.y).^2);
dist_tsp = 0;
% for i = 1 : num_of_cities
%     city = city_list{i};
%     plot(city.x, city.y, 'r*');
%     hold on
% end
for i = 1 : num_of_cities
    if i ~= num_of_cities
        dist_tsp = dist_tsp + dist_of_2_cities(city_list{chromosome(i)}, city_list{chromosome(i+1)});
%         line([city_list{chromosome(i)}.x city_list{chromosome(i+1)}.x], ...
%             [city_list{chromosome(i)}.y city_list{chromosome(i+1)}.y]);
    else
        dist_tsp = dist_tsp + dist_of_2_cities(city_list{chromosome(1)}, city_list{chromosome(num_of_cities)});
%         line([city_list{chromosome(1)}.x city_list{chromosome(num_of_cities)}.x], ...
%             [city_list{chromosome(1)}.y city_list{chromosome(num_of_cities)}.y]);
    end
    
end
score = dist_tsp;

end

