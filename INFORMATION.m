function [ ret ] = INFORMATION( p, n )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
sub1 = (p / (p + n)); sub2 = (n / (p + n));
ret = -(sub1 * log2(sub1)) - (sub2 * log2(sub2));
end

