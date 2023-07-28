clearvars;
close all;
warning('off','all')

% Read RAW image
[rawim, XYZ2Cam, wbcoeffs] = readdng('RawImage.DNG');

% The size of the RBG image to produce
M = 20;
N = 20;

% The way we process the image
bayertype = 'RGGB'; % [RGGB, BGGR, GRBG, GBRG]
method = 'nearest'; % [nearest, linear]

% Convert the RAW image to an RBG image with the given size
[Csrgb , Clinear , Cxyz , Ccam] = dng2rgb(rawim , XYZ2Cam , ...
    wbcoeffs , bayertype , method , M, N);

% Display
figure, imshow(Ccam);
title('Demosaiced Camera Image');
drawhistograms(Ccam, 'Demosaiced Camera Image: Channels Histograms');

figure, imshow(Cxyz);
title('XYZ Image');
drawhistograms(Cxyz, 'XYZ Image: Channels Histograms');
    
figure, imshow(Clinear);
title('Linear Image');
drawhistograms(Clinear, 'Linear Image: Channels Histograms');
    
figure, imshow(Csrgb);
title('sRGB Image');
drawhistograms(Csrgb, 'sRBG Image: Channels Histograms');

