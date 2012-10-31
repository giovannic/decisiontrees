function [ ret ] = INFORMATION( p, n )
%UNTITLED7 Summary of this function goes here
%   Detailed explanation goes here
sub1 = (p / (p + n)); sub2 = (n / (p + n));
ret = -(sub1 * myLog2(sub1)) - (sub2 * myLog2(sub2));
end

function[ret] = myLog2(n)
  if (n == 0)
      ret = 0;
  else
      ret = log2(n);
  end
end