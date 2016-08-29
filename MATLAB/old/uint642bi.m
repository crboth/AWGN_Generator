function [ out ] = uint642bi( in )
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
out = zeros(1,64);
    for i = 63:-1:0
        if(in >= power(2,i)) ;
            in = in-power(2,i);
            out(i+1) = 1;
        end
    end
end

