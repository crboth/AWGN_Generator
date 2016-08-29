
function [ coefs ] = genlncoefs()%( input_args )
% coefficents for second order piecwise approximation of ln for domain [1,2)
num_bits = 48;
num_segments = 256;
order = 2;
num_index_bits = ceil(log2(num_segments));
seg_len = 1/num_segments;
%%%%%%
seg_inc = seg_len/2^16;%(num_bits-num_index_bits);
inc = 1/(2^16);
%%%%%%
%really need to figure out how many bits to use, least squares really
%messes with things

coefs = zeros(num_segments,order+1);
for i = 0:num_segments-1
    x = 1+seg_len*i:seg_inc:1+seg_len*(i+1)-seg_inc;
    y = log(x);
    coefs(i+1,:)= polyfit(0:inc:1-inc,y,order);
    %Perform min-max quantization
end
end




