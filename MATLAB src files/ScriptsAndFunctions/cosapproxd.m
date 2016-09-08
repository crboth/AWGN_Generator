function [ sinu1, cosu1 ] = cosapproxd()
persistent coscoefs

%This function was used to debuf the RTL implimentation
%When the Verilog results disagreed with the MATLAB results, the offending
%u1 input was pasted in and the intermediate values dumped to a file for
%comparison witht he waveform.

u1 = 32768/2^16;

filename = strcat('cosdebug.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'u1 = %d\n',round(u1*2^16));
if(isempty(coscoefs))
    coscoefs = gencoscoefs;
end

u1t = u1*2^16;
quadrant = floor(u1t/(2^14));
xcos = mod(u1t,2^14);
cos_index = floor(xcos/(2^7))+1;
sin_index = cos_index;
xbcos = double(mod(xcos,2^7))/128;
xbsin = xbcos;
x_max = 128;

if(quadrant == 1 || quadrant == 3)
    xbcos = 1-1/128-xbcos;
    cos_index = x_max+1-cos_index;
    
end
if(quadrant == 0 || quadrant == 2)
    xbsin = 1-1/128-xbsin;
    sin_index = x_max+1-sin_index;
end

cosu1 = coscoefs(cos_index, 1)*xbcos + coscoefs(cos_index, 2);
c1xcos = coscoefs(cos_index, 1)*xbcos;
c0cos = coscoefs(cos_index, 2);


c1xsin = coscoefs(sin_index, 1)*xbsin;
c0sin = coscoefs(sin_index, 2);
sinu1 = coscoefs(sin_index, 1)*xbsin + coscoefs(sin_index, 2);

if(quadrant == 1 || quadrant == 2)
    cosu1 = -cosu1;
end
if(quadrant == 2 || quadrant == 3)
    sinu1 = -sinu1;
end
fprintf(outputf_id,'xcos = %d\n',xbcos*128);
fprintf(outputf_id,'xsin = %d\n',xbsin*128);
fprintf(outputf_id,'sin_index = %d\n',sin_index);
fprintf(outputf_id,'cos_index= %d\n',cos_index);
fprintf(outputf_id,'c1cos = %X\n',round(abs(coscoefs(sin_index, 1))*2^18));
fprintf(outputf_id,'c1sin = %X\n',round(abs(coscoefs(cos_index, 1))*2^18));
fprintf(outputf_id,'c0sin = %X\n',round(c0sin*2^18));
fprintf(outputf_id,'c0cos = %X\n',round(c0cos*2^18));
fprintf(outputf_id,'c1xcos = %d\n',round(c1xcos*2^32));
fprintf(outputf_id,'c1xsin = %d\n',round(c1xsin*2^32));
fprintf(outputf_id,'cosu1 = %d\n',round(cosu1*2^25));
fprintf(outputf_id,'sinu1 = %d\n',round(sinu1*2^25));
fclose(outputf_id);

end

