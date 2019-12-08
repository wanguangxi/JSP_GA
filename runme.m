%% Job-shop scheduling problem based on genetic algorithm with POX selection
% Author£ºEric.Wan
% Date£º2019-12-8
% Add.£ºShenYang,China
% Email:970301442@qq.com
% Version: v1.0


%Each instance consists of a line of description, a line containing the number of jobs and the number of machines, and then one line for each job,
%listing the machine number and processing time for each step of the job. The machines are numbered starting with 0.
% +++++++++++++++++++++++++++++
% machine_number0 processing_time0 |machine_number1 processing_time1 |...
% machine_number3 processing_time3 |machine_number0 processing_time0 |...
% ...
%  Fisher and Thompson 6x6 instance, alternate name (mt06)
%  6 6
%  2  1 | 0  3 | 1  6 | 3  7 | 5  3 | 4  6
%  1  8 | 2  5 | 4 10 | 5 10 | 0 10 | 3  4
%  2  5 | 3  4 | 5  8 | 0  9 | 1  1 | 4  7
%  1  5 | 0  5 | 2  5 | 3  3 | 4  8 | 5  9 
%  2  9 | 1  3 | 4  5 | 5  4 | 0  3 | 3  1
%  1  3 | 3  3 | 5  9 | 0 10 | 4  4 | 2  1
%  +++++++++++++++++++++++++++++


clear;
clc;
FT6 = [   
         2  1  0  3  1  6  3  7  5  3  4  6
         1  8  2  5  4 10  5 10  0 10  3  4
         2  5  3  4  5  8  0  9  1  1  4  7
         1  5  0  5  2  5  3  3  4  8  5  9
         2  9  1  3  4  5  5  4  0  3  3  1
         1  3  3  3  5  9  0 10  4  4  2  1 ];
FT10 =[ 
         0 29 1 78 2  9 3 36 4 49 5 11 6 62 7 56 8 44 9 21
         0 43 2 90 4 75 9 11 3 69 1 28 6 46 5 46 7 72 8 30
         1 91 0 85 3 39 2 74 8 90 5 10 7 12 6 89 9 45 4 33
         1 81 2 95 0 71 4 99 6  9 8 52 7 85 3 98 9 22 5 43
         2 14 0  6 1 22 5 61 3 26 4 69 8 21 7 49 9 72 6 53
         2 84 1  2 5 52 3 95 8 48 9 72 0 47 6 65 4  6 7 25
         1 46 0 37 3 61 2 13 6 32 5 21 9 32 8 89 7 30 4 55
         2 31 0 86 1 46 5 74 4 32 6 88 8 19 9 48 7 36 3 79
         0 76 1 69 3 76 5 51 2 85 9 11 6 40 7 89 4 26 8 74
         1 85 0 13 2 61 6  7 8 64 9 76 5 47 3 52 4 90 7 45];
FT20 = [
         0 29 1  9 2 49 3 62 4 44
         0 43 1 75 3 69 2 46 4 72
         1 91 0 39 2 90 4 12 3 45
         1 81 0 71 4  9 2 85 3 22
         2 14 1 22 0 26 3 21 4 72
         2 84 1 52 4 48 0 47 3  6
         1 46 0 61 2 32 3 32 4 30
         2 31 1 46 0 32 3 19 4 36
         0 76 3 76 2 85 1 40 4 26
         1 85 2 61 0 64 3 47 4 90
         1 78 3 36 0 11 4 56 2 21
         2 90 0 11 1 28 3 46 4 30
         0 85 2 74 1 10 3 89 4 33
         2 95 0 99 1 52 3 98 4 43
         0  6 1 61 4 69 2 49 3 53
         1  2 0 95 3 72 4 65 2 29
         0 37 2 13 1 21 3 89 4 55
         0 86 1 74 4 88 2 48 3 79
         1 69 2 51 0 11 3 89 4 74
         0 13 1  7 2 76 3 52 4 45 ];
Iterations =100;
PopSize = 500;
Pc = 0.9;
Pm = 0.05;
[Chromosome] = POX_GA(FT6,Iterations,PopSize,Pc,Pm);                        % get the best chromosome
[Jobs,Cmax,MachineList,ST,PT] = SemiActiveDecoding(FT6,Chromosome);         % decoding the best chromosome  
MachineList=MachineList+1;                                                  % Change the machine number from 0 to 1
GanntGraf(Jobs,Chromosome,MachineList,ST,PT,Cmax,"FT6") ;                   %draw GanntGtaf




