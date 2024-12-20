%��������� ����������� ������� �������� �������������
%������������ ��������� ������������� ����������� ������� �������� 
%�� ������ ��������� ������������� � ����������� ������� �������������
%���������� ������������� � ������ ��������� ��������,������������������,
%����������� ��������� ���� �������,������������ ��������� ����������.

clc;
clear;
sp=75;%���-�� �������� �� ������ ������� ������� �������������
kt=1024;%���������� �������� ������������ �������
h=100;%���������� �������������
shum=0.1;%������� ���� � ����� ���


f_ma_sko_percent = fopen('ma_sko_percent.txt', 'w');
f_akm_sko_percent = fopen('akm_sko_percent.txt', 'w');


for shum=[0, 0.05, 0.1, 0.15, 0.2]
    for i4=1:2048
        shift=300;% ������ �������� ��������� ��������
        for i=1:kt
            y(i)=0;
            sy(i)=0;
            w(i)=0;
            w1(i)=0;
        end
        
        %����������� ��������� �������
        noise=randn(kt);
        for i=1:kt %��������� ������� �������
            if(i>(shift-h)&(i<=shift+h))
                % w(i)=1-abs(i-shift)/h;%���� ��������(�����������)
                % w(i)=0.5*(1+cos(pi*(i-shift)/h));%���� ��������
                w(i)=0.54+0.46*cos(pi*(i-shift)/h);%���� ��������
                % w(i)=exp(-0.0003*(i-shift)^2.0); %���������������� ����
            end
        end
        for i=1:kt  %��������� ������������ �������������
            y(i)=w(i)*cos(2*3.14*(i-shift)/sp);
            y(i)=y(i)+shum*noise(i);
        end
        
        %���������� ����. ����. y[i] ������� Y
        C=max(y);
        %���������� ������ ��������  ������� Y, ���������������� ����. ����. y[i]
        for i=1:kt
            if (y(i)==C)
                shiftmax=i-1;
                shiftmax2=i;
                break
            end
        end
        if(shiftmax<0)|(shiftmax>=550000)
            dt_int=shiftmax;
        else
            dt=shiftmax; %������ �������� ������ ������� ��������� ���������
            search_area=h/(2*dt); %������� ������
            
            for ki=1:3 %���� ���������� ���������� ��������
                shagkor=dt*search_area/3;
                k=0;
                dt1=dt-dt*search_area;
                dt2=dt+dt*search_area;
                %�������� ������� ������ ���� ��������� - �� 0 �� 800
                if (dt1<0) dt1=0;end;
                if (dt2>800) dt2=800; end;
                for iii=dt1:shagkor:dt2 %���� ��� �������� 6 �������� � �����������
                    %������������� �������� ������, ������������� �� ��� ���������.
                    k=k+1;
                    xkor(k)=iii;
                    shift1=iii;
                    kor(k)=0;
                    for i=1:kt
                        x(i)=0;
                    end
                    %���������� ������� ���������� ������������� X
                    for i=1:kt %��������� ������� ������� ��� ���������� �������������
                        if(i>(shift1-h)&(i<=shift1+h))
                            % w1(i)=1-abs(i-shift1)/h;%���� ��������(�����������)
                            % w1(i)=0.5*(1+cos(pi*(i-shift1)/h));%���� ��������
                            w1(i)=0.54+0.46*cos(pi*(i-shift1)/h);%���� ��������
                            % w1(i)=exp(-0.0003*(i-shift1)^2.0); %���������������� ����
                        end
                        
                    end
                    for i=1:kt  %��������� ���������� �������������
                        x(i)=w1(i)*cos(2*3.14*(i-(shift1))/sp);
                    end
                    
                    %���������� ������� �������� X � Y
                    x_sr=mean(x);
                    y_sr=mean(y);
                    x_sko=0;
                    y_sko=0;
                    kor1(k)=0;%%��������� �������� ����� ������� �����
                    kor(k)=0;
                    %���������� ��� � ������������ ���������� X � Y
                    for i=1:kt
                        x_sko=x_sko+(x(i)-x_sr)*(x(i)-x_sr);
                        y_sko=y_sko+(y(i)-y_sr)*(y(i)-y_sr);
                        kor(k)=kor(k)+(x(i)-x_sr)*(y(i)-y_sr);
                        % sxy(i)=(abs(x(i)-y(i)));%���������� ����� ����������� !
                        % sxy(i)=(abs(x(i)+y(i)));%���������� ����� ����������� !
                        %kor1(k)=kor1(k)+sxy(i);%���������� ����� �����������/����������� !
                    end
                    %kor1(k)=kor(k)/(sqrt(x_sko*y_sko));
                    kor1(k)=kor(k);%���������� ������������ ����������
                end
                xx=1:k;
                xi=1:0.1:k;
                yint=interp1(xx,kor,xi,'spline');% ������-������������ ���� ����������
                r1=kor;
                %��������� 5 ����� - ����������� ������� ����. ���������� �� ������ ��������
                %������ ������� � ������� �-� ������-������������� spaps
                apr=spaps(xkor,kor,0.000001);
                % cmax=min(yint); %���������� �������� ����. �����������
                cmax=max(yint); %���������� ��������� ����.����./�����./�����������
                for i=1:round((k-1)/0.1+1)
                    if (yint(i)==cmax)
                        dt_int=dt-dt*search_area+(i-1)*shagkor/10; %���������� �������� ����.�������� �� ��� ������� ����. ����.
                    end
                end
                dt=dt_int;
                search_area=search_area/2;
            end
        end
        dtt(i4)=dt;
        dttma(i4)=shiftmax;
    end
    
    SKO_AKM=std(dtt);
    SKO_AKM_persent=SKO_AKM/shift*100;
    
    %figure
    %hist(dtt,7); %���������� �������� ����������� ��� ���
    %title('AKM');
    
    SKO_MA=std(dttma);
    SKO_MA_persent=SKO_MA/shift*100;
    
    fprintf(f_ma_sko_percent,'%f\n',SKO_MA_persent);
    fprintf(f_akm_sko_percent,'%f\n',SKO_AKM_persent);
    %figure
    %hist(dttma,7); %���������� �������� ����������� ��� ��
    %title('MA')
end
%pause;
close all; %�������� ���� ������������ ������
clear; %������� Workspace

