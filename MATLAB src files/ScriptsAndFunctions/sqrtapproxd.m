function [ f ] = sqrtapproxd()
e = 65353/2^24;
%Dumps test values for specific e values
persistent sqrtcoefs 
if(isempty(sqrtcoefs))
    sqrtcoefs = gensqrtcoefs;
end
filename = strcat('sqrtdebug.txt');
outputf_id = fopen(filename,'w');

if(e == 0)
    f = 0;
else
    exp_f = 6-lzdetector(e,31,24);
    x_f = e/2^exp_f;
    indext = 64*(x_f-1);
    index = floor(indext)+1;
    xa = mod(indext,1);
    if(mod(exp_f,2))
        index = index + 64;
    end
    f = sqrtcoefs(index,1)*xa +sqrtcoefs(index,2);    
    if(mod(exp_f,2))
        exp_f = exp_f-1;
    end
    exp_f = exp_f/2;
    f = f*2^exp_f;
end
    fprintf(outputf_id,'e = %d\n',round(e));
    fprintf(outputf_id,'f = %d\n',round(f*2^11));
    fprintf(outputf_id,'exp_f = %d\n',round(exp_f));
    fprintf(outputf_id,'x_f= %d\n',round(x_f*2^30));
    fprintf(outputf_id,'indext = %d\n',round(indext));
    fprintf(outputf_id,'index = %d\n',round(index));
    fprintf(outputf_id,'xa = %d\n',round(xa*2^24));
    fprintf(outputf_id,'c1 = %d\n',round(sqrtcoefs(index,1)*2^18));
    fprintf(outputf_id,'c0 = %d\n',round(sqrtcoefs(index,2)*2^19));
    fprintf(outputf_id,'xc1 = %d\n',round(sqrtcoefs(index,1)*xa*2^42));
    fclose(outputf_id);
end

