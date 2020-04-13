function u = f4(h)
%f4 用追赶法求解方程的椭圆方程的数值解
%   @u 数值解
%   @h 步长
    N=pi/h-1;%N个节点
    x=0:h:pi;%节点
    %f=@(x)(x+1)*(cos(x)+sin(x));
    %右端项
    for i=1:N
        %ff(i)=(subs(f,x(i))+10*subs(f,x(i+1))+subs(f,x(i+2)))/12
        %符号运算导致运算变化，因此优化为下列方式
        f1=(x(i)+1)*(cos(x(i))+sin(x(i)));
        f2=(x(i+1)+1)*(cos(x(i+1))+sin(x(i+1)));
        f3=(x(i+2)+1)*(cos(x(i+2))+sin(x(i+2)));
        ff(i)=(f1+10*f2+f3)/12;
    end
    ff(1)=ff(1)+1/h^2;
    ff(N)=ff(N)+(pi/12-1/h^2);
    a=-1/h^2+x(1:N)/12;%系数矩阵的下对角线
    b=2/h^2+5*x(2:N+1)/6;%系数矩阵的主对角线
    c=-1/h^2+x(3:N+1)/12;%系数矩阵的上对角线
    %追
    %计算beta
    beta(1)=c(1)/b(1);
    for i=2:N-1
        beta(i)=c(i)/(b(i)-a(i)*beta(i-1));
    end
    %解Ly=ff
    y(1)=ff(1)/b(1);
    for i=2:N
        y(i)=(ff(i)-a(i)*y(i-1))/(b(i)-a(i)*beta(i-1));
    end
    
    %赶，解u:
    u=ones(1,N);
    u(N)=y(N);
    for i=N-1:-1:1
        u(i)=y(i)-beta(i)*u(i+1);
    end
    
    u=[1,u,-1];%加入边值
end

