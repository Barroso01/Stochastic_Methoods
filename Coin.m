% Flip coin experiment H->0, T->1 P=0.5
clear;
clc
P=0.5;  %Probability
N=1000;  %Numero de experimentos
h=0;    %Contador de Heads
t=0;    %Contador de Tails
ch=1;   
ct=1;

for ii=1:N
    coin=round(rand); %Result of flip
    if coin == 0
        h=h+1;
        H(ch)=h;
        PH(ch)=H(ch)/ii;
        ch=ch+1;
    elseif coin == 1
        t=t+1;
        T(ct)=t;
        PT(ct)=T(ct)/ii;
        ct=ct+1;
    end
end

plot([1:length(PT)],PT,[1:length(PH)],PH)
legend("Tails","Heads")