filename = strcat('s0a.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',tseedsa(1,:));
fclose(outputf_id);

filename = strcat('s1a.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',tseedsa(2,:));
fclose(outputf_id);

filename = strcat('s2a.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',tseedsa(3,:));
fclose(outputf_id);

filename = strcat('s0b.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',tseedsb(1,:));
fclose(outputf_id);

filename = strcat('s1b.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',tseedsb(2,:));
fclose(outputf_id);

filename = strcat('s2b.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',tseedsb(3,:));
fclose(outputf_id);

filename = strcat('tausa_out.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',a);
fclose(outputf_id);

filename = strcat('tausb_out.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',b);
fclose(outputf_id);

filename = strcat('u0.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',round(u0*2^48));
fclose(outputf_id);

filename = strcat('u1.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',round(u1*2^16));
fclose(outputf_id);

filename = strcat('e.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',round(e*2^24));
fclose(outputf_id);

filename = strcat('f.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',round(f*2^13));
fclose(outputf_id);

filename = strcat('g0.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',round(g0*2^15));
fclose(outputf_id);

filename = strcat('g1.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',round(g1*2^15));
fclose(outputf_id);

filename = strcat('x0.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',round(x0*2^11));
fclose(outputf_id);

filename = strcat('x1.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'%d\n',round(x1*2^11));
fclose(outputf_id);