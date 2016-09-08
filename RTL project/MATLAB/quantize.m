function [out] = quantize(in, total_bits, frac_bits, allow_neg)
%quantize and round an input number with the specified bit format and
%whether it is two's complement or not
max = (2^(total_bits)-1)/(2^frac_bits);
if(allow_neg)
    total_bits = total_bits-1;
    min = -(2^(total_bits));
else
    min = 0;
end

out = round(in*(2^frac_bits))/2^frac_bits;
out(out > max) = max;
out(out < min) = min;
end

