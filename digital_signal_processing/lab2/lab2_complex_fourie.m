clear, clc, close all;

dots_num = 1024;    % ���-�� �����
N = 0:1:dots_num;   % �������� �����
T = 2 * pi;   % ������ ������� �������
kp = 1;   % ���������� �������� ������������� �������

fourie_parts_arr = [8, 16, 32, 64, 128, 256]; % ������ ���������� ������ ������������ ���� �����
STD_percent_arr = []; % ������ ��� �������� ������� SKO_percent=f(fourie_parts)

for fourie_parts = fourie_parts_arr % fourie_parts - ������� ���������� ������ ���� �����

    idx = zeros(1, length(N));
    f = zeros(1, length(N));    % �������� �������


    % ---- ���������� ������������ ���� ����� ----
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

    % ---- ������������ ������������ ���� ����� ----
    for i=1:fourie_parts
        C(i) = C(i) * (2 / dots_num);
    end

    % ---- ���������� ������� ����������� ������� ----
    f_complex = zeros(1, length(N));
    for i=1:dots_num + 1
        for j=1:fourie_parts
            f_complex(i) = f_complex(i) +...
                C(j) * exp(1i * 2 * pi * j * (i-1) / dots_num);
        end
        f_complex(i) = f_complex(i) + C0/2;
    end

    % ---- ���������� ������� �������� ----
    Cab = zeros(1, fourie_parts);
    for j=1:fourie_parts
        Cab(j) = abs(C(j));
    end

    % ---- ���������� ����������� ----

    df = zeros(1, dots_num);    % ���������� �����������
    for i=2:dots_num-1
      df(i) = f(i) - real(f_complex(i)) ;
    end

    STD = std(df / (max(real(f)) - min(real(f))) * 100); % STD � ���������� ���������
    STD_percent_arr(end+1) = STD;
    
    disp(fourie_parts);
    disp(STD);
    disp('---');

    % ---- ������������ �������� ----
    % 1 - ������ ��������
    % 2 - ������� ������� � ��������������� �������
    
    figure
    subplot(2, 1, 1),
    plot(N, f, 'r-', 'DisplayName', 'Original f(x)'), hold on,
    plot(N, real(f_complex), 'b-', 'DisplayName', '�omplex Fourie f(x)'),
    title('������� abs(sin(x))'),
    xlabel('x'),
    ylabel('f(x)'),
    legend(),
    grid on;
        
    subplot(2, 1, 2),
    stem(Cab),
    title('������ �������� �������'),
    xlabel('���������� ������ ������������ ���� �����'),
    ylabel('���������'),
    legend(strcat('���������� ������ ������������ ���� �����: ', num2str(fourie_parts)));
    grid on;
    saveas(gcf,strcat('fourie_complex_part', num2str(fourie_parts), '.png'));
end

figure, plot(fourie_parts_arr, STD_percent_arr, '-o'),
title('����������� �������� ����������� �� ������ ������������ ���� �����'),
ylabel('%'),
xlabel('���������� ������ ������������ ���� �����');
saveas(gcf, 'STD_complex_depend.png');