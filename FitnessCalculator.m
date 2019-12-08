%% Job-shop scheduling problem based on genetic algorithm with POX selection
% Author£ºEric.Wan
% Date£º2019-12-8
% Add.£ºShenYang,China
% Email:970301442@qq.com
% Version: v1.0
function [FitnessValue] = FitnessCalculator(T,Chromosome)
%%INPUT:
  %T--input matrix:
    %Each instance consists of a line of description, a line containing the number of jobs and the number of machines, and then one line for each job,
    %listing the machine number and processing time for each step of the job. The machines are numbered starting with 0.
    % +++++++++++++++++++++++++++++
    %  Fisher and Thompson 6x6 instance, alternate name (mt06)
    %  6 6
    %  2  1  0  3  1  6  3  7  5  3  4  6
    %  1  8  2  5  4 10  5 10  0 10  3  4
    %  2  5  3  4  5  8  0  9  1  1  4  7
    %  1  5  0  5  2  5  3  3  4  8  5  9 
    %  2  9  1  3  4  5  5  4  0  3  3  1
    %  1  3  3  3  5  9  0 10  4  4  2  1
    %  +++++++++++++++++++++++++++++
  %Chromosome -- A chromosometo be evaluated
%% OUTPUT:
  % FitnessValue--fitness value of Chromosome
 [Jobs,Cmax,MachineList,ST,PT] = SemiActiveDecoding(T,Chromosome);
  FitnessValue =Cmax;
end

