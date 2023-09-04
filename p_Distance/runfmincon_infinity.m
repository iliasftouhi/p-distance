function [h,dh] = runfmincon_infinity(h0,delta)

% delta is the distance we go through with 0 and 1

h_Om    =  ones(1,629);

theta   = (0:.02:2*pi);
%h_Om    = abs(cos(theta))+abs(sin(theta));



    function y = support_poly(pts,theta)
        y = max(cos(theta).*pts(:,1)+sin(theta).*pts(:,2));
    end

pts = [-1 -1;1 -1;1 1;-1 1];
h_Om = support_poly(pts,theta);
h_Om    =  ones(1,315);

%h_Om    =  2*ones(1,315);
%h_Om    =  5*ones(1,126);

    function [d_h,grad_dh] = fun(h)
        [d_h,grad_dh] = support_area(h);
    end




[A,b] = Conv_matrix(h0,h_Om);
Aeq = [];
beq = [];
lb  = h_Om-delta*ones(size(h_Om));
ub  = h_Om;

options = optimoptions('fmincon','SpecifyObjectiveGradient',true,'PlotFcn','optimplotfval',...
    'Display','iter','Algorithm','sqp','MaxFunctionEvaluations',12000,...
    'SpecifyConstraintGradient',true,'CheckGradients',false,'StepTolerance',1e-6,...
    'ConstraintTolerance',1e-6);


[h,dh]  = fmincon(@fun,h0,A,b,Aeq,beq,lb,ub,[],options);
support_plot(h,h_Om)


end