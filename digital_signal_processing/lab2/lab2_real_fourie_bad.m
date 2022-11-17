clear, clc, close all;

dots_num = 1024;    % ���-�� �����
N = 0:1:dots_num;   % �������� �����
T = pi;   % �������� ��������� ������� f(i) ����� +/-T
kp = 1;   % ���������� �������� ������������� �������

fourie_parts_arr = [8, 16, 32, 64, 128, 256]; % ������ ���������� ������ ���� �����
STD_percent_arr = []; % ������ ��� �������� ������� SKO_percent=f(fourie_parts)

for fourie_parts = 4 % fourie_parts - ������� ���������� ������ ���� �����

    idx = zeros(1, length(N));
    f = zeros(1, length(N));    % �������� �������


    % ---- ���������� ���� ����� ----
    idx = linspace(-T, T, dots_num+1);
    xx = linspace(-T/2, T/2, dots_num+1);
    for i=1:dots_num + 1
        f(i) = exp((idx(i)^2)/2);
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

    % ---- ������������ ���� ����� ----
    for i=1:fourie_parts
        Sa(i) = Sa(i) / (dots_num / 2);
        Sb(i) = Sb(i) / (dots_num / 2);
    end

    % ---- ���������� ������� ����������� ������� ----
    f_disc = zeros(1, length(N));
    for i=1:dots_num + 1
        for j=1:fourie_parts
            f_disc(i) = f_disc(i) +...
                Sa(j) * cos(j * idx(i)) +...
                Sb(j) * sin(j * idx(i));
        end
        f_disc(i) = f_disc(i) + Sa0;
    end

    % ---- ���������� ������� �������� ----
    Sab = zeros(1, fourie_parts);
    for j=1:fourie_parts
        Sab(j) = sqrt(Sa(j)^2 + Sb(j)^2);
    end

    % ---- ���������� ����������� ----

    df = zeros(1, dots_num);    % ���������� �����������
    for i=2:dots_num-1
      df(i) = f(i) - f_disc(i) ;
    end

    STD = std(df / (max(f) - min(f)) * 100); % STD � ���������� ���������
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
    plot(N, f_disc, 'b-', 'DisplayName', 'Fourie f(x)'),
    title('������� abs(sin(x))'),
    xlabel('x'),
    ylabel('f(x)'),
    legend(),
    grid on;
        
    subplot(2, 1, 2),
    stem(Sab),
    title('������ �������� �������'),
    xlabel('���������� ������ ���� �����'),
    ylabel('���������'),
    legend(strcat('���������� ������ ���� �����: ', num2str(fourie_parts)));
    grid on;
    %saveas(gcf,strcat('fourie_real_part', num2str(fourie_parts), '.png'));
end
%figure, plot(fourie_parts_arr, STD_percent_arr, '-o'),
%title('����������� �������� ����������� �� ������ ���� �����'),
%ylabel('%'),
%xlabel('���������� ������ ���� �����');
%saveas(gcf, 'STD_depend.png');