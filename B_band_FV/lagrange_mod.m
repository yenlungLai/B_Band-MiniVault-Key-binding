function [ q ] = lagrange_mod( u,id,modvalue,coef_vector)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

coef=coef_vector;


for i=1:size(id,2)
    q(i)=u;
    for j=1:size(coef,2)
    
        
        q(i)=mod((mod(q(i),modvalue)+mod((coef(j)*powermod (id(i), j, modvalue)),modvalue)),modvalue);
        
    end

end



q=mod(q,modvalue);