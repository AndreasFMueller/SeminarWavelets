function [] = saveFig(fig, name)

    size = [9 4] * 1.5;

    fig.PaperUnits = 'inches';
    
    set(fig,'PaperSize',size);
    
    set(fig,'Position',[[10 10] size*100]);
    
    
%     fig.PaperPosition = [[0 0] size];
    
%     set(fig,'PaperOrientation','landscape');
    
%     set(fig, 'PaperPositionMode','Auto')

    print(fig, strcat('..\images\',  name), '-dpdf');
end

