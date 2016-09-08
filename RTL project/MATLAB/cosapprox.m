function [ sinu1, cosu1 ] = cosapprox(u1)
%An approximation of the Cosine and Sin functions using a piecewise
%polynomial
persistent coscoefs
if(isempty(coscoefs))
    coscoefs = gencoscoefs;
end
%Requantize u1 onto the range of a 16 bit number
u1t = u1*2^16;
%The first two bits signify which quadrant of the unit circle
quadrant = floor(u1t/(2^14));
xcos = mod(u1t,2^14);

%The next 7 are to index the LUT of polynomial coefs
cos_index = floor(xcos/(2^7))+1;
sin_index = cos_index;

%The last 7 are the x value of the polynomial approximation
xbcos = double(mod(xcos,2^7))/128;
xbsin = xbcos;
x_max = 128;

%Invert X values
if(quadrant == 1 || quadrant == 3)
    xbcos = 1-xbcos;
    cos_index = x_max+1-cos_index; 
end
if(quadrant == 0 || quadrant == 2)
    xbsin = 1-xbsin;
    sin_index = x_max+1-sin_index;
end

%Piecewise approximation
cosu1 = coscoefs(cos_index, 1)*xbcos + coscoefs(cos_index, 2);
sinu1 = coscoefs(sin_index, 1)*xbsin + coscoefs(sin_index, 2);

%Invert Y values
if(quadrant == 1 || quadrant == 2)
    cosu1 = -cosu1;
end
if(quadrant == 2 || quadrant == 3)
    sinu1 = -sinu1;
end
end

