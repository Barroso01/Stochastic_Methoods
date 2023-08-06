%% Actividad 2
%Metodos estocasticos; Equipo 3
%El siguiente MATLAB_SCRIPT, simula el crecimiento poblacional de una
%bacteria que mediante n estimulos (el ultimo es el exitoso, 
%su poblacion crece 2^n. El programa calcula los valores esperados.
clear
clc
%% Define General Parameters
N=100;              %Number of events
MS=linspace(1,N,N); %Muestral space
bact=zeros(N,1);    %Preallocate population
pop=zeros(N,1);     %Preallocate Acumulated

%% Random Sampling 
for j=1:N
    count=0;            %Initialize count
    stim=0;             %Initialize Stimulant
    cstim=0;            %Initialize Stimulant Events
    cnstim=0;           %Initialize Non Reproduced event
    
    while stim==0
        stim=round(rand);   %Determine if a stim was generated(1) or no (0)
        count=count+1;      %Stimulate switch counter 
        if stim==1
            cstim=cstim+1;      %Counter stimulant
            P_stim(j)=1/count;  %Probability of stimulation
            bact(j)=2^count;    %Bacteria created
            pop(j)=sum(bact);   %Population
        end
    end
    P_nstim(j)=1-P_stim(j);   %Probability of non stimulation
    Eval(j)=bact(j)*P_stim(j)';
end
Ex_Val=sum(Eval)/N;

%% Print Results
fprintf("Your expected value for any set of clicks in a single event (BACTERIA) is:%1.4f\n",Ex_Val)

%% Visualization
subplot(1,2,1)
plot(MS,bact,MS,pop)
title("Bacteria Population")
xlabel("Event N")
ylabel("Bacteria")
legend("Reproduced Bacteria","Acumulated Population")
hold on
subplot(1,2,2)
title("Probabilities of events")
plot([1:length(P_stim)],P_stim,[1:length(P_nstim)],P_nstim)
legend("P_{stim}","P_{nstim}")
hold off