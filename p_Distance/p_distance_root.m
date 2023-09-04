function [p_dist,grad_dist] = p_distance_root(h_Om,h,p)

% computes the p-distance between the set Om and the sensor om

N         = size(h_Om,2);
pas       = 2*pi/N;
grad_dist = zeros(N,1);

p_dist = (sum(abs(h_Om-h).^p*pas)).^(1/p);

for k = 1:N
    grad_dist(k) = -pas*(h_Om(k)-h(k))^(p-1)*(sum(abs(h_Om-h).^p*pas)).^(1/p-1);
end
support_plot(h,h_Om)
end


