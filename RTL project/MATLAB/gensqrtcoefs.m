function [coefs] = gensqrtcoefs()%( input_args )
% coefficents for a first order piecwise approximation of sqrt(x)
%and sqrt(2x) over the domain [1,2) with 64 segments each
num_segments = 128;
order = 1;
seg_len = 1/64;
seg_inc = seg_len/2^16;
inc = 1/(2^16);
coefs = zeros(num_segments, order+1);
for i = 0:num_segments/2-1
    x = 1+seg_len*i:seg_inc:1+seg_len*(i+1)-seg_inc;
    y0 = sqrt(x);
    y1 = sqrt(2*x);
    coefs(i+1,:)= polyfit(0:inc:1-inc, y0, order);
    coefs(i+65,:)= polyfit(0:inc:1-inc, y1, order);
end
end