clc;clear;
tao=[1/100,1/400,1/1600,1/6400];%时间步长
h=[1/10,1/20,1/40,1/80];%空间步长
K=size(tao,2);
t_cell=cell(K,1);%时间向量
x_cell=cell(K,1);%空间向量
u_cell=cell(K,1);%数值解
ua_cell=cell(K,1);%精确解
epsilon_cell=cell(K,1);%绝对误差
max_epsilon=ones(K,1);
rate=ones(3,1);%误差比
for n=1:K
    [t_cell{n,1},x_cell{n,1},u_cell{n,1}]=fsolve(tao(n),h(n));%求数值解
    ua_cell{n,1}=fa(t_cell{n,1},x_cell{n,1});%精确解
    epsilon_cell{n,1}=abs(ua_cell{n,1}-u_cell{n,1});%求绝对误差
    max_epsilon(n,1)=max(epsilon_cell{n,1}(:));%求最大误差
end

%E(t,h)/E(4t,2h)
for n=1:K-1
    rate(n,1)=max_epsilon(n,1)/max_epsilon(n+1,1);
end

%当x=0.5时，取t=0.1,0.2,...1时，误差的变化,tao=1/100,h=1/10;
u_1=ones(10,1);%特定点数值解
ua_1=ones(10,1);%特定点精确解
[t,x,u]=fsolve(tao(1),h(1));
ua=fa(t,x);
u_1=u(11:10:101,6);
ua_1=ua(11:10:101,6);
epsion_1=abs(u_1-ua_1);%误差