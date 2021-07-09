function y=lagrangeown(x,pointx,pointy,modvalue,threshold)
%
%LAGRANGE   approx a point-defined function using the Lagrange polynomial interpolation
%
%      LAGRANGE(X,POINTX,POINTY) approx the function definited by the points:
%      P1=(POINTX(1),POINTY(1)), P2=(POINTX(2),POINTY(2)), ..., PN(POINTX(N),POINTY(N))
%      and calculate it in each elements of X
%
%      If POINTX and POINTY have different number of elements the function will return the NaN value
%
%      function wrote by: Calzino
%      7-oct-2001
%

delta=zeros(1,threshold);

for i=1:threshold
    delta(i)=1;
    for j=1:threshold
       if i~=j
         
           delta(i)=(mod(delta(i),modvalue)*mod((x-pointx(j))*minv((pointx(i)-pointx(j)),modvalue),modvalue));
       end
    
    end
end

y=0;
for i=1:size(delta,2)
    y=mod(y+mod((pointy(i)*delta(i)),modvalue),modvalue);
  
end
y=mod(y,modvalue);