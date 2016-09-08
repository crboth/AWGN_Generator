function [ f ] = sqrtapprox(e)
%Approximates the square root of input on the range [0-66.54)
persistent sqrtcoefs
if(isempty(sqrtcoefs))
    sqrtcoefs = gensqrtcoefs;
end
%I changed the algorithm from the specification to perform range reduction
%to [1,2) instead of [1,4) as this allowed for a more efficent hardware 
%implimentation
if(e == 0)
    f = 0;
else
    %seperate the input into Mantissa (x_f) and exponenet (exp_f)
    exp_f = 6-lzdetector(e,31,24);
    x_f = e/2^exp_f;
    
    %Use the first 6 bits of the mantissa to index the LUT
    indext = 64*(x_f-1);
    index = floor(indext)+1;
    
    %The remaining bits are used as the x value
    xb = mod(indext,1);
    
    %if the exponenet was odd, add 64 to the index to access the sqrt(2*x)
    %coefficents
    if(mod(exp_f,2))
        index = index + 64;
    end
    
    f = sqrtcoefs(index,1)*xb +sqrtcoefs(index,2);
    
    %Perform range reconstruction
    if(mod(exp_f,2))
        exp_f = exp_f-1;
    end
    exp_f = exp_f/2;
    f = f*2^exp_f;
end
end

