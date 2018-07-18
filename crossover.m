function [new_member_1, new_member_2] = crossover(member_1, member_2, crossover_rate)
% Dang Manh Truong (dangmanhtruong@gmail.com)
% Here we use Partially mapped Crossover (PMX)
if rand > crossover_rate
    new_member_1 = member_1;
    new_member_2 = member_2;
else
    length_1 = numel(member_1);
    length_2 = numel(member_2);
    shuffled = randperm(length_1);
    id_1 = shuffled(1);
    id_2 = shuffled(2);
    if id_1 <= id_2
        first_idx = id_1;
        last_idx = id_2;
    else
        first_idx = id_2;
        last_idx = id_1;
    end
    new_member_1 = member_1;
    new_member_2 = member_2;
    mapper_1 = containers.Map();
    mapper_2 = containers.Map();
    for i = first_idx : last_idx
        mapper_1(int2str(member_1(i))) = int2str(member_2(i));
        mapper_2(int2str(member_2(i))) = int2str(member_1(i));
    end
    for i = 1 : length_1
        if (first_idx <= i) && (i <= last_idx)
            new_member_1(i) = member_2(i);
            new_member_2(i) = member_1(i);
        else
%             if mapper_2.isKey(num2str(member_1(i)))
%                 new_member_1(i) = str2double(mapper_2(num2str(member_1(i))));
%             end
%             if mapper_1.isKey(num2str(member_2(i)))
%                 new_member_2(i) = str2double(mapper_1(num2str(member_2(i))));
%             end
            
            while mapper_2.isKey(num2str(new_member_1(i)))
                new_member_1(i) = str2double(mapper_2(num2str(new_member_1(i))));
            end
            while mapper_1.isKey(num2str(new_member_2(i)))
                new_member_2(i) = str2double(mapper_1(num2str(new_member_2(i))));
            end
        end
    end
%     mapper = containers.Map();
%     for i = first_idx : last_idx
%         mapper(int2str(member_1(i))) = int2str(member_2(i));
%         mapper(int2str(member_2(i))) = int2str(member_1(i));
%     end
%     for i = 1 : length_1
%         if mapper.isKey(num2str(member_1(i)))
%             new_member_1(i) = str2double(mapper(num2str(member_1(i))));
%         end
%         if mapper.isKey(num2str(member_2(i)))
%             new_member_2(i) = str2double(mapper(num2str(member_2(i))));
%         end        
%     end
    
    if (numel(unique(new_member_1)) < length_1) || (numel(unique(new_member_2)) < length_1)
        [new_member_1; new_member_2]
        disp('');
    end
end

end

