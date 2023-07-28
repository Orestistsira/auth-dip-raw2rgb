function im = demosaicnn(balancedim,M,N,M0,N0,bayertype)
    % Demosaices the given RAW image balancedim to an RGB image with the
    % chosen bayer type, using the Nearest Neighbour method for interpolation 

    % The distance between two consecutive pixels of the new grid on top of
    % the old grid, on both dimensions.
    mstep = (M0 - 1) / (M - 1);
    nstep = (N0 - 1) / (N - 1);
    
    % The new RGB image
    im = zeros(M, N, 3);
    
    % For each pixel of the new image, find the corresponding m0 and n0 of
    % the old raw image and get the colors from the nearest neighbours.
    for m=1:1:M
       m0 = round(1 + (m - 1) * mstep);
       rem2m = mod(m0, 2);
       for n=1:1:N  
           n0 = round(1 + (n - 1) * nstep);
           rem2n = mod(n0, 2);

           switch bayertype
               case 'BGGR'
                   if rem2m == 0 && rem2n == 0
                       r = balancedim(m0, n0);
                       g = balancedim(m0, n0 - 1);
                       b = balancedim(m0 - 1, n0 - 1);
                   elseif rem2m == 0
                       r = balancedim(m0, n0 + 1);
                       g = balancedim(m0, n0);
                       b = balancedim(m0 - 1, n0);
                   elseif rem2n == 0
                       r = balancedim(m0 + 1, n0);
                       g = balancedim(m0, n0);
                       b = balancedim(m0, n0 - 1);
                   else
                       r = balancedim(m0 + 1, n0 + 1);
                       g = balancedim(m0, n0 + 1);
                       b = balancedim(m0, n0);
                   end
               case 'GBRG'
                   if rem2m == 0 && rem2n == 0
                       r = balancedim(m0, n0 - 1);
                       g = balancedim(m0, n0);
                       b = balancedim(m0 - 1, n0);
                   elseif rem2m == 0
                       r = balancedim(m0, n0);
                       g = balancedim(m0, n0 + 1);
                       b = balancedim(m0 - 1, n0 + 1);
                   elseif rem2n == 0
                       r = balancedim(m0 + 1, n0 - 1);
                       g = balancedim(m0, n0 - 1);
                       b = balancedim(m0, n0);
                   else
                       r = balancedim(m0 + 1, n0);
                       g = balancedim(m0, n0);
                       b = balancedim(m0, n0 + 1);
                   end
               case 'GRBG'
                   if rem2m == 0 && rem2n == 0
                       r = balancedim(m0 - 1, n0);
                       g = balancedim(m0, n0);
                       b = balancedim(m0, n0 - 1);
                   elseif rem2m == 0
                       r = balancedim(m0 - 1, n0 + 1);
                       g = balancedim(m0, n0 + 1);
                       b = balancedim(m0, n0);
                   elseif rem2n == 0
                       r = balancedim(m0, n0);
                       g = balancedim(m0, n0 - 1);
                       b = balancedim(m0 + 1, n0 - 1);
                   else
                       r = balancedim(m0, n0 + 1);
                       g = balancedim(m0, n0);
                       b = balancedim(m0 + 1, n0);
                   end
               case 'RGGB'
                   if rem2m == 0 && rem2n == 0
                       r = balancedim(m0 - 1, n0 - 1);
                       g = balancedim(m0, n0 - 1);
                       b = balancedim(m0, n0);
                   elseif rem2m == 0
                       r = balancedim(m0 - 1, n0);
                       g = balancedim(m0, n0);
                       b = balancedim(m0, n0 + 1);
                   elseif rem2n == 0
                       r = balancedim(m0, n0 - 1);
                       g = balancedim(m0, n0);
                       b = balancedim(m0 + 1, n0);
                   else
                       r = balancedim(m0, n0);
                       g = balancedim(m0, n0 + 1);
                       b = balancedim(m0 + 1, n0 + 1);
                   end
               otherwise
                   error('Bayer type <%s> does not exist. Use [RGGB, BGGR, GRBG, GBRG]', bayertype);
           end
           
           im(m, n, :) = [r, g, b];
           
       end
    end
end