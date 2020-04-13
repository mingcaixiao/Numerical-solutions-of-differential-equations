clc;clear;
tau=[1/10,1/20,1/40,1/80];%时间步长
h=[1/10,1/20,1/40,1/80];%空间步长
K=size(tau,2);
t_cell=cell(K,1);%时间向量
x_cell=cell(K,1);%空间向量x
y_cell=cell(K,1);%空间向量y
u_cell=cell(K,1);%数值解
ua_cell=cell(K,1);%精确解
epsilon_cell=cell(K,1);%绝对误差
for n=1:K
    [t_cell{n,1},x_cell{n,1},y_cell{n,1},u_cell{n,1}]=fsolve(tau(n),h(n));%求数值解
    ua_cell{n,1}=fa(t_cell{n,1},x_cell{n,1},y_cell{n,1});%精确解
    epsilon_cell{n,1}=abs(ua_cell{n,1}-u_cell{n,1});%求绝对误差
end
figure(1);
%t=1,tau=1/10,h=1/10时数值解和精确解对比
figure(1);
subplot(1,2,1);
x=reshape(x_cell{1,1}(1/tau(1)+1,:,:),[11,11]);
y=reshape(y_cell{1,1}(1/tau(1)+1,:,:),[11,11]);
z=reshape(u_cell{1,1}(1/tau(1)+1,:,:),[11,11]);
mesh(x,y,z);
title('数值解');xlabel('x');ylabel('y');zlabel('u(x,y,1)');
subplot(1,2,2)
ua=reshape(ua_cell{1,1}(1/tau(1)+1,:,:),[11,11]);
mesh(x,y,ua);
title('精确解');xlabel('x');ylabel('y');zlabel('u(x,y,1)');


%t=1时的误差曲线

for k=1:K
    figure(k+1)
    x=reshape(x_cell{k,1}(1/tau(k)+1,:,:),[1/h(k)+1,1/h(k)+1]);
    y=reshape(y_cell{k,1}(1/tau(k)+1,:,:),[1/h(k)+1,1/h(k)+1]);
    e=reshape(epsilon_cell{k,1}(1/tau(k)+1,:,:),[1/h(k)+1,1/h(k)+1]);
    mesh(x,y,e);
    title(strcat('\tau=1/',mat2str(1/tau(k)),' h=1/',mat2str(1/h(k))));
    xlabel('x');ylabel('y');zlabel('误差');
end