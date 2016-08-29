function [ out, s0, s1, s2] = taus2( s0, s1, s2)
%Tausworth URNG
%the bitshift operations are very slow, should be replaced with
%multiplication/division assuming they behave the same way
nrmlz = uint64(2^32);

b =  mod(bitsrl(bitxor(bitsll(s0,13),s0),19),nrmlz);
b2 = mod(idivide(bitxor(s0*8192,s0),uint64(524288),'floor'),nrmlz);

if(b ~=b2)
    disp(b)
    disp(b2)
end

s02 = mod(bitxor(bitsll(bitand(s0,hex2dec('FFFFFFFE')),12),b),nrmlz);
s0t = mod(bitxor(bitand(s0,hex2dec('FFFFFFFE'))*4096,b),nrmlz);
if(s0t ~= s02)
    disp(s0t)
    disp(s02)
end
s0 = s0t;


b = mod(bitsrl(bitxor(bitsll(s1,2),s1),25),nrmlz);
b2 = mod(idivide(bitxor(s1*4,s1), uint64(33554432), 'floor'),nrmlz);

if(b ~=b2)
    disp(b)
    disp(b2)
end

s12 =  mod(bitxor(bitsll(bitand(s1,hex2dec('FFFFFFF8')),4),b),nrmlz);
s1t = mod(bitxor(bitand(s1,hex2dec('FFFFFFF8'))*16,b),nrmlz);
if(s1t ~=s12)
    disp(s1t)
    disp(s12)
end
s1 =s1t;


b =  mod(bitsrl(bitxor(bitsll(s2,3),s2),11),nrmlz);
b2 = mod(idivide(bitxor(s2*8,s2),uint64(2048),'floor'),nrmlz);

if(b ~=b2)
    disp(b)
    disp(b2)
end

s22 =  mod(bitxor(bitsll(bitand(s2,hex2dec('FFFFFFF0')),17),b),nrmlz);
s2t = mod(bitxor(bitand(s2,hex2dec('FFFFFFF0'))*131072,b),nrmlz);
if(s2t ~= s22)
    disp(s21)
    disp(s22)
end
s2 = s2t;


out = bitxor(bitxor(s0,s1),s2);


end


% 
% function [ out, s0, s1, s2] = taus( s0, s1, s2)
% %Tausworth URNG
% %the bitshift operations are very slow, should be replaced with
% %multiplication/division assuming they behave the same way
% b = bitsrl(bitxor(bitsll(s0,13),s0),19);
% s0 = bitxor(bitsll(bitand(s0,hex2dec('FFFFFFFE')),12),b);
% b = bitsrl(bitxor(bitsll(s1,2),s1),25);
% s1 = bitxor(bitsll(bitand(s1,hex2dec('FFFFFFF8')),4),b);
% b = bitsrl(bitxor(bitsll(s2,3),s2),11);
% s2 = bitxor(bitsll(bitand(s2,hex2dec('FFFFFFF0')),17),b);
% out = bitxor(bitxor(s0,s1),s2);
% 
% 
% end

