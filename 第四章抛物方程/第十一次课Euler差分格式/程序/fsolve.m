function [t,x,u] = fsolve(tau,h)
%   用向后Euler法解抛物方程
%   @t 时间向量
%   @x 空间向量
%   @tau 时间步长
%   @h 空间步长
%   @u 数值解
    N=1/tau;%t被分割的区间数
    M=1/h;%x被分割的区间数
    t=0:tau:1;
    x=0:h:1;
    u=ones(N+1,M+1);
    u(1,:)=exp(x);%初值
    %边值
    u(:,1)=exp(t);
    u(:,M+1)=exp(1+t);

    r=tau/h^2;%步长系数
    a=ones(M-2,1)*(-r);%下对角线
    c=ones(M-2,1)*(-r);%上对角线
    b=ones(M-1,1)*(1+2*r);%主队角线
    A=diag(b,0)+diag(a,-1)+diag(c,1);%系数矩阵
    for k=2:N+1
        %右端项
        f=u(k-1,2:M);
        f(1)=f(1)+r*u(k,1);
        f(M-1)=f(M-1)+r*u(k,M+1);
        u(k,2:M)=(A\f')';%由k-1层求第k层的值
    end
end

