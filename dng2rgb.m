function [Csrgb , Clinear , Cxyz , Ccam] = dng2rgb(rawim , XYZ2Cam , ...
    wbcoeffs , bayertype , method , M, N)
    % Converts RAW image to an RBG image with the given size MxN, given the
    % interpolation method to use, the Bayer type of the RAW image and the
    % transform matrix of the metadata
    
    M0 = size(rawim,1);
    N0 = size(rawim,2);

    % White balancing
    mask = getcolormask(M0, N0, wbcoeffs, bayertype);
    balancedim = rawim .* mask;
    balancedim = max(0,min(balancedim,1));
    
    figure, imshow(balancedim);
    title('White Balanced Camera Image');
    
    % Interpolation
    if strcmp(method, 'nearest')
        % Nearest neighbour
        im = demosaicnn(balancedim, M, N, M0, N0, bayertype);
    elseif strcmp(method, 'linear')
        % Bilinear
        im = demosaicblnr(balancedim, M, N, M0, N0, bayertype);
    else
        error('Interpolation method <%s> does not exist. Use [nearest, linear]', method);
    end
    
    XYZ2Rgb = [3.2406, -1.5372, -0.4986;
               -0.9689, 1.8758, 0.0415;
               0.0557, -0.2040, 1.0570];
    
    % Transforms
    Ccam = im;

    % Cam -> XYZ
    XYZ2Cam = XYZ2Cam ./ repmat(sum(XYZ2Cam,2),1,3); % Normalize rows to 1
    Cxyz = applymatrix(Ccam,XYZ2Cam^-1);
    
    % Cam -> Linear
    XYZ2Rgb = XYZ2Rgb ./ repmat(sum(XYZ2Rgb,2),1,3); % Normalize rows to 1
    Clinear = applymatrix(Cxyz,XYZ2Rgb);
    Clinear = max(0,min(Clinear,1));
    
    % Linear -> sRGB
    Csrgb = Clinear.^(1/2.2);
    Csrgb = max(0,min(Csrgb,1));
end