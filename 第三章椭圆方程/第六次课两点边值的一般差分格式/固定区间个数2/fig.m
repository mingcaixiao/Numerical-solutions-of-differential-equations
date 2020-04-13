clc;clear;
%区间N=64时，直接差分下步长系数为0.95，1，1.05时的数值解和精确解
N=64;
k=[0.95,1,1.05];%步长系数
x_cell=cell(3,1);u_cell=cell(3,1);u0_cell=cell(3,1);
for n=1:3
    [h,x]=fh(64,k(n));
    u=fsolve(x,h);%直接差分的数值解
    u_cell{n,1}=u;x_cell{n,1}=x;
    u0=exp(x).*cos(x);%精确解
    u0_cell{n,1}=u0;
    figure(n);
    plot(x,u,'b--o',x,u0,'r--x')
    title(strcat('k=',mat2str(k(n))));
    legend('数值解','精确解');
    xlabel('x');ylabel('u');
end

figure(4);
%N=64时，不同步长系数的数值解的误差
plot(x_cell{1,1},abs(u0_cell{1,1}-u_cell{1,1}),'b--o');
hold on;
plot(x_cell{2,1},abs(u0_cell{2,1}-u_cell{2,1}),'r--o');
hold on;
plot(x_cell{3,1},abs(u0_cell{3,1}-u_cell{3,1}),'g--o');
hold on;
legend('k=0.95','k=1','k=1.05');
xlabel('x');ylabel('误差');