%% Job-shop scheduling problem based on genetic algorithm with POX selection
% Author£ºEric.Wan
% Date£º2019-12-8
% Add.£ºShenYang,China
% Email:970301442@qq.com
% Version: v1.0

%% GanntGraf
function GanntGraf(job_array,XX,YY,ST,PT,fit,TITLE) 
%job_array--jobs list£¬
%XX---one chromosome£¬
%YY-----Decoded machine sequence£¬
%ST-----Start time of corresponding steps£¬
%PT-----Operation time of corresponding steps,
%fit----fitness
num_j=numel(job_array);
num_m=numel(unique(YY));
num_op=numel(XX);                                                           %the number of all steps
fit_n=floor(log10(fit))+1;                                                  %Determine the upper bound on the X-axis of the gantt chart according to the fit value
fit_str=num2str(fit);
if  numel(fit_str)>1 
if str2double(fit_str(2))>=5
maxX=(10^(fit_n-1))*(str2double(fit_str(1))+1); 
elseif str2double(fit_str(2))<5 
   maxX=(10^(fit_n-1))*(str2double(fit_str(1)))+(10^(fit_n-2)*5);  
end
elseif numel(fit_str)==1 
    maxX=(10^(fit_n-1))*(str2double(fit_str(1))+1); 
end

figure(2);
axis([0,maxX,0,num_m+0.5]);                                                 % x and y
set(gca,'xtick',0:maxX/10:maxX) ;                                           %The increase step in the X-axis
set(gca,'ytick',0:1:num_m+0.5) ;                                            %The increase step in the X-axis
xlabel('Processing Time','FontWeight','Bold','FontSize',15),ylabel('Machine Number','FontWeight','Bold','FontSize',15);%xÖá yÖáµÄÃû³Æ

color=[ 
    0.9503    0.1669    0.4071
    0.0077    0.9092    0.5791
    0.4863    0.7758    0.4187
    0.8415    0.0616    0.8317
    0.6903    0.7108    0.3491
    0.7798    0.5519    0.8137
    0.5925    0.4321    0.9752 
    0.6505    0.1452    0.2776
    0.7458    0.2480    0.8866
    0.5382    0.2022    0.5197
    0.4124    0.0269    0.5633
    0.9119    0.3039    0.0125
    0.9423    0.0790    0.2112
    0.4246    0.3765    0.3313
    0.9489    0.6026    0.1701
    0.9225    0.8885    0.0108
    0.5905    0.5817    0.5152
    0.9253    0.0745    0.3962
    0.9503    0.1669    0.4071
    0.0077    0.9092    0.5791
    0.4863    0.7758    0.4187
    0.8415    0.0616    0.8317
    0.6903    0.7108    0.3491
    0.7798    0.5519    0.8137
    0.5925    0.4321    0.9752 
    0.6505    0.1452    0.2776];

n_color=zeros(num_op,3);
for i=1:num_j
    counter_j(i)=1;                                                         %Record the steps of each job
end
for i=1:length(XX)
    n_color(i,:)=color(XX(i),:);
end

rec=[0,0,0,0];                                                             %temp data space for every rectangle  
for i = 1:num_op 
  job=XX(i);
  pos_j=find(job_array==job);
  rec(1) = ST(i);                                                           
  rec(2) = YY(i)-0.3;                                                        
  rec(3) = PT(i);                                                              
  rec(4) = 0.4; 
    txt=sprintf('%d-%d',job,counter_j(pos_j(1)));
   rectangle('Position',rec,'LineWidth',0.5,'LineStyle','-','faceColor',n_color(i,:));%draw every rectangle
  text(ST(i)+0.4,(YY(i))-0.1,txt,'FontWeight','Bold','FontSize',15);                  %label the id of every task  
  counter_j(pos_j(1))=counter_j(pos_j(1))+1;
end  
title(TITLE,'FontWeight','Bold','FontSize',15);
hold on;
grid on;
plot([fit,fit],[0,num_m+0.5],'r','linewidth',2);
text(fit,0.5,['Cmax=',num2str(fit)],'FontWeight','Bold','FontSize',15);
end
