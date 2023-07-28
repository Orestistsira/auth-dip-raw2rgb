function [rawim ,XYZ2Cam ,wbcoeffs] = readdng(filename)
    % Reads raw DNG image and returns the image as a M0xN0 matrix, the 3x3
    % XYZ2Cam matrix and the wbcoeffs (white balancing coefficients) from
    % the metadata
    
    % Read raw image
    obj = Tiff(filename,'r');
    offsets = getTag(obj,'SubIFD');
    setSubDirectory(obj,offsets(1));
    rawim = read(obj);
    close(obj);
    
    % Read image metadata
    meta_info = imfinfo(filename);
    
    % (x_origin ,y_origin) is the uper left corner of the useful part of the
    % sensor and consequently of the array rawim
    y_origin = meta_info.SubIFDs{1}.ActiveArea(1)+1;
    x_origin = meta_info.SubIFDs{1}.ActiveArea(2)+1;
    
    % Width and height of the image (the useful part of array rawim)
    width = meta_info.SubIFDs{1}.DefaultCropSize(1);
    height = meta_info.SubIFDs{1}.DefaultCropSize(2);
    blacklevel = meta_info.SubIFDs{1}.BlackLevel(1); % sensor value corresponding to black
    whitelevel = meta_info.SubIFDs{1}.WhiteLevel; % sensor value corresponding to white
    wbcoeffs = (meta_info.AsShotNeutral).^-1;
    wbcoeffs = wbcoeffs/wbcoeffs(2); % green channel will be left unchanged
    
    % Read 3x3 transform matrix
    XYZ2Cam = meta_info.ColorMatrix2;
    XYZ2Cam = reshape(XYZ2Cam,3,3)';
    
    % Keep only the useful part of the image
    rawim = double(rawim(x_origin:height, y_origin:width));
    
    % Transform values to be between 0 and 1
    rawim = (rawim - blacklevel) / (whitelevel - blacklevel);
    rawim = max(0,min(rawim,1));
end