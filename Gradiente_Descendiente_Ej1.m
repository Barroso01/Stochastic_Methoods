%% Gradiente descendiente
% DE entrada el programa necesita la funcion, una posicion inicial y el
% epsilon. 
clear;

%% Define General parameters
xs=-2:0.01:2;
ys=-2:0.01:2;
[X,Y]=meshgrid(xs,ys); 

%Funcion
fun=@(x,y)(1-x).^2 +100*(y-x.^2).^2;

%% Make the gradient
gradx= @(x,y) 2 *(x-1) + 400 * x.*(x.^2 - y); %Derivada con respecto a x.
grady= @(x,y) 200 * (y-x.^2);   %Derivada con respecto a y
absgradF= @(x,y) sqrt(gradx(x,y).^2 + grady(x,y).^2); %Norma del gradiente

%% Definir los valores iniciales
x(1)=2; 
y(1)=-2;
stept=0.0001; %t_k
tolerancia=1E-6; %epsilon

%% Gradient Decent
jj=1; %Contador

while absgradF(x(jj),y(jj))>tolerancia
    x(jj+1)=x(jj) - stept * gradx(x(jj), y(jj));
    y(jj+1)=y(jj) - stept * grady(x(jj), y(jj));
    jj=jj+1;
end

%% Plot
%Evaluar la funcion
FF=fun(X,Y);
%Visualizacion
surf(X,Y,FF)
shading interp
hold on
scatter3(x,y,fun(x,y),100,'.','black')