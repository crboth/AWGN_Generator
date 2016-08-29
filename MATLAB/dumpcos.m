
filename = strcat('cosc0h.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%X\n',c0n);
fclose(outputf_id);

filename = strcat('cosc1h.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%X\n',c1n);
fclose(outputf_id);
