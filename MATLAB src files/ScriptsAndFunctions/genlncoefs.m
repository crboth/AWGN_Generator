
function [ coefs ] = genlncoefs()%( input_args )
% coefficents for second order piecwise approximation of ln for domain [1,2)
num_segments = 256;
order = 2;
seg_len = 1/num_segments;
%MATLAB can't seem to handle polyfit with a resolution higher than 2^17
seg_inc = seg_len/2^16;
inc = 1/(2^16);

coefs = zeros(num_segments,order+1);
for i = 0:num_segments-1
    x = 1+seg_len*i:seg_inc:1+seg_len*(i+1)-seg_inc;
    y = log(x);
    coefs(i+1,:)= polyfit(0:inc:1-inc,y,order);
end
end




