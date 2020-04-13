function u = f6(x,h)
%f4 用追赶法求解方程的椭圆方程的数值解
%   @u 数值解
%   @h 步长向量
%   @x 取值节点向量
%   @xe 对偶列表向量
    N=size(x,2)-2;%N个节点,x有11个时，N=9
    for n=1:N+1
        xc(n)=(x(n)+x(n+1))/2;%对偶节点
    end
    %右端项
    f=exp(x(2:N+1)).*(2.*x(2:N+1).*sin(x(2:N+1))+cos(x(2:N+1)));
    f(1)=f(1)+(2*xc(1)/h(1)+1)/(h(1)+h(2));
    f(N)=f(N)+(2*xc(N+1)/h(N+1)-1)/(h(N)+h(N+1))*exp(1)*cos(1);
    

    for n=1:N
       a(n)=-(2*xc(n)/h(n)+1)/(h(n)+h(n+1));%系数矩阵的下对角线
       %系数矩阵的主对角线
       b(n)=(2*xc(n)/h(n)+2*xc(n+1)/h(n+1))/(h(n)+h(n+1))+1;
       c(n)=-(2*xc(n+1)/h(n+1)-1)/(h(n)+h(n+1));%系数矩阵的上对角线
    end
    %追
    %计算beta
    beta(1)=c(1)/b(1);
    for i=2:N-1
        beta(i)=c(i)/(b(i)-a(i)*beta(i-1));
    end
    %解Ly=f
    y(1)=f(1)/b(1);
    for i=2:N
        y(i)=(f(i)-a(i)*y(i-1))/(b(i)-a(i)*beta(i-1));
    end
    
    %赶，解u:
    u=ones(1,N);
    u(N)=y(N);
    for i=N-1:-1:1
        u(i)=y(i)-beta(i)*u(i+1);
    end
    u=[1,u,exp(1)*cos(1)];%加入边值
end

