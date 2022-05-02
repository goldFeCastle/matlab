clc;
clear all;

a=input('샘플링은 얼마 입니까? (ms단위로 입력) : '); %샘플링를 받아옴
b=input('초기 온도가 얼마 입니까? : ');%초기온도를 받아옴
g=input('초음파 한 샷 조사시간은 얼마 입니까?(sec단위로 입력) : ');
d=input('초음파 조사 시간은 얼마 입니까?(sec단위로 입력) : ');%초음파 조사 시간을 불러옴 
%pname = input('Enter the name of text file : ', 's'); %엑셀 파일를 불러옴
data=xlsread('40v_25%_o_5.csv'); %엑셀파일을 읽어옴
k=data(1,2); %샘플의 개수를 저장
%x=0:a*10^-3:a*10^-3*(k-1); %샘플링을 사용하여, 전체 데이터갯수를 곱해 시간축을 알아냄
y=data(14:14+(k-1),6); % 예비 y축이 될, 온도의 범위를 지정함
l=find(y==b);%초기온도의 좌표를 읽어옴
z=l(1,1); %첫번째 초기온도 위치
c=0:(a*10^-3):(a*10^-3)*(k-z);%샘플링을 사용하여, 데이터갯수를 곱해 시간축을 알아냄
p=data(z+13:k+13,6); %y축이 될, 온도의 범위를 지정함
n = length(p)*(a*10^-3);
plot(c,p) %그래프 그림
grid;
[w,m]=max(y);%최댓값을 찾고, 위치를 찾음
axis([0 a*10^-3*(k-z) (b-1) (w+1)]);
xlabel('sec');
ylabel('temp');

t=0;
i=0;
for i=0:g:d
    if i == 0
     
    else
        try
            t=i
            w=y(((t/(a*10^-3))+z));
            u=w
        catch
            f= '조사시간이 너무 큽니다'
        end 
    end
    
end
