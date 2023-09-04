function support_plot(h,h_Om)

N      = size(h,2);
pas    = 2*pi/N;
pts    = zeros(N,2);
pts_Om = zeros(N,2);


% ind3(k) = k+1 and ind2(k) = k-1
ind1 = (1:1:N);
ind2 = ind1;
ind3 = ind1;
ind2(2:N) = 1:1:N-1;
ind2(1) = N;
ind3(N) = 1;
ind3(1:N-1) = 2:N;

for k = 1:N
    r = [cos(k*pas) sin(k*pas)];
    t = [-sin(k*pas) cos(k*pas)];
    pts(k,:) = h(k)*r+(h(ind3(k))-h(ind2(k)))/2/sin(pas)*t;
    pts_Om(k,:) = h_Om(k)*r+(h_Om(ind3(k))-h_Om(ind2(k)))/2/sin(pas)*t;
end

plot([pts_Om(:,1);pts_Om(1,1)],[pts_Om(:,2);pts_Om(1,2)],'LineWidth',3)
hold on
plot([pts(:,1);pts(1,1)],[pts(:,2);pts(1,2)],'LineWidth',3)
hold off
daspect([1 1 1])
axis off


end

