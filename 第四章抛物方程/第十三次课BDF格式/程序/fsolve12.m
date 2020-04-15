function [t,x,u] = fsolve12(tau,h)
%   用Crank-Nicolson格式解求数值解
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
    a1=ones(M-2,1)*(-r/2);%下对角线
    b1=ones(M-1,1)*(1+r);%主队角线
    c1=ones(M-2,1)*(-r/2);%上对角线
    A1=diag(b1,0)+diag(a1,-1)+diag(c1,1);%系数矩阵
    
    a2=-a1;
    b2=ones(M-1,1)*(1-r);
    c2=-c1;
    A2=diag(b2,0)+diag(a2,-1)+diag(c2,1);%系数矩阵
    for k=2:N+1
        %右端项
        f=A2*u(k-1,2:M)';
        f(1)=f(1)+r/2*(u(k,1)+u(k-1,1));
        f(M-1)=f(M-1)+r/2*(u(k,M+1)+u(k-1,M+1));
        u(k,2:M)=(A1\f)';%由k-1层求第k层的值
    end
end

