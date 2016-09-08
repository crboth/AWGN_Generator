function [ e ] = lnapprox( u0)
%Approximation of -2ln(x)
persistent lncoefs
if(isempty(lncoefs))
    lncoefs = genlncoefs;
end
if(u0 == 0)
    e = 0;
else
    %constant ln(2)
    ln2 = quantize(log(2),32,32,0);
    %shift the input onto the range [1,2)
    numlzs = lzdetector(u0,48,48)+1;
    Mu0 = u0*(2^numlzs);
    
    %Grab the first 8 "bits" for the index
    index = floor((Mu0-1)*256)+1;
    
    %use the rest as the x value
    x = mod((Mu0-1)*256,1);
    lnapprox = lncoefs(index,1)*x*x+lncoefs(index,2)*x+lncoefs(index,3);
    
    %Range reconstruction
    et = numlzs*ln2;
    e = 2*(et-lnapprox);
end
end

