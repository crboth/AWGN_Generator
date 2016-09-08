function [ out, s0, s1, s2] = taus3( s0, s1, s2)
%Tausworth URNG

nrmlz = uint64(2^32);

b = idivide(bitxor(mod(s0*8192,nrmlz),s0),uint64(524288),'floor');
bt = floor(double(bitxor(mod(s0*8192,nrmlz),s0))/524288);
if(b ~= bt)
    test =1;
end
s0old = s0;
s0 = bitxor(mod(bitand(s0,hex2dec('FFFFFFFE'))*4096,nrmlz),b);
s0t = bitxor(mod(bitand(s0old,4294967294)*4096,nrmlz),b);
if(s0 ~= s0t)
    test =1;
end

b = idivide(bitxor(mod(s1*4,nrmlz),s1), uint64(33554432), 'floor');
bt = floor(double(bitxor(mod(s1*4,nrmlz),s1))/33554432);
if(b ~= bt)
    test =1;
end
s1old = s1;
s1 = bitxor(mod(bitand(s1,hex2dec('FFFFFFF8'))*16,nrmlz),b);
s1t = bitxor(mod(bitand(s1old,4294967288)*16,nrmlz),b);
if(s1 ~= s1t)
    test =1;
end
b = idivide(bitxor(mod(s2*8,nrmlz),s2),uint64(2048),'floor');
bt = floor(double(bitxor(mod(s2*8,nrmlz),s2))/2048);
if(b ~= bt)
    test =1;
end
s2old = s2;
s2 = bitxor(mod(bitand(s2,hex2dec('FFFFFFF0'))*131072,nrmlz),b);
s2t = bitxor(mod(bitand(s2old,4294967280)*131072,nrmlz),b);
if(s2 ~= s2t)
    test =1;
end
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

