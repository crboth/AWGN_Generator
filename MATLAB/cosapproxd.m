function [ sinu1, cosu1 ] = cosapproxd(u1)
persistent coscoefs
filename = strcat('cosdebug.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'u1 = %d\n',round(u1*2^16));
if(isempty(coscoefs))
    coscoefs = gencoscoefs;
end
%started at 4
u1t = uint32(u1*2^16);
quadrant = u1t/(2^14);
xcos = mod(u1t,2^14);
xsin = xcos;
cos_index = xcos/(2^7);
sin_index = cos_index;
xbcos = double(mod(xcos,2^7));
xbsin = xbcos;
x_max = 127;

% quadrant = floor(u1/.25);
% seg_len = .25/128;
% seg_inc = seg_len/128;
% xcos = mod(u1,.25);
% xsin = xcos;
%x_max = .25-seg_len/128;
if(quadrant == 1 || quadrant == 3)
    xbcos = x_max-xbcos;
    cos_index = x_max-cos_index;
    
end
if(quadrant == 0 || quadrant == 2)
    xbsin = x_max-xbsin;
    sin_index = x_max-sin_index;
end

% cos_index = floor(xcos/seg_len)+1;
% xbcos = floor(mod(xcos,seg_len)/seg_inc);
cosu1 = coscoefs(cos_index, 1)*xbcos + coscoefs(cos_index, 2);
c1xcos = coscoefs(cos_index, 1)*xbcos;
c0cos = coscoefs(cos_index, 2);

% sin_index = floor(xsin/seg_len)+1;
% xbsin = floor(mod(xsin,seg_len)/seg_inc);
c1xsin = coscoefs(sin_index, 1)*xbsin;
c0sin = coscoefs(sin_index, 2);
sinu1 = coscoefs(sin_index, 1)*xbsin + coscoefs(sin_index, 2);

if(quadrant == 1 || quadrant == 2)
    cosu1 = -cosu1;
end
if(quadrant == 2 || quadrant == 3)
    sinu1 = -sinu1;
end
fprintf(outputf_id,'xcos = %d\n',round((128/100)*xbcos));
fprintf(outputf_id,'xsin = %d\n',round((128/100)*xbsin));
fprintf(outputf_id,'sin_index = %d\n',sin_index);
fprintf(outputf_id,'cos_index= %d\n',cos_index);
fprintf(outputf_id,'c1cos = %d\n',round(coscoefs(sin_index, 1)*2^25));
fprintf(outputf_id,'c1sin = %d\n',round(coscoefs(cos_index, 1)*2^25));
fprintf(outputf_id,'c1xcos = %d\n',round(c1xcos*2^32));
fprintf(outputf_id,'c0cos = %d\n',round(c0cos*2^20));
fprintf(outputf_id,'c1xsin = %d\n',round(c1xsin*2^32));
fprintf(outputf_id,'c0sin = %d\n',round(c0sin*2^20));
fprintf(outputf_id,'g0 = %d\n',round(cosu1*2^15));
fprintf(outputf_id,'g1 = %d\n',round(sinu1*2^15));
fclose(outputf_id);
end

