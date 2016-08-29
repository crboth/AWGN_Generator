function [ f ] = sqrtapprox(e)
persistent sqrtcoefs
if(isempty(sqrtcoefs))
    sqrtcoefs = gensqrtcoefs;
end
%SQRTAPPROX Summary of this function goes here
%   Detailed explanation goes here
%started at 1:35 8/23
    if(e == 0)
        f = 0;
    else
        exp_f = 5-lzdetector(e,31,24);
        x_f = e/2^exp_f;
        if(mod(exp_f,2))
           x_f = x_f/2; 
        end
        indext = 128*(x_f-1)/3;
        index = floor(indext)+1;
        xb = mod(indext,1);
        f = sqrtcoefs(index,1)*xb +sqrtcoefs(index,2);
        if(mod(exp_f,2))
            exp_f = exp_f+1;
        end
        exp_f = exp_f/2;
        f = f*2^exp_f;
    end
end

