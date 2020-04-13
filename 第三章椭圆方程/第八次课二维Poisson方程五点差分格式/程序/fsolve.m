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
    
    u1=u0;
    for k=1:K
        for m=2:M
            for n=2:N
                u1(m,n)=(f(x(m),y(n))+u1(m,n-1)/(h2*h2)+u1(m-1,n)/(h1*h1)+...
                    u0(m+1,n)/(h1*h1)+u0(m,n+1)/(h2*h2))/(2*(1/(h1*h1)+1/(h2*h2)));
            end
        end
        if norm(u1-u0,'fro')<1e-6 %F范数小于误差限，得到解
            u=u1;break;
        else
            u0=u1;%继续迭代
        end
    end
    %返回网格矩阵
    [x,y]=meshgrid(x,y);
    x=x';y=y';
end
