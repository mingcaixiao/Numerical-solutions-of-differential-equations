clc;clear;
M=[20,40,80,160];%x的分割区间数
N=[10,20,40,80];%y的分割区间数
K=size(M,2);
x_cell=cell(K,1);%x的网格矩阵
y_cell=cell(K,1);%y的网格矩阵
u_cell=cell(K,1);%数值解
u0_cell=cell(K,1);%精确解
epsilon_cell=cell(K,1);%误差
max_epsilon=ones(K,1);%最大误差
rate=ones(K-1,1);%误差阶

for k=1:K
    [x_cell{k,1},y_cell{k,1},u_cell{k,1}]=fsolve(M(k),N(k));%求数值解
    u0_cell{k,1}=fa(x_cell{k,1},y_cell{k,1});%精确解
    epsilon_cell{k,1}=u_cell{k,1}-u0_cell{k,1};%误差
    max_epsilon(k,1)=max(epsilon_cell{k,1}(:));%最大误差
end

%求误差阶
for k=1:K-1
    rate(k,1)=log2(max_epsilon(k)/max_epsilon(k+1));
end

%取x=0.4、0.8、1.2、1.6，y=0.5时的数值解和精确解
x=[0.4,0.8,1.2,1.6];y=0.5;
u2=ones(4,4);%数值解
for k=1:K
    u2(k,:)=u_cell{k,1}(M(k)/5+1:M(k)/5:4*M(k)/5+1,N(k)/2+1);%求特定点的数值解
end

u0_1=fa(x,y);%特定点的精确解



