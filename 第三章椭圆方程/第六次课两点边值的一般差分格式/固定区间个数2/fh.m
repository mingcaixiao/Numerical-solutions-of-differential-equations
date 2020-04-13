function [h,x] = fh(N,k)
%   返回固定区间个数为N和步长系数k时的步长h和取值节点x
%   @N 区间个数
%   @k 步长系数 h(i)=k*h(i-1)
%   @h N对应的步长
%   @h0 初始步长
    %求解初始步长
    if k==1
        h0=1/N;
    else
        %解h0+h0*k+h0*k^2+h0*k^3...+h0*k^(N-1)==1
        h0=(1-k)/(1-power(k,N));
    end
    %返回h和x
    h(1)=h0;
    x=[0,h0];
    for n=2:N
        h(n)=k*h(n-1);
        x(n+1)=x(n)+h(n);
    end
end

