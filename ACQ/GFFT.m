function [ AMP,Freqency, Freq_Vector] = GFFT( Raw,TStep,Magnitude,Freq_Range )

window = hamming(Magnitude);
wind_sig = window.*Raw;
FFT_siganl = abs(fft(wind_sig,Magnitude));
Freq_Vector = TStep*Magnitude;
freq= Freq_Range/Freq_Vector; %create the frequency range
FFT_siganl=FFT_siganl/Magnitude*2; % normalize the data
cutOff = ceil(Magnitude/2);
freq = freq(1:cutOff);
FFT_siganl = abs(FFT_siganl(2:cutOff+1));

%take only the first half of the spectrum
ma = find(freq < 1e+7);
AMP = FFT_siganl(1:max(ma));
Freqency = freq(1:max(ma));


end

