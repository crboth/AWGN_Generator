function [ out ] = bi2uint64(in)
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here

%create matrix of same length with increasing 2 powers
n = 1:numel(in);
powers2(n) = power(uint64(2),uint64(n-1));
out = uint64(sum(uint64(in).*powers2));


end

