function [ coefs ] = gencoscoefs()%( input_args )
% coefficents for first order piecwise approximation of cos from 0 to pi/2

seg_len = .25/128;
seg_inc = seg_len/128;
coefs = zeros(128,2);
inc = 1/128;

for i = 0:127
    x = seg_len*i:seg_inc:seg_len*(i+1)-seg_inc;
    y = cos(2*pi*x);
    coefs(i+1,:)= polyfit(0:inc:1-inc,y,1);
end




