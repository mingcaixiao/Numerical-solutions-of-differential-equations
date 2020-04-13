clc;clear;
x=cell(5,1);%节点
u1=cell(5,1);%紧差分格式的数值解
u2=cell(5,1);%中心差分格式的数值解
epsilon=cell(5,1);%紧差分格式的数值解和精确解的误差
h=[pi/10,pi/20,pi/40,pi/80,pi/160];%步长
n=1;
for h_item=h
    x1=linspace(0,pi,pi/h_item+1);%根据步长划分的节点
    x{n,1}=x1;
    u=f4(h_item);u1{n,1}=u;%紧差分格式
    u=f3(h_item);u2{n,1}=u;%中心差分格式
    n=n+1;
end
for n=1:5
    epsilon{n,1}=abs(u1{n,1}-(cos(x{n,1})+sin(x{n,1})));
end


%不同步长下pi/5,2pi/5,3pi/5,4pi/5下数值解和精确解
x0=[pi/5,2*pi/5,3*pi/5,4*pi/5];
%精确解
u0=cos(x0)+sin(x0);
%紧差分格式
e1=zeros(5,4);
for n=1:5
    e1(n,:)=u1{n,1}(pi/5/h(n)+1:pi/5/h(n):4*pi/5/h(n)+1);
end
%中心差分格式
e2=zeros(5,4);
for n=1:5
    e2(n,:)=u2{n,1}(pi/5/h(n)+1:pi/5/h(n):4*pi/5/h(n)+1);
end


%差分格式下取不同步长时数值解的最大误差
%紧差分格式
E1=ones(5,1);
for n=1:5
    E1(n,:)=max(epsilon{n,1});
end
%后一步长的最大误差/前一步长的最大误差
rate1=ones(1,4);
for n=1:4
    rate1(n)=E1(n)/E1(n+1);
end
%中心差分格式
E2=ones(5,1);
for n=1:5
    epsilon=abs(u2{n,1}-(cos(x{n,1})+sin(x{n,1})));
    E2(n,:)=max(epsilon);
end
%前一步长的最大误差/后一步长的最大误差
rate2=ones(1,4);
for n=1:4
    rate2(n)=E2(n)/E2(n+1);
end