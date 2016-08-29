function [ e ] = lnapprox( u0)
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
    numlzs = lzdetector(u0,48,48)+1;
    Mu0 = u0*(2^numlzs);
    index = floor((Mu0-1)*256)+1;
    x = mod((Mu0-1)*256,1);
    lnapprox = lncoefs(index,1)*x*x+lncoefs(index,2)*x+lncoefs(index,3); 
    et = numlzs*ln2;
    e = 2*(et-lnapprox);
end
end

