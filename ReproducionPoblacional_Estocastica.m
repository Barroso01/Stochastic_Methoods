%% Actividad 1
%Metodos estocasticos; Equipo 3
%El siguiente MATLAB_SCRIPT, simula el crecimiento poblacional de una
%bacteria que cada dia tiene una probabilidad de sumar una bacteria a su
%poblacion de 50%. El numero de iteraciones que se les da a las bacterias
%para reproducirse es "N" y el experimento se realiza "n" veces. 
clear ;
clc
%% Define General Parameters
N=100;             %Number of events
n=1;               %Number of experiments
MS=linspace(1,N,N); %Muestral space
Exval=zeros(n,1);   %Calculation for expected value
P=1/2 ;              %Probability for plot. 
    
%% Random Sampling 
for jj=1:n
    E=zeros(N,1);       %Preallocate population
    Acum=zeros(N,1);    %Preallocate Acumulated
    re=0;               %Reproduced Event
    nre=0;              %Non Reproduced event
    cre=1;              %Counter pointer
    cnre=1;             %Counter pointer
    
    for j=1:N
        gen=round(rand);%Determine if a bacteria was generated(1) or no (0)
        if gen==1
            re=re+1;            %Count reproduction
            E(j)=1;             %Event j = 1 birth. 
            P_re(cre)=re/j;     %Probability of reproduction happening.
            Acum(j)=sum(E);     %Calculate the total number of bacteria in population.
            cre=cre+1;
            
        elseif gen==0
            nre=nre+1;              %Count non reproduction
            E(j)=0;                 %Event's value for j iteration.
            P_nre(cnre)=nre/j;      %Probability of non reproduction on j iteration.
            Acum(j)=sum(E);         %Calculate the total number of bacteria in population.
            cnre=cnre+1;
            
        end
    end
    Exval(jj)=1*sum(E)/N;         %Expected value of a single population sim. 
end

E_Valn=sum(Exval)/n;        %Repeating the population grouwth n times

%% Print Results
fprintf("Your expected value over %1.0f iterations of the experiment of %1.0f events is: %1.6f \n",n,N,E_Valn)

%% Visualization
subplot(2,2,1)
plot(MS,Acum)
title("Bacteria Population over days")
xlabel("Event N (Days)")
ylabel("Bacteria")
legend("Acumulated Population")
hold on

subplot(2,2,2)
plot(MS,E)
xlabel("Event N (Days)")
ylabel("Bacteria Reproduced")
legend("Reproduced Bacteria [50%]")
hold on

subplot(2,2,3)
title("Probabilities of events")
plot([1:length(P_re)],P_re,[1:length(P_nre)],P_nre)
hold on
plot([1:length(P_re)],ones(length(P_re),1).*P)
legend("P_{rep}","P_{nrep}")
hold on

subplot(2,2,4)
title("Expected Value")
scatter(linspace(1,n,n),Exval,"o")
hold off