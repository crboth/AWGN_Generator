function [ e ] = lnapproxd( u0)
u0 = 27633567797105/(2^48);
filename = strcat('lnapproxdebug2.txt');
outputf_id = fopen(filename,'w');
fprintf(outputf_id,'U0 = %d\n',round(u0*2^48));

persistent lncoefs
if(isempty(lncoefs))
    lncoefs = genlncoefs;
end
%LNAPPROX Summary of this function goes here
%   Detailed explanation goes here
if(u0 == 0)
    e = 0;
else
    ln2 = quantize(log(2),32,32,0);
    fprintf(outputf_id,'ln2 = %d\n',round(ln2*2^32));
    numlzs = lzdetector(u0,48,48)+1;
    fprintf(outputf_id,'exp_f = %d\n',numlzs);
    Mu0 = u0*(2^numlzs);
    index = floor((Mu0-1)*256)+1;
    fprintf(outputf_id,'index = %d\n',index);
    x = mod((Mu0-1)*256,1);
    fprintf(outputf_id,'x_b = %d\n',round(x*2^40));
    xx = x*x;
    fprintf(outputf_id,'xx = %d\n',round(xx*2^40));
    xc1 = lncoefs(index,2)*x;
    fprintf(outputf_id,'xc1 = %d\n',round(xc1*2^70));
    xxc2 = lncoefs(index,1)*x*x;
    fprintf(outputf_id,'xxc2 = %d\n',round(xxc2*2^40));
    c0 = lncoefs(index,3);
    fprintf(outputf_id,'c0 = %d\n',round(c0*2^30));
    c1 = lncoefs(index,2);
    fprintf(outputf_id,'c1 = %d\n',round(c1*2^30));
    c2 = lncoefs(index,1);
    fprintf(outputf_id,'c2 = %d\n',round(c2*2^30));
    
    lnapprox = lncoefs(index,1)*x*x+lncoefs(index,2)*x+lncoefs(index,3); 
    fprintf(outputf_id,'y = %d\n',round(lnapprox*2^57));
    et = numlzs*ln2;
    fprintf(outputf_id,'et = %d\n',round(et*2^57));
    
    e = 2*(et-lnapprox);
    fprintf(outputf_id,'e = %d\n',round(e*2^57));
    
end
fclose(outputf_id);
end

