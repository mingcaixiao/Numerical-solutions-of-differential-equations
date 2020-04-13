syms x;
a=0;
b=pi;
q=x;
N=20;%casual
h=(a-b)/n;
X=a:h:b;
U_a=1;
U_b=-1;
%方程：                                                                        
q=x;
f=(x+1)*(sin(x)+cos(x));
%建立矩阵：
t=zeros(N-1,1);
main=zeros(N-1,1);
main_up=zeros(N-2,1);
main_down=zeros(N-2,1);
%通用的位置用循环设置好：
for i=1:N-1
   main(i)=(subs(q,{x},{X(i)}))+2/(h^2);
   main_up(i)=-(h^2);
   main_down(i)=-(h^2);
end
for i=1:N-1
   t(i)=subs(f,{x},{X(i)});
end

t(1)=t(1)+u_a/(h*h);
t(N-1)=t(N-1)+u_b/(h*h);

A=diag(main)+diag(main_up,1)+diag(majn_down,-1);
V=inV(A)*t;
%画图
plot(x,t,'-ro','Linewidth',2)
hold on