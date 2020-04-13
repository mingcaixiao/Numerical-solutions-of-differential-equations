clc;clear;
k=[0.95,1,1.05];%步长系数
N=[8,16,32,64,128];%区间个数
epsilon=zeros(3,5);%最大误差
rate=zeros(3,4);%误差阶

for n=1:3
    for m=1:5
        [h,x]=fh(N(m),k(n));%根据N和k得到x和h
        u=fsolve(x,h);%根据x和h求解
        u0=exp(x).*cos(x);%精确解
        epsilon(n,m)=max(abs(u-u0));%最大误差
    end
    for m=1:4
        rate(n,m)=log2(epsilon(n,m)/epsilon(n,m+1));
    end
end