%% CMG Script
%The script generates pseudo-random numbers using modular algebra. This
%technique is known as congruent multiplicative generator (CMG). Even more,
%the script lets you generate numbers with some probability distributions
%by implementing the 
clear
clc

%% Parameters
Dist= "Gamma";       %Choose distribution of random numbers. 
N=5000;                %Number of iterations
nbin=20;                %Number of bins

%% Random Number generation.
switch Dist 
    case "Uniform"
        X=CMG(N,1);
        %Parameters
        a=0;
        b=1;
        MS=linspace(-2,2,N);   %Muestral Space
        %Random numer evaluations.
        rrpdf=1.*(MS>0).*(MS<1);    %Theoretical evaluation of pdf
        u = X;                      %Discrete pdf 
        %Using Matlab funtions
        rng("default")
        pd=makedist("Uniform",a,b);
        rr=random(pd,1,N);
        rinv=rr;
        
        
    case "Gamma" 
        %Parameters
        alf=2;      %Gamma parameter n
        lam=4/10;   %Gamma parameter lambda
        a=0;        %Limit x0
        b=100;      %Limit xf
        MS=linspace(a,b,N);   %Muestral Space
        Xcalc=CMG(N,alf);     %Random Numbers
        
        %Multiplicar numeros aleatorios
        X=1;
        for j=1:alf
           X = X .* Xcalc(:,j); 
        end
        
        %Random numer evaluations.
        rrpdf=(lam^alf/gamma(alf)).*MS.^(alf-1).*exp(-MS.*lam);
        u= (-1/lam) .* log(X);
        
        %Using Matlab functions
        rng("default")
        pd=makedist("Gamma",alf,1/lam);
        rgamma=random(pd,1,N);
        rinv=rgamma;
end

%% Plot
subplot(1,2,1)
histogram(u,nbin,"Normalization","pdf")
hold on
plot(MS,rrpdf)
title("Pseudo random number generation with CMG")
xlabel("Numbers generated")
ylabel("Frequency")
legend("Results Generated","Theoretical")
hold off
%
subplot(1,2,2)
histogram(rinv,nbin,"Normalization","pdf")
hold on
plot(MS,rrpdf)
title("Pseudo random number generation with matlab")
xlabel("Numbers generated")
ylabel("Frequency")
legend("Results Generated","Theoretical")
hold off

%% Print results
fprintf("The difference between means is %1.5f \n",abs(mean(u)-mean(rinv)))
fprintf("The difference between stdv is %1.5f \n",abs(std(rinv)-std(u)))

%% Function
function X= CMG(N,n)
%CMG Methood lets you create n sets of uniform distribution pseudo random
%numbers. The total number of random numbers generated in each set is given
%by N. 
a=7^5;                  %Multiplicador (condiciones v4)
m=2^31-1;               %Modulo (condiciones v4)
z=470211;               %Parametro
X=zeros(N-1,n);         %Preallocate

for i=1:n  
    x=zeros(1,N);           %Preallocate
    x(1)=mod(z/a,m);        %Semilla(condiciones v4)
    for jj=2:N
        x(1,jj)=mod(a*x(1,jj-1),m);
    end
    X(:,i) = x(2:N)./m;          %Random numbers
    
    z=(z*rand)-458882;
end

end