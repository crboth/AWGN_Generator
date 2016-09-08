function [ i ] = lzdetector( input, num_bits, num_frac_bits)
%determines the number of leading zeroes for an input with the specified
%bit format
input = input/2^(num_bits-num_frac_bits-1);
i = 0;
if(input <= 0)
    i = num_bits;
else
    while( input*2^i < 1)
        i = i+1;
    end
end

end

