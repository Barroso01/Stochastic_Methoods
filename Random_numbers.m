%% Random_numbers
%Es un secript que genera numeros aleatorios. 

clear
clc

%% Define General Parameters
N=1000;         %Number of random numbers
distribution=2; %Choose a distribution
nbins=50;       %Number of bins for histograms
%% Define the distribution
switch distribution
    case 1
        %Uniform
        a=0;
        b=1;
        %Ramdom number generation
        pd=makedist("Uniform",a,b); %Define the distribution
        rr=random(pd,1,N);          %Generate the random number
        %Theoretical evaluation
        x=-0.2:0.01:2;
        rrpdf=1/(b-a).*(x>a).*(x<b);
        % Visualization
        histogram(rr,nbins,"Normalization","pdf")
        hold on
        plot(x,rrpdf)
    case 2
        %Gamma
        alf=1;
        bet=1/10; 
        %Ramdom number generation
        rng("default")
        pd=makedist("Gamma",alf,bet);
        rgamma=random(pd,1,N);
        rinv=1./rgamma;
        % Theoretical evaluation
        y=0:0.001:40;
        rpdf=(1/(gamma(alf)*bet^alf)).*(1./y).^(alf+1).*exp(-1./(bet*y));
        %Visualization
        histogram(rinv,nbins,"Normalization","pdf")
        hold on 
        plot(y,rpdf)
        
    case 3
        lam=1;
        k=1.5;
        rng("default");
        s1=rng;
        rng(1,"twister");
        s2=rng;
        rng("shuffle");
        s3=rng;
        
        rng(s2);
        pd=makedist("Weibull",lam,k);
        random(pd,1,10)
end
