function [ sinu1, cosu1 ] = cosapprox(u1)
persistent coscoefs
if(isempty(coscoefs))
    coscoefs = gencoscoefs;
end
%started at 4
quadrant = floor(u1/.25);
seg_len = .25/128;
seg_inc = seg_len/128;
xcos = mod(u1,.25);
xsin = xcos;
x_max = .25-seg_len/128;
if(quadrant == 1 || quadrant == 3)
    xcos = x_max-xcos;
end
if(quadrant == 0 || quadrant == 2)
    xsin = x_max-xsin;
end

cos_index = floor(xcos/seg_len)+1;
xbcos = floor(mod(xcos,seg_len)/seg_inc);
cosu1 = coscoefs(cos_index, 1)*xbcos + coscoefs(cos_index, 2);


sin_index = floor(xsin/seg_len)+1;
xbsin = floor(mod(xsin,seg_len)/seg_inc);
sinu1 = coscoefs(sin_index, 1)*xbsin + coscoefs(sin_index, 2);

if(quadrant == 1 || quadrant == 2)
    cosu1 = -cosu1;
end
if(quadrant == 2 || quadrant == 3)
    sinu1 = -sinu1;
end
end

