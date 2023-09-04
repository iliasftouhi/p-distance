function [CVM,b] = Conv_matrix(h,h_Om)

% computes the convexity matrix corresponding to the support function h

N   = size(h,2);
pas = 2*pi/N; 
CVM = [];

% ind3(k) = k+1 and ind2(k) = k-1
ind1 = (1:1:N);
ind2 = ind1;
ind3 = ind1;
ind2(2:N) = 1:1:N-1;
ind2(1) = N;
ind3(N) = 1;
ind3(1:N-1) = 2:N;

for k=1:N
    A = zeros(1,N);
    A(ind2(k)) = 1;
    A(ind3(k)) = 1;
    A(k) = -2*cos(pas);
    CVM = [CVM;A];
end

CVM = [-CVM;eye(N)];

b   = [zeros(N,1);h_Om'];
b   = [0*ones(N,1);h_Om'];

end

