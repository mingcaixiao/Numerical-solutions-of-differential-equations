function [t,x,u] = fsolve(tau,h)
%   用BDF格式解抛物方程
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
    A1=diag(b,0)+diag(a,-1)+diag(c,1);%向后Euer法系数矩阵
    
    a=ones(M-2,1)*(r);%下对角线
    c=ones(M-2,1)*(r);%上对角线
    b=ones(M-1,1)*(-(2*r+3/2));%主队角线
    A2=diag(b,0)+diag(a,-1)+diag(c,1);%向后Euer法系数矩阵
    
    %由第0层求第1层
    f=u(1,2:M);
    f(1)=f(1)+r*u(2,1);
    f(M-1)=f(M-1)+r*u(2,M+1);
    u(2,2:M)=(A1\f')';%由0层求第1层的值
    
    %用Crank-Nicolson格式求出的第1层替代向后Euler法求出的第一层数值解
%     [t2,x2,u2]=fsolve12(tau,h);
%     u(2,2:M)=u2(2,2:M);
    
    %第2层到N层
    for k=3:N+1
        %右端项
        F=-2*u(k-1,2:M)+1/2*u(k-2,2:M);
        F(1)=F(1)-r*u(k,1);
        F(M-1)=F(M-1)-r*u(k,M+1);
        u(k,2:M)=(A2\F')';%由k-1层求第k层的值
    end
end

