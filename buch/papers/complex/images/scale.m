%% Scaling function for images

function z = scale(x)
  m   = abs(x);
  phi = angle(x);
  
  m = m ./ max(m(:)); % Normalize
  
    
  z = 2*m -3*m.^2 + 2*m.^3; % Scaling
  
  z = z .* exp(1i*phi);
end