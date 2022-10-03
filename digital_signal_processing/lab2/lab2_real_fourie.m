clear, clc, close all;

dots_num = 1024;    % кол-во точек
N = 0:1:dots_num;   % интервал точек
T = pi;   % диапазон изменения функции f(i) равен +/-T
kp = 2;   % количество периодов гармонической функции

fourie_parts_arr = [8, 16, 32, 64, 128, 256]; % разные количества членов ряда Фурье
STD_percent_arr = []; % массив для создания графика SKO_percent=f(fourie_parts)

for fourie_parts = fourie_parts_arr % fourie_parts - текущие количество членов ряда Фурье

    idx = zeros(1, length(N));
    f = zeros(1, length(N));    % исходная функция


    % ---- Вычисление ряда фурье ----
    for i=1:dots_num + 1
        idx(i) = 2 * T * (i-1 - dots_num/2) / dots_num;
        f(i) = abs(sin(kp * idx(i))) + 10;
    end

    Sa0 = sum(f) / dots_num;
    Sa = zeros(1, fourie_parts);
    Sb = zeros(1, fourie_parts);

    for i=1:dots_num + 1
        for j=1:fourie_parts
            Sa(j) = Sa(j) + f(i) * cos(j * idx(i));
            Sb(j) = Sb(j) + f(i) * sin(j * idx(i));
        end
    end

    % ---- нормализация ряда Фурье ----
    for i=1:fourie_parts
        Sa(i) = Sa(i) / (dots_num / 2);
        Sb(i) = Sb(i) / (dots_num / 2);
    end

    % ---- Вычисление графика дискретного сигнала ----
    f_disc = zeros(1, length(N));
    for i=1:dots_num + 1
        for j=1:fourie_parts
            f_disc(i) = f_disc(i) +...
                Sa(j) * cos(j * idx(i)) +...
                Sb(j) * sin(j * idx(i));
        end
        f_disc(i) = f_disc(i) + Sa0;
    end

    % ---- Вычисление спектра амплитуд ----
    Sab = zeros(1, fourie_parts);
    for j=1:fourie_parts
        Sab(j) = sqrt(Sa(j)^2 + Sb(j)^2);
    end

    % ---- Вычисление погрешности ----

    df = zeros(1, dots_num);    % Абсолютная погрешность
    for i=2:dots_num-1
      df(i) = f(i) - f_disc(i) ;
    end

    STD = std(df / (max(f) - min(f)) * 100); % STD в процентном отношении
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
    plot(N, f_disc, 'b-', 'DisplayName', 'Fourie f(x)'),
    title('Функция abs(sin(x))'),
    xlabel('x'),
    ylabel('f(x)'),
    legend(),
    grid on;
        
    subplot(2, 1, 2),
    stem(Sab),
    title('Спектр амплитуд сигнала'),
    xlabel('Количество членов ряда Фурье'),
    ylabel('Амплитуда'),
    legend(strcat('Количество членов ряда Фурье: ', num2str(fourie_parts)));
    grid on;
    saveas(gcf,strcat('fourie_real_part', num2str(fourie_parts), '.png'));
end

figure, plot(fourie_parts_arr, STD_percent_arr, '-o'),
title('зависимость процента погрешности от членов ряда Фурье'),
ylabel('%'),
xlabel('Количество членов ряда Фурье');
saveas(gcf, 'STD_depend.png');