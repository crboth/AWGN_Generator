function [ out, s0, s1, s2] = taus( s0, s1, s2)
%Tausworth Uniform Random Number Generator

%While this is a 32 bit URNG, 64 bit numbers are used to allow much faster
%matlab simulation (the old implimentation using sll, srl,
%idivide(,,'floor') would take 95%+ of total simulation runtime
nrmlz = uint64(2^32);

b = floor(double(bitxor(mod(s0*8192,nrmlz),s0))/524288);

s0 = bitxor(mod(bitand(s0,4294967294)*4096,nrmlz),b);

b = floor(double(bitxor(mod(s1*4,nrmlz),s1))/33554432);

s1 = bitxor(mod(bitand(s1,4294967288)*16,nrmlz),b);

b = floor(double(bitxor(mod(s2*8,nrmlz),s2))/2048);

s2 = bitxor(mod(bitand(s2,4294967280)*131072,nrmlz),b);

out = bitxor(bitxor(s0,s1),s2);

end
