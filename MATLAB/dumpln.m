
filename = strcat('lnc0h.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%X\n',c0_done);
fclose(outputf_id);

filename = strcat('lnc1h.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%X\n',c1_done);
fclose(outputf_id);

filename = strcat('lnc2h.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%X\n',c2_done);
fclose(outputf_id);