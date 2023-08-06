%% Gradiente descendiente
% DE entrada el programa necesita la funcion, una posicion inicial y el
% epsilon. 
clear;
load('Ejercicio.mat')

%% General Parameters
dx=3/3000;
xs=limitesX(1):dx:limitesX(2);
ys=limitesY(1):dx:limitesY(2);
[X,Y]=meshgrid(xs,ys);

%% Gradient
[gradx,grady] = gradient(FF);
absgradF= sqrt(gradx.^2 + grady.^2); %Norma del gradiente

%% Definir los valores iniciales
x(1)=X(1); 
y(1)=Y(1);
stept=1; %t_k
tolerancia=1E-6; %epsilon

%% Gradient Decent
jj=1; %Contador

while absgradF()>tolerancia
    x(jj+1)=X(jj) - stept * gradx(X(jj), Y(jj));
    y(jj+1)=y(jj) - stept * grady(X(jj), Y(jj));
    jj=jj+1;
end





surf(X,Y,FF)
shading interp
hold on
scatter3(x,y,FF(x,y),100,'.','black')