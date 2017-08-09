k = [3,0.1];
a = 0.185;
u=-70:0.1:70;
usw_test1 = -k(1)*sign(u)-k(2)*u;
usw_test2 = (-k(1)*sign(u)-k(2)*u).*abs(2*sigmf(u,[a 0])-1);
usw_test3 = (-k(1)*sign(u)-k(2)*u).*abs(2./(1+exp(-k_sigm*u))-1);
plot(u,usw_test1,'--',u,usw_test2,u,usw_test3);
% axis([-70 70 -10 10]);
grid on