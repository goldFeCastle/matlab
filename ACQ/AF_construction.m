clc;
clear all;

pname = input('Enter the name of text file : ', 's');
x_num = input('X ���� ���� : ');
y_num = input('Y ���� ���� : ');
z_num = input('Z ���� ���� : ');
%pix_size = input('�ȼ� ���� : ');
resol = 1;    % ���ش�

col_index = 0;
row_index = 0;
max_value = 0;
NFL_layer = 1;

for y=1:y_num
    filename = sprintf('%s_AF_%d.txt', pname, y);
    now_M = load(filename);

    [m,n]=max(now_M);
    [a,b]=max(m);

    
    if max(m) > max_value
        col_index = b;
        row_index = n(b);
        max_value = max(m);
        NFL_layer = y;
        compare = filename;
    end
    
    clear now_M;

end

%col_index
%row_index
%max_value
%NFL_layer
%compare

%----------------------- ������� �ִ밪�� ������ ��� ��ǥ ã�� -------

filename = sprintf('%s_AF_%d.txt', pname, NFL_layer);
%filename = sprintf('field_%d.txt',NFL_layer);

AF = load(filename);
AF = AF / max_value;

figure, plot(AF(row_index,:), 'LineWidth',2);  % <------------------ ���� ��� 
    ZTL = 1:resol:(resol * (z_num+2) + 0.05);
    ZT = 1:z_num+2;
    set(gcf, 'Name', 'Axial_Profile');    
    set(gca, 'XTickLabel',ZTL, 'XTick', ZT , 'FontWeight','bold', 'FontSize',12, 'FontName','Times New Roman');
    title('[ Axial Profile ]','FontWeight','bold','FontSize',16, 'FontName','Times New Roman');
    xlabel('unit : mm','FontWeight','bold','FontSize',14, 'FontName','Times New Roman');
    ylabel('Front Side','FontWeight','bold','FontSize',14,'FontName','Times New Roman');
    axis tight;
    grid on;

figure, plot(AF(:, col_index), 'LineWidth',2);  % <------------------ ���� ��� 
    set(gcf, 'Name', 'Lateral_Profile');    
    XTL = 1:resol:(resol * (x_num+2) + 0.05);
    XT = 1:x_num+2;
    set(gcf, 'Name', 'Lateral Profile');    
    set(gca, 'XTickLabel',XTL, 'XTick', XT , 'FontWeight','bold', 'FontSize',12, 'FontName','Times New Roman');
    title('[ Lateral Profile ]','FontWeight','bold','FontSize',16, 'FontName','Times New Roman');
    xlabel('Front Side       unit : mm','FontWeight','bold','FontSize',14, 'FontName','Times New Roman');
    axis tight;
    grid on;

%figure, mesh(AF);
AF_1 = interp2(AF,5);

figure, mesh(AF_1);             % <------------------ ���� ��� 
    XTL = 1:resol:(resol * (z_num+2) + 0.05);
    XT = 1:32:((z_num+2) * 32);
    ZTL = 1:resol:(resol * (x_num+2) + 0.05);
    ZT = 1:32:((x_num+2) * 32);
    set(gcf, 'Name', 'Acoustic_Field_Distribution');    
    set(gca, 'XTickLabel',XTL, 'XTick', XT , 'YTickLabel',ZTL, 'YTick', ZT, 'FontWeight','bold', 'FontSize',12, 'FontName','Times New Roman');    
    title('[ Acoustic Field Distribution ]','FontWeight','bold','FontSize',14, 'FontName','Times New Roman');
    xlabel('unit : mm','FontWeight','bold','FontSize',14, 'FontName','Times New Roman');
    ylabel('Front Side','FontWeight','bold','FontSize',14, 'FontName','Times New Roman');
    axis tight;
    colorbar;
    view(2);

%----------------------- ������� ����, �������� �׸��� -------

NFL = (col_index - 1) * 0.4;          % <------------ ���� ���, z�� ���� Ȯ��
NFL = NFL + 1;                  % <------------ ���� �� ���� ���� (mm ����)
NFL

[m1, n1] = size(AF);

count_3 = 0;
count_6 = 0;
count_10 = 0;

for i = 1:m1
    for j= 1:n1
        val = AF(i,j);
        if val >= 0.707
            count_3 = count_3 +1;
        end
        
        if val >= 0.25
            count_6 = count_6 +1;
        end
        
        if val >= 0.1
            count_10 = count_10 +1;
        end
        
        j = j+1;

    end
    i= i+1;

end
        % ----------------�ȼ�(����) ���ش� Ȯ��
area_3dB = count_3 * resol * resol;     % <------------------ ���� ��� 
area_6dB = count_6 * resol * resol;     % <------------------ ���� ��� 
area_10dB = count_10 * resol * resol;     % <------------------ ���� ��� 
area_3dB
area_6dB
area_10dB