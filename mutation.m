function [new_member_1, new_member_2] = mutation(member_1, member_2, mutation_rate)
% Dang Manh Truong (dangmanhtruong@gmail.com)
% For TSP, we use Exchange Mutation Operator
length_1 = numel(member_1);
length_2 = numel(member_2);
new_member_1 = member_1;
new_member_2 = member_2;
if rand <= mutation_rate
    % Mutate first member
    shuffled = randperm(length_1);
    id_1 = shuffled(1);
    id_2 = shuffled(2);
    temp = new_member_1(id_1);
    new_member_1(id_1) = new_member_1(id_2);
    new_member_1(id_2) = temp;
end
if rand <= mutation_rate
    % Mutate second member
    shuffled = randperm(length_2);
    id_1 = shuffled(1);
    id_2 = shuffled(2);
    temp = new_member_2(id_1);
    new_member_2(id_1) = new_member_2(id_2);
    new_member_2(id_2) = temp;
end
if (numel(unique(new_member_1)) < length_1) || (numel(unique(new_member_2)) < length_1)
    [new_member_1; new_member_2]
    disp('');
end
% mutation_decisions = randsample([false true], length_1, true,[(1-mutation_rate) mutation_rate]);
% for i = 1 : length_1    
%     do_a_mutation = mutation_decisions(i);
%     if do_a_mutation        
%         new_member_1(i) = member_1(1) + ((-max_pertubation) + rand*max_pertubation*2);
%     end
% end
% 
% mutation_decisions = randsample([false true], length_2, true,[(1-mutation_rate) mutation_rate]);
% for i = 1 : length_2    
%     do_a_mutation = mutation_decisions(i);
%     if do_a_mutation        
%         new_member_1(i) = member_2(1) + ((-max_pertubation) + rand*max_pertubation*2);        
%     end
% end

end

