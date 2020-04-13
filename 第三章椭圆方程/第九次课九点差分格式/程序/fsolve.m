function [x,y,u] = fsolve(M,N)
%   用高斯-塞德尔迭代解方程
%   @M x分割的区间数
%   @N y分割的区间数
%   @u 数值解
%   @x,y 网格矩阵
    K=100000;%迭代次数
    h1=2/M;h2=1/N;%步长
    x=0:h1:2;y=0:h2:1;%取值节点的x、y值
    u0=zeros(M+1,N+1);
    u=ones(M+1,N+1);
    %边值条件
    u0(1,:)=sin(pi*y);
    u0(M+1,:)=exp(2)*sin(pi*y);
    
    k1=(power(h1,2)+power(h2,2))/(12*power(h1,2)*power(h2,2));
    k2=1/power(h1,2);
    k3=1/power(h2,2);
    
    u1=u0;
    for k=1:K
        for m=2:M
            for n=2:N
                %f对x的二阶导依然等于f，只要求f对y的二阶导
                u1(m,n)=(f(x(m),y(n))+1/12*(h1^2*f(x(m),y(n))+h2^2*fyy(x(m),y(n)))...
                    +k1*u1(m-1,n-1)-(2*k1-k2)*u1(m-1,n)+k1*u1(m-1,n+1)-(2*k1-k3)*u1(m,n-1)...
                    -(2*k1-k3)*u0(m,n+1)+k1*u0(m+1,n-1)-(2*k1-k2)*u0(m+1,n)+k1*u0(m+1,n+1))...
                    /(2*k2+2*k3-4*k1);
            end
        end
        if norm(u1-u0,2)<1e-12 %2范数小于误差限，得到解
            u=u1;
            break;
        else
            u0=u1;%继续迭代
        end
    end
    %返回网格矩阵
    [x,y]=meshgrid(x,y);
    x=x';y=y';
end

