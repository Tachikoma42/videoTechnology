function [table]=set_table(gamma)
    %build search table
    %input gamma gamma£¬build search table
    table = randperm(255+1);%random order
    table = (sort(table)-1);%range from 0 to 255
    table = table./255;
    table = table.^gamma;

end