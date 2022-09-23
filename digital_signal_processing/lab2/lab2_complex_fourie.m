clear, clc, close all;

dots_num = 1024;    % кол-во точек
N = 0:1:dots_num;   % интервал точек
T = 2 * pi;   % размер периода функции
kp = 1;   % количество периодов гармонической функции

fourie_parts_arr = [8, 16, 32, 64, 128, 256]; % разные количества членов комплексного ряда Фурье
STD_percent_arr = []; % массив для создания графика SKO_percent=f(fourie_parts)

for fourie_parts = fourie_parts_arr % fourie_parts - текущие количество членов ряда Фурье

    idx = zeros(1, length(N));
    f = zeros(1, length(N));    % исходная функция


    % ---- Вычисление комплексного ряда фурье ----
    for i=1:dots_num + 1
        idx(i) = T * (i-1) / dots_num;
        f(i) = abs(sin(kp * idx(i)));
    end

    C0 = sum(f) * (2 / dots_num);
    C = zeros(1, fourie_parts);

    for i=1:dots_num + 1
        for j=1:fourie_parts
            C(j) = C(j) + f(i) * exp(1i * 2 * pi * j * (i-1) / dots_num); 
        end
    end

    % ---- нормализация комплексного ряда Фурье ----
    for i=1:fourie_parts
        C(i) = C(i) * (2 / dots_num);
    end

    % ---- Вычисление графика дискретного сигнала ----
    f_complex = zeros(1, length(N));
    for i=1:dots_num + 1
        for j=1:fourie_parts
            f_complex(i) = f_complex(i) +...
                C(j) * exp(1i * 2 * pi * j * (i-1) / dots_num);
        end
        f_complex(i) = f_complex(i) + C0/2;
    end

    % ---- Вычисление спектра амплитуд ----
    Cab = zeros(1, fourie_parts);
    for j=1:fourie_parts
        Cab(j) = abs(C(j));
    end

    % ---- Вычисление погрешности ----

    df = zeros(1, dots_num);    % Абсолютная погрешность
    for i=2:dots_num-1
      df(i) = f(i) - real(f_complex(i)) ;
    end

    STD = std(df / (max(real(f)) - min(real(f))) * 100); % STD в процентном отношении
    STD_percent_arr(end+1) = STD;
    
    disp(fourie_parts);
    disp(STD);
    disp('---');

    % ---- Визуализация графиков ----
    % 1 - спектр амплитуд
    % 2 - графики функции и восстановленной функции
    
    figure
    subplot(2, 1, 1),
    plot(N, f, 'r-', 'DisplayName', 'Original f(x)'), hold on,
    plot(N, real(f_complex), 'b-', 'DisplayName', 'Сomplex Fourie f(x)'),
    title('Функция abs(sin(x))'),
    xlabel('x'),
    ylabel('f(x)'),
    legend(),
    grid on;
        
    subplot(2, 1, 2),
    stem(Cab),
    title('Спектр амплитуд сигнала'),
    xlabel('Количество членов комплексного ряда Фурье'),
    ylabel('Амплитуда'),
    legend(strcat('Количество членов комплексного ряда Фурье: ', num2str(fourie_parts)));
    grid on;
    saveas(gcf,strcat('fourie_complex_part', num2str(fourie_parts), '.png'));
end

figure, plot(fourie_parts_arr, STD_percent_arr, '-o'),
title('зависимость процента погрешности от членов комплексного ряда Фурье'),
ylabel('%'),
xlabel('Количество членов комплексного ряда Фурье');
saveas(gcf, 'STD_complex_depend.png');