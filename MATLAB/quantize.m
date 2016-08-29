function [out] = quantize(in, total_bits, frac_bits, allow_neg)

max = (2^(total_bits)-1)/(2^frac_bits);

if(allow_neg)
    %an implicit sign bit is assumed? Or taken out of total_bits?
    total_bits = total_bits-1;
    min = -(2^(total_bits));
else
    min = 0;
end

out = round(in*(2^frac_bits))/2^frac_bits;
out(out > max) = max;
out(out < min) = min;
end

