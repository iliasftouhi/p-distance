function [A,grad_A] = support_area(h)

N      = size(h,2);
pas    = 2*pi/N;
grad_A = zeros(N,1);

% ind3(k) = k+1 and ind2(k) = k-1
ind1 = (1:1:N);
ind2 = ind1;
ind3 = ind1;
ind2(2:N) = 1:1:N-1;
ind2(1) = N;
ind3(N) = 1;
ind3(1:N-1) = 2:N;

A= 0;

for k = 1:N 
    A = A + h(k)^2 + 1/(2-2*cos(pas))*h(k)*(h(ind3(k))-2*h(k)+h(ind2(k))); 
end

A = .5*pas*A;

% Comuptation of the gradients 

for k = 1:N
    grad_A(k) = 2*h(ind2(k)) + 2*h(ind3(k))-4*cos(pas)*h(k);
end

grad_A = pi/2/N/(1-cos(pas))*grad_A;

end


