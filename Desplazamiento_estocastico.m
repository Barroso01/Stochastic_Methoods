%% Actividad 3
%Metodos estocasticos; Equipo 3
%El siguiente MATLAB_SCRIPT, simula el movimiento de una bacteria a lo
%largo de un tubo con cada intervalo de tiempo N, hay una probablidad de
%movimiento hacia la derecha o isquierda del 50%.
%RECUERDA: Desplazamiento es la suma con los signos y la distancia es el 
%valor absoluto. 

clear
clc

%% Define General Parameters
N=100000;              %Number of events
n=1;                %Repeated experiment n times. 
P_disp=0.5;           %Probability of displacement
P_dist=1;         %Probability of distance

Exval_disp=zeros(1,n);  %Preallocate
Exval_dist=zeros(1,n);  %Preallocate

%% Simulate displacement
for jj=1:n
    x=zeros(1,N);           %Preallocate position
    dx=zeros(1,N);          %Preallocate movment (1||0)
    Ecalc_disp=zeros(1,N);  %Preallocate dummy for expected val
    Ecalc_dist=zeros(1,N);  %Preallocate dummy for expected val
    
    absmoti=0;      %Absolute motion
    rig=0;          %Count right
    lef=0;          %Count left
    
    for j=1:N
        mov=round(rand);        %Random Movment
        absmoti=absmoti+1;      %Displacement Counter            
        
        if mov==1
            dx(j)=1;            %distance
            x(j+1)=x(j)+dx(j);  %Position of bacteria
            rig=rig+1;          %Counter right
            pr_x(rig)=rig/(j);  %Instant Probability of right
            
        elseif mov==0
            dx(j)=-1;           %distance
            x(j+1)=x(j)+dx(j);  %Position of bacteria
            lef=lef+1;          %Counter of left
            pl_x(lef)=lef/(j);  %Instant Probability of left
        end
        
        Ecalc_dist(j)= (dx(j)*P_dist).^2;
        Ecalc_disp(j)= dx(j)*P_disp;
    end
    
    Exval_dist(jj)=sqrt(sum(Ecalc_dist))*sqrt(2/pi);
    Exval_disp(jj)=sum(Ecalc_disp); 
end

%% Visualize
%Print values
fprintf("The experiment was runned %1.0f times\n",n)
fprintf("The expected value for distance is: %1.5f\n",mean(Exval_dist))
fprintf("The expected value for displacement is: %1.5f\n",mean(Exval_disp))

%Plot Acumulated probabilities
subplot(2,1,1)
plot(1:length(pr_x),pr_x,1:length(pl_x),pl_x,1:length(pr_x),ones(length(pr_x),1).*P_disp)
title("Probability of moving left or right")
xlabel("n")
ylabel("P")
legend("P_{right}","P_{left}","P_{real}")

%Plot result of experiment
subplot(2,1,2)
MS=linspace(1,N+1,N+1); %Muestral space
plot(MS,x,".-",MS,zeros(1,N+1),"k")
title("Experiment")
xlabel("n")
ylabel("distance")
legend("Experimental data")
