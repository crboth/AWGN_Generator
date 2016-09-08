function [ out, s0, s1, s2] = taus1( s0, s1, s2)
%Tausworth URNG
%the bitshift operations are very slow, should be replaced with
%multiplication/division assuming they behave the same way
b = bitsrl(bitxor(bitsll(s0,13),s0),19);
%fprintf('1: b = %d\n',b);
s0 = bitxor(bitsll(bitand(s0,hex2dec('FFFFFFFE')),12),b);
%fprintf('1: s0 = %d\n',s0);
b = bitsrl(bitxor(bitsll(s1,2),s1),25);
%fprintf('1: b = %d\n',b);
s1 = bitxor(bitsll(bitand(s1,hex2dec('FFFFFFF8')),4),b);
%fprintf('1: s1 = %d\n',s1);
b = bitsrl(bitxor(bitsll(s2,3),s2),11);
%fprintf('1: b = %d\n',b);
s2 = bitxor(bitsll(bitand(s2,hex2dec('FFFFFFF0')),17),b);
%fprintf('1: s2 = %d\n',s2);
out = bitxor(bitxor(s0,s1),s2);


end

