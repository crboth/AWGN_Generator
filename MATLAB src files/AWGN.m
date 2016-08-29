%worked from 1 to 4 on 8/17, completed quantized matlab simulation
%excluding nuanced implimentation of sin and ln
%started working at noon on 8/18 to 1:45
%4 to 8:15 on 8/21 finished sin and log
%sin approximation
tic;
loopmax = 100000;
%Tausworth Seeds
s0a = uint32(64650448);s1a = uint32(83372788);s2a = uint32(21948290);
s0b = uint32(64504248);s1b = uint32(8337978);s2b = uint32(21948180);

for i = 1:loopmax
%Generate Taus URNs
[a,s0a,s1a,s2a] = taus(uint64(s0a),uint64(s1a),uint64(s2a));
[b,s0b,s1b,s2b] = taus(uint64(s0b),uint64(s1b),uint64(s2b));

%Convert 32bit URN to double
u0 = double(a);
u1 = double(b);
%Concatenate
u0 = u0*(2^16) + round(u1/(2^16));
u1 = mod(u1, 2^16);
%Normalize
u0 = u0/(2^48);
u1 = u1/(2^16);

%Logarithm Unit
e = lnapprox(u0);
e = quantize(e, 31,24,0);

%Sqrt Unit
f = sqrtapprox(e);
f = quantize(f,17,13,0);

%SinCos Unit
[g0,g1] = cosapproxd(u1);
g0 = quantize(g0,16,15,1);
g1 = quantize(g1,16,15,1);

%Multiply Unit
x0 = f*g0 ;
x1 = f*g1 ;
x0 = quantize(x0,16,11,1);
x1 = quantize(x1,16,11,1);
x(2*i-1) = x0;
x(2*i)  = x1;
end

toc;
