clc;clear;
M=[20,40,80,160];%x的分割区间数
N=[10,20,40,80];%y的分割区间数
K=size(M,2);
x_cell=cell(K,1);%x的网格矩阵
y_cell=cell(K,1);%y的网格矩阵
u_cell=cell(K,1);%数值解
u0_cell=cell(K,1);%精确解
epsilon_cell=cell(K,1);%误差
%误差图
for k=1:K
    [x_cell{k,1},y_cell{k,1},u_cell{k,1}]=fsolve(M(k),N(k));%求数值解
    u0_cell{k,1}=fa(x_cell{k,1},y_cell{k,1});%精确解
    epsilon_cell{k,1}=u_cell{k,1}-u0_cell{k,1};%误差
    figure(k)
    mesh(x_cell{k,1},y_cell{k,1},epsilon_cell{k,1});%绘图
    title(strcat('M=',mat2str(M(k)),' N=',mat2str(N(k))));
    xlabel('x');ylabel('y');zlabel('|u(x_{i},y_{j})-u_{ij}|');
end

%精确解和M=40,N=20时的数值解对比
figure(5)
subplot(1,2,1)
mesh(x_cell{2,1},y_cell{2,1},u_cell{2,1});
xlabel('x');ylabel('y');zlabel('u_{ij}');
title('M=40,N=20时的数值解');
subplot(1,2,2)
mesh(x_cell{2,1},y_cell{2,1},u0_cell{2,1});
xlabel('x');ylabel('y');zlabel('u(x_{i},y_{j})');
title('精确解');