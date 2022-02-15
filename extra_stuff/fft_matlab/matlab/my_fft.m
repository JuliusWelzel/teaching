function [freq_vec,amp] = my_fft(time_vec,signal_vec,srate)

fftDat  = fft (signal_vec);     % Complex output
amp     = abs(fftDat );         % Extract amplitudes
amp     = amp/length(amp);      % Normalization for length
amp     = amp(1:length(amp)/2); % Cut spectrum in half
amp (2:end) = amp (2:end )* 2;  % Multiply result by 2

freq_vec = 0 : 1/time_vec(end) : srate/2-1/time_vec(end);

end

