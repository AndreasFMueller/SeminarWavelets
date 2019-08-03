%% Copyright (C) 2019 Roy Seitz
%% Calculate continuouse wavelet transform via fft
% Multiple options for signal padding:
% 0:  No padding (default)
% 1:  Flipped and conjugated signal padding (Standard if needed)
% 2:  Zero padding (because we can)
% 3:  Matlab (Flipped but not conjugated)
% WL: 0 Morlet, 1: real Haar, 2: analytic Haar, 3: Gabor
% Return values
% yab:  The wavelet transform, one column per a-values
% a:    The used a values calculated based on ts and signal length
function [yab, a] = myCWT(x, ts, height=300, padding=1, WL=0, a_max = 16)
    N = length(x);
    if ~exist('padding', 'var'); padding = 0; end
    if ~exist('WL', 'var'); WL = 0; end
    % a values 
    a_min = 1;
    
    a = linspace(a_min, a_max, height);
    % FFTs of signal
    switch padding
        case 1 % Matlab for complex signals
            x = [conj(x(N/2:-1:1)); x; conj(x(end:-1:N/2+1))];
        case 2 % Zero padding
            x = [zeros(N/2,1); x; zeros(N/2,1)];
        case 3 % Matlab
            x = [x(N/2:-1:1); x; x(end:-1:N/2+1)];
        otherwise
            % No padding
    end
    Nfft = length(x);
    w = linspace(0, 2*pi/ts * (Nfft-1)/Nfft, Nfft)';  % Frequency Vector
    
    X = fft(x, Nfft) / N;
    
    switch WL
      case 1
        Psi_ab = myHaarReal(w, a);
      case 2
        Psi_ab = myHaarComplex(w, a);
      case 3
        Psi_ab = myGabor(w, a);
      otherwise    
        Psi_ab = myMorlet(w, a);
    end
    Yab = X .* Psi_ab;
    yab_padded = ifft(Yab);
    switch padding
        case {1,3}
            yab = yab_padded(N/2+1:3*N/2, :);
        case 2
            yab = yab_padded(N/2+1:3*N/2, :);
        otherwise
            yab = yab_padded;
    end
end

function Psi_ab = myMorlet(w, a)
    sigma = 2 * pi;
    c_sigma = pi^(-1/4) * (1 + exp(-sigma^2) - 2 * exp(-3/4 * sigma^2) ) ^ (-1/2);
    
    w = w ./ a;
    Psi_ab = c_sigma .* (exp(-(sigma - w).^2/2)); % w/o dc offset
    % Psi_ab = c_sigma .* (exp(-(sigma - w).^2/2) - exp(-sigma^2/2) * exp(-w.^2/2)); % With dc     
    Psi_ab([1, length(w)/2:end], :) = 0;
end

function Psi_ab = myGabor(w, a)
    sigma = 2 * pi;
    c_sigma = pi^(-1/4) / sqrt(2) * (1 + exp(-sigma^2) - 2 * exp(-3/4 * sigma^2) ) ^ (-1/2);
    
    idx = ceil(length(w)/2+1):length(w);
    w(idx) = w(idx) - w(end) - w(1);
    w = w ./ a;

    Psi_ab = c_sigma .* (exp(-(sigma - w).^2/2) + exp(-(sigma + w).^2/2)); % w/o dc offset

    idx = w == 0;
    Psi_ab(idx) = 0;
end

function Psi_ab = myHaarReal(w, a)    
    idx = ceil(length(w)/2+1):length(w);
    w(idx) = w(idx) - w(end) - w(1);
    w = w ./ a;
    
    Psi_ab = 2i .* (1 - cos(w/2)) ./ w; 
    idx = w == 0;
    Psi_ab(idx) = 0;
end

function Psi_ab = myHaarComplex(w, a)    
    w = w ./ a;
    Psi_ab = pi*1i .* (1 - cos(w/pi)) ./ w; 
    Psi_ab([1, length(w)/2:end], :) = 0;
end