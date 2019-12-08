function [Jobs,Cmax,MachineList,ST,PT] = SemiActiveDecoding(T,Chromosome)
%% INPUT:
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
  %Chromosome -- A chromosome to be decoded
%% OUTPUT:
    %JobList-- job sequences
    %Cmax --the max makespan
    %MachineList--The machine sequences corresponding to chromosome
    %ST --the start time for each job step in chromosome
    %PT --The operation time for each job step in chromome
%% start
[num_of_jobs,number_of_machines]=size(T);                                  
number_of_machines = number_of_machines/2;                                 % number of jobs and machines
Jobs = unique(Chromosome);
StepList = [];                                                             %steps for all genes
MachineList = [];
DecodedGenes =[];
ST = [];
PT = [];
len_of_chromosome = num_of_jobs*number_of_machines;

               
%% Caculate MachineList and PT
for index = 1:len_of_chromosome
    DecodedGenes=[DecodedGenes Chromosome(index)];
    postion = length(find(DecodedGenes==Chromosome(index))); 
    StepList = [StepList postion];
    pos1 = postion*2-1;
    pos2 =postion*2; 
    MachineList = [MachineList T(Chromosome(index),pos1)];
    PT = [PT T(Chromosome(index),pos2)];
end

%% Caculate ST
Machines = unique(MachineList);
steps = unique(StepList);


job_start_time = cell(num_of_jobs,1);
job_end_time = cell(num_of_jobs,1);
machine_start_time = cell(number_of_machines,1);
machine_end_time   = cell(number_of_machines,1);
machine_state = zeros(1,number_of_machines);                                %0--FirstWork;1--NotFirst 


for index = 1:len_of_chromosome
    job = Chromosome(index);
    machine = MachineList(index);
    pt = PT(index);
    step = StepList(index);
    pos_m = find(Machines==machine);
    pos_j = find(Jobs==job);
    if step==1                                                             %first step without considering the constrains between steps of same job
        if machine_state(pos_m)==0                                         % The machine is first used
            job_start_time{pos_j}=[0,pos_m];
            job_end_time{pos_j}=[job_start_time{pos_j}(1)+pt,pos_m];
            
        else
            job_start_time{pos_j}=[machine_end_time{pos_m}(1),pos_m];
            job_end_time{pos_j}=[job_start_time{pos_j}(1)+pt,pos_m];
        end
    else
         if machine_state(pos_m)==0                                         % The machine is first used
            job_start_time{pos_j}=[job_end_time{pos_j}(1),pos_m];
            job_end_time{pos_j}=[job_start_time{pos_j}(1)+pt,pos_m];
           
        else
            job_start_time{pos_j}=[max(machine_end_time{pos_m}(1),job_end_time{pos_j}(1)),pos_m];
            job_end_time{pos_j}=[job_start_time{pos_j}(1)+pt,pos_m];
        end       
        
    end
    machine_start_time{pos_m}= [job_start_time{pos_j}(1)];
    machine_end_time{pos_m} = [job_end_time{pos_j}(1)]; 
    machine_state(pos_m)=1;
    ST=[ST, job_start_time{pos_j}(1)]; 
end

%% Caculate Cmax
end_time=cell2mat(job_end_time);
Cmax = max(end_time(:,1));















end

