
[fileName, pathname, filterIndex] =  uigetfile({'*.csv', 'Comma Separated Values (*.csv)'},'Select Comma Separated Values','MultiSelect', 'off');
File_num_r = size(fileName);
File_num = File_num_r(1,2);
R_index = 0;    
C_index = 4;

Raw_N=char(fileName);
Raw=csvread(Raw_N,R_index,C_index);
Magnitude=length(Raw);
Freq_Range = 0:(Magnitude-1);
Time_table = csvread(Raw_N,0,3);
TiMe = Time_table(:,1);
TiMe = Time_table(:,1)-min(TiMe);
TiMe2 = TiMe*(1e+3);
TStep = TiMe(100,1)-TiMe(99,1); 
figure();
plot(TiMe2,Raw);
axis([min(TiMe2) ,max(TiMe2), min(Raw) ,max(Raw)])
FFT_siganl = abs(fft(Raw));

Freq_Vector = TStep*Magnitude;
freq= Freq_Range/Freq_Vector; %create the frequency range
FFT_siganl=FFT_siganl/Magnitude*2; % normalize the data
cutOff = ceil(Magnitude/2);
freq = freq(1:cutOff);
FFT_siganl = abs(FFT_siganl(2:cutOff+1));

%take only the first half of the spectrum
ma = find(freq < 1e+7);
FFT_short = FFT_siganl(1:max(ma));
freq_short = freq(1:max(ma));
figure();
plot(freq_short,FFT_short);
hold on;
axis([min(freq_short) ,max(freq_short), min(FFT_short) ,max(FFT_short)*1.1])
Max_freq = (find(FFT_short == max(FFT_short))-1)/Freq_Vector*(1e-6)
Max_posit = (find(FFT_short == max(FFT_short))-1)/Freq_Vector;
dB=find(FFT_short > (max(FFT_short)/2));
line([min(freq_short) ,max(freq_short)],[(max(FFT_siganl)/2),(max(FFT_siganl)/2)],'color','r');
plot(Max_posit,max(FFT_short),'rv','MarkerFaceColor','r');
xlabel('Freq (Hz)')
ylabel('Amplitude')
title('FFT function')
grid on
hold off;