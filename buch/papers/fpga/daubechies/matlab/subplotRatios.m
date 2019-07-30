function [] = subplotRatios(ax0, ax1)

    A = get(ax0,'position');           % gca points at the second one
    A(1,4) = A(1,4) *1.5;              % reduce the height by half
    A(1,2) = A(1,2) - A(1,4)/3;        % change the vertical position
    set(ax0,'position',A);             % set the values you just changed
    
    A = get(ax1,'position');           % gca points at the second one
    A(1,4) = A(1,4) / 2;               % reduce the height by half
%     A(1,2) = A(1,2) + A(1,4);        % change the vertical position
    set(ax1,'position',A);             % set the values you just changed

end

