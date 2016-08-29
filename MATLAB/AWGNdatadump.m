
tic;
loopmax = 100000;
%Tausworth Seeds
tseedsa = zeros(3,loopmax+1);
tseedsb = zeros(3,loopmax+1);
%These arent't actually 64 bit seeds, it's a hackey way to speed up
%tausworth generation by allowing bitwise shifts to be replaced with 
%multiplcation+modulo
tseedsa(:,1) = [uint64(uint32(64650448)) uint64(uint32(83372788)) uint64(uint32(21948290))];
tseedsb(:,1) = [uint64(uint32(64504248)) uint64(uint32(8337978)) uint64(uint32(21948180))];

x = zeros(1,2*loopmax);

errore  = zeros(1,loopmax);
errorf  = zeros(1,loopmax);
errorg0 = zeros(1,loopmax);
errorg1 = zeros(1,loopmax);
a   = zeros(1,loopmax);
b   = zeros(1,loopmax);
u0  = zeros(1,loopmax);
u1  = zeros(1,loopmax);
e   = zeros(1,loopmax);
et  = zeros(1,loopmax);
f   = zeros(1,loopmax);
ft  = zeros(1,loopmax);
g0  = zeros(1,loopmax);
g1  = zeros(1,loopmax);
g0t = zeros(1,loopmax);
g1t = zeros(1,loopmax);
x0  = zeros(1,loopmax);
x1  = zeros(1,loopmax);

eref  = zeros(1,loopmax);
fref  = zeros(1,loopmax);
x0ref = zeros(1,loopmax);
x1ref = zeros(1,loopmax);
xref  = zeros(1,loopmax);

for i = 1:loopmax
%Generate Taus URNs
[a(i),tseedsa(1,i+1),tseedsa(2,i+1),tseedsa(3,i+1)] = taus(tseedsa(1,i),tseedsa(2,i),tseedsa(3,i));
[b(i),tseedsb(1,i+1),tseedsb(2,i+1),tseedsb(3,i+1)] = taus(tseedsb(1,i),tseedsb(2,i),tseedsb(3,i));
%Convert 32bit URN to double
u0(i) = double(a(i));
u1(i) = double(b(i));
%Concatenate
u0(i) = u0(i)*(2^16) + round(u1(i)/(2^16));
u1(i) = mod(u1(i),2^16);
%Normalize
u0(i) = u0(i)/(2^48);
u1(i) = u1(i)/(2^16);


%Logarithm Unit
e(i) = lnapprox(u0(i));
e(i) = quantize(e(i), 31,24,0);
et(i) = -2*log(u0(i));
eref(i) = et(i);
errore(i) = et(i)-e(i);


%Sqrt Unit
f(i) = sqrtapprox(e(i));
f(i) = quantize(f(i),17,13,0);
ft(i) = sqrt(e(i));
fref(i) = sqrt(eref(i));
errorf(i) = ft(i)-f(i);


%SinCos Unit
[g0(i),g1(i)] = cosapprox(u1(i));
g0(i) = quantize(g0(i),16,15,1);
g1(i) = quantize(g1(i),16,15,1);

g0t(i) = sin(2*pi*u1(i));
g1t(i) = cos(2*pi*u1(i));
errorg0(i) = g0(i)-g0t(i);
errorg1(i) = g1(i)-g1t(i);

%FinalUnit
x0(i) = f(i)*g0(i);
x1(i) = f(i)*g1(i);
x0(i) = quantize(x0(i),16,11,1);
x1(i) = quantize(x1(i),16,11,1);
x0ref(i) = fref(i)*g0(i);
x1ref(i) = fref(i)*g1(i);
x(2*i-1) = x0(i);
x(2*i) = x1(i);
end

toc;
