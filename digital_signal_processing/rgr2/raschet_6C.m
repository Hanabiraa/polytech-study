%Пример выполнения расч.зад.2,

clc;
T=2.0;%временной интервал представления сигнала
maxR=0;%начальное значение максимума коэф. сходства
n=2.4;%кол-во периодов 1-го сигнала
j=1;
SKO=0.1;%СКО шума
k=1024;%кол-во точек дискретизации сигнала
d=0.1;
j=1;
for q = -d :0.001:d        
   noise=randn(k+1,1)*SKO;    
for i=1:k
       t(i)= (i-1)*(T/k);      
       w(i) = exp(-(n*(t(i)-T/2)/T)^2); % Оконная функция       
       % Пункт 1. Два гармонических сигнала
      % x(i)= sin((2*pi*n*t(i))/T);
      % y(i)= sin((2*pi*n*(t(i)-T*q))/T);       
       % Пункт 2. Два  гармонических сигнала, модулированных по амплитуде 
       %экспоненциальной оконной функцией
       %x(i) = sin((2*pi*n*t(i))/T)*w(i);
       %y(i) = sin((2*pi*n*(t(i)-T*q))/T)*w(i);       
       % Пункт 3. Два  гармонических сигнала,один из которых зашумлен,
       %модулированных по амплитуде экспоненциальной оконной функцией 
         x(i) = sin((2*pi*n*t(i))/T)*w(i);
         y(i) = sin((2*pi*n*(t(i)-T*q))/T)*w(i)+ noise(i);       
       xy(i) = x(i)*y(i);%вычисление массива подинтегрального выражения   
end
int_xy=trapz(xy);
int_x2=trapz(power(x,2));
int_y2=trapz(power(y,2));
R(j) = int_xy/((sqrt(int_x2)*sqrt(int_y2))); 
if (R(j)>maxR)
    maxR=R(j);
    maxQ = q;
end
j=j+1;
end           
q = (-d:0.001:d);
figure
plot(q,R);
axis tight;
title('Зависимость коэф. корр. от относительного сдвига по времени');
xlabel ('Относительный сдвиг');
ylabel('Коэффициент корреляции');
maxQ
m=11;%Кол-во точек аппроксимации. Возможные значения:11, 16, 31, 61, 101, 301
for s=1:m
 b(s)=(s-1)*((2*d/0.001)/(m-1))+1;   
 R1(s)=R(b(s));
end  
x=linspace(-d,d,m);% Задание подписей на графиках по оси Х
s=1:m;
figure
plot(x,R1)
axis tight
title('До интерполяции');
xlabel('Относительный сдвиг');
ylabel('Коэффициент сходства');
xx=1:m;
xi=1:0.1:m;             
yint=interp1(xx,R1,xi,'spline');% сплайн-интерполяция коэф корреляции               
r1=yint;
apr=spaps(x,R1,0.000001);
figure
fnplt(apr)
axis tight
title('После интерполяции');
xlabel('Относительный сдвиг');
ylabel('Коэффициент сходства');

pause
close all;
clear;
    

