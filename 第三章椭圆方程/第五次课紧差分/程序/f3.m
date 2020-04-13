function u = f3(h)
%f3 用追赶法求解方程的椭圆方程的数值解
%   @u 数值解
%   @h 步长
    N=pi/h-1;%N个节点
    x=h:h:pi-h;%节点
    d=ones(1,N);%右端项
    for i=1:N
        d(i)=(x(i)+1)*(sin(x(i))+cos(x(i)));
    end
    d(1)=d(1)+1/h^2;
    d(N)=d(N)-1/h^2;
    a=ones(1,N)*(-1/h^2);%系数矩阵的下对角线
    b=2/h^2+x;%系数矩阵的主对角线
    c=ones(1,N-1)*(-1/h^2);%系数矩阵的上对角线
    %追
    %计算beta
    beta(1)=c(1)/b(1);
    for i=2:N-1
        beta(i)=c(i)/(b(i)-a(i)*beta(i-1));
    end
    %解Ly=d
    y(1)=d(1)/b(1);
    for i=2:N
        y(i)=(d(i)-a(i)*y(i-1))/(b(i)-a(i)*beta(i-1));
    end
    
    %赶，解u:
    u=ones(1,N);
    u(N)=y(N);
    for i=N-1:-1:1
        u(i)=y(i)-beta(i)*u(i+1);
    end
    
    u=[1,u,-1];%加入边值
end

