function drawhistograms(C, ttl)
    % Draws the histogram for each color channel of an image.

    figure
    % Red
    subplot(2, 2, 1)
    histogram(C(:, :, 1), 'facecolor' , 'red', 'edgecolor', 'none')
    xlim([0 1])
    title('RED')
    
    % Green
    subplot(2, 2, 2)
    histogram(C(:, :, 2), 'facecolor' , 'green', 'edgecolor', 'none')
    xlim([0 1])
    title('GREEN')
    
    % Blue
    subplot(2, 2, 3)
    histogram(C(:, :, 3), 'facecolor' , 'blue', 'edgecolor', 'none')
    xlim([0 1])
    title('BLUE')
    
    sgtitle(ttl)
end