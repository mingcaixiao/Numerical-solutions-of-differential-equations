clc
u1=f3(pi/10);%步长为pi/10时的数值解
u2=f3(pi/20);%步长为pi/20时的数值解
u3=f3(pi/40);%步长为pi/40时的数值解
u4=f3(pi/80);%步长为pi/80时的数值解
x1=0:pi/10:pi;x2=0:pi/20:pi;x3=0:pi/40:pi;x4=0:pi/80:pi;
%精确解
y1=cos(x1)+sin(x1);y2=cos(x2)+sin(x2);y3=cos(x3)+sin(x3);y4=cos(x4)+sin(x4);
%步长为pi/10的数值解和精确解

figure(1)
title('数值解和精确值对比');
plot(x1,u1,'b-d',x1,y1,'ro');
legend('h=pi/10时的数值解','精确解')
xlabel('x');ylabel('u(x)')


figure(2)
title('误差曲线')
abs(u1-y1)
plot(x1,abs(u1-y1),'r-o',x2,abs(u2-y2),'g-s',x3,abs(u3-y3),'b-x',x4,abs(u4-y4),'y-x');%绘制误差曲线图
h=legend('$h=\frac{\pi}{10}$','$h=\frac{\pi}{20}$','$h=\frac{\pi}{40}$','$h=\frac{\pi}{80}$');
set(h,'Interpreter','latex') %设置legend为latex解释器显示分式
xlabel('x');ylabel('|u(x)-u_h(x)|');