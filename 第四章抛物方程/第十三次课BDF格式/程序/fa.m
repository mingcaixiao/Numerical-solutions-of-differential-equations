function r =fa(t,x)
%  求精确解
%  @t 时间向量
%  @x 空间向量
   [t,x]=meshgrid(t,x);
   t=t';
   x=x';
   r=exp(x+t);
end