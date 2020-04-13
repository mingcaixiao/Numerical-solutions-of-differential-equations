function [t,x,y,u] = fsolve(tau,h)
%   用PR格式解求数值解
%   @t 时间向量
%   @x 空间向量x
%   @x 空间向量y
%   @tau 时间步长
%   @h 空间步长
%   @u 数值解
    N=1/tau;%t被分割的区间数
    M=1/h;%x被分割的区间数
    t=0:tau:1;
    x=0:h:1;
    y=0:h:1;
    u=zeros(N+1,M+1,M+1);
    
    
    [t,x,y]=meshgrid(t,x,y);
    %转置，使之符合 N+1 * M+1 * M+1
    t=permute(t,[2,1,3]);
    x=permute(x,[2,1,3]);
    y=permute(y,[2,1,3]);
    
    u(1,:,:)=exp((x(1,:,:)+y(1,:,:))/2);%初值
    %边值
    u(:,1,:)=exp((1/2)*y(:,1,:)-t(:,1,:));%u(0,y,t)=e^(y/2-t)
    u(:,M+1,:)=exp((1/2)*(1+y(:,M+1,:))-t(:,M+1,:));%u(1,y,t)=e^((1+y)/2-t)
    u(:,:,1)=exp((1/2)*x(:,:,1)-t(:,:,1));%u(x,0,t)=e^(x/2-t)
    u(:,:,M+1)=exp((1/2)*(1+x(:,:,M+1))-t(:,:,M+1));%u(x,1,t)=e^((1+x)/2-t)

    r=tau/h^2;
    A1=diag(ones(M-1,1)*(1+r),0)+diag(ones(M-2,1)*(-r/2),-1)+diag(ones(M-2,1)*(-r/2),1);%系数矩阵
    
    uc=zeros(N+1,M+1,M+1);%中间层uc
    
    for k=2:N+1
        %按y方向遍历，由第k-1层求中间层
        for j=2:M
            %uc初值
            a1=r*u(k,1,j-1)-2*r*u(k,1,j)+r*u(k,1,j+1);
            b1=r*u(k-1,1,j-1)-2*r*u(k-1,1,j)+r*u(k-1,1,j+1);
            am=r*u(k,M+1,j-1)-2*r*u(k,M+1,j)+r*u(k,M+1,j+1);
            bm=r*u(k-1,M+1,j-1)-2*r*u(k-1,M+1,j)+r*u(k-1,M+1,j+1);
  
            uc(k,1,j)=1/2*(u(k-1,1,j)+u(k,1,j))-1/4*(a1-b1);
            uc(k,M+1,j)=1/2*(u(k-1,M+1,j)+u(k,M+1,j))-1/4*(am-bm);
            %右端项
            F1=r/2*u(k-1,2:M,j-1)+(1-r)*u(k-1,2:M,j)+r/2*u(k-1,2:M,j+1)...
                +tau/2*fr(t(k-1,2:M,j)+tau/2,x(k-1,2:M,j),y(k-1,2:M,j));
            F1(1)=F1(1)+r/2*uc(k,1,j);
            F1(M-1)=F1(M-1)+r/2*uc(k,M+1,j);
            F1=F1';
            uc(k,2:M,j)=A1\F1;
        end
        
        %按x方向遍历，由中间层求第k层
        for i=2:M
            %右端项
            F2=r/2*uc(k,i-1,2:M)+(1-r)*uc(k,i,2:M)+r/2*uc(k,i+1,2:M)...
                +tau/2*fr(t(k-1,i,2:M)+tau/2,x(k-1,i,2:M),y(k-1,i,2:M));
            F2(1)=F2(1)+r/2*u(k,i,1);
            F2(M-1)=F2(M-1)+r/2*u(k,i,M+1);
            F2=reshape(F2,[M-1,1]);
            u(k,i,2:M)=A1\F2;
        end
    end
end

