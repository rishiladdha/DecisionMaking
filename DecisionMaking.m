% Read the PDFs to understand what's going on 

%%
%Plot single attribute utility functions
%u1(x1)
fplot (@(x) 1, [0,1000],'b')
ylim ([-0.5 1.25])
grid on
xlabel('Attribute 1 - Cost ($)')
ylabel('Utility')
hold on
fplot (@(x) -6*10^-5*(x/100)^3+1.3*10^-3*(x/100)^2-2.64*10^-2*(x/100)+1.1907, [1000,2950],'r')
hold on
fplot (@(x) 0, [2950, 4000], 'g')
hold off

%%
%u2(x2)
fplot (@(x) 5*10^-6*x^3+7*10^-5*x^2+0.002*x+0.0011, [0,54],'b')
ylim ([-0.5 1.25])
grid on
xlabel('Attribute 2 - Life')
ylabel('Utility')
hold on
fplot (@(x) 1, [54,75],'r')
hold off

%%
%Local Risk Aversion
syms x
f = 5*10^-6*x^3+7*10^-5*x^2+0.002*x+0.0011;
risk_aversion = -(diff(f,2)/diff(f));
vpa(subs(risk_aversion,x,30))

%%
%Expected Utility of each alternative
clear all;

k1 = 0.5;
k2 = 0.5;
% Uncomment for each alternative
% Alternative A0:
%x1 = 3000;
%x2 = wblrnd(40,10,10000,1) ;
% Alternative A1:
%x1=1500;
%x2 = wblrnd(40,10,10000,1) - 24 ;
% Alternative A2:
%x1=2000;
%x2 = wblrnd(40,10,10000,1) - 18 ;
% Alternative A3:
% x1=2500;
%x2 = wblrnd(40,10,10000,1) -12 ;

if (x1 >= 0 && x1 < 1000)
    u1 = 1;   
elseif (x1 >= 1000 && x1 <= 2950)
    u1 = -6*10^(-5)*((x1/100)^3) + 1.3*10^(-3)*((x1/100)^2) - 2.64*10^(-2)*(x1/100) + 1.1907;
else
    u1 = 0;
end

for i = 1 : 10000
if (x2(i) >= 0 && x2(i) < 54)
    u2(i) = 5*10^(-6)*(x2(i)^3) + 7*10^(-5)*(x2(i)^2) + 0.002*x2(i) + 0.0011;
else
    u2(i) = 1;
end
end

for i = 1:10000
    U(i) = k1*u1 + k2*u2(i);
end
disp(mean(U));