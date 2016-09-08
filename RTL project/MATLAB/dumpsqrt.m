
filename = strcat('sqrt0h.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%X\n',c0r);
fclose(outputf_id);

filename = strcat('sqrtc1h.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%X\n',c1r);
fclose(outputf_id);

