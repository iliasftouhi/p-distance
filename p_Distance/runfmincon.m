function [h,dh] = runfmincon(h0,a,p)

% a is the fraction of mass, to be chosen between 0 and 1

h_Om    =  ones(1,629);

theta   = (0:.02:2*pi);
h_Om    = abs(cos(theta))+abs(sin(theta));



    function y = support_poly(pts,theta)
        y = max(cos(theta).*pts(:,1)+sin(theta).*pts(:,2));
    end

pts = [-1 -1;1 -1;1 1;-1 1];
h_Om = support_poly(pts,theta);

h_Om    =  2*ones(1,315);
h_Om    =  5*ones(1,126);

    function [d_h,grad_dh] = fun(h)
        [d_h,grad_dh] = p_distance(h_Om,h,p);
        %[d_h,grad_dh] = p_distance_root(h_Om,h,p);
    end

    function [c,ceq,grad_c,grad_ceq] = nonlcon(h)
        [ceq,grad_ceq]=support_area(h);
        ceq = ceq - a*support_area(h_Om);
        c = [];
        grad_c = [];
    end


[A,b] = Conv_matrix(h0,h_Om);
Aeq = [];
beq = [];
lb  = [];
ub  = [];

options = optimoptions('fmincon','SpecifyObjectiveGradient',true,'PlotFcn','optimplotfval',...
    'Display','iter','Algorithm','sqp','MaxFunctionEvaluations',12000,...
    'SpecifyConstraintGradient',true,'CheckGradients',false,'StepTolerance',1e-6,...
    'ConstraintTolerance',1e-6);


[h,dh]  = fmincon(@fun,h0,A,b,Aeq,beq,lb,ub,@nonlcon,options);
support_plot(h,h_Om)


end