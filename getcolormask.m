function colormask = getcolormask(M,N,wbcoeffs,bayertype)
    % Makes a white-balance multiplicative mask for an image of size MxN
    % with RGB while balance multipliers wbcoeffs = [R_scale G_scale B_scale].
    % ALIGN is string indicating Bayer type: ’RGGB’,’BGGR’,’GRBG’,’GBRG’
    
    % Initialize to all green values
    colormask = wbcoeffs(2) * ones(M,N);
    
    switch bayertype
        case 'RGGB'
            colormask(1:2:end,1:2:end) = wbcoeffs(1); %r
            colormask(2:2:end,2:2:end) = wbcoeffs(3); %b
        case 'BGGR'
            colormask(2:2:end,2:2:end) = wbcoeffs(1); %r
            colormask(1:2:end,1:2:end) = wbcoeffs(3); %b
        case 'GRBG'
            colormask(1:2:end,2:2:end) = wbcoeffs(1); %r
            colormask(2:2:end,1:2:end) = wbcoeffs(3); %b
        case 'GBRG'
            colormask(2:2:end,1:2:end) = wbcoeffs(1); %r
            colormask(1:2:end,2:2:end) = wbcoeffs(3); %b
        otherwise
            error('Bayer type <%s> does not exist. Use [RGGB, BGGR, GRBG, GBRG]', bayertype);
    end
end
