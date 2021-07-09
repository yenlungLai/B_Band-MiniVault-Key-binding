function [ y, coutput,primen, realpoint ] = bindkey( A,num_chaff,tau,u,largeprime,band,coef_vector)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
%add empty chaff, formation of vault
coutput=[];
rand=[];
for i=1:size(A,2)/band
% size(A,2)
   rand=[rand randi(num_chaff)] ;

end
rand=repmat(rand,1,band);

for i=1:size(A,2)
c=ones(1,num_chaff)-2;
realindex=rand(i);
    
    c(1,realindex)=A(i);
    coutput=[coutput c];
end


realpoint=find(coutput(1,1:(size(A,2)*num_chaff)/band)~=(-1));

% realpoint
% realpoint=1:250;

v2 = setdiff(1:tau,A(:));

coutput(coutput==-1)=datasample(v2,size(find(coutput==-1),2));

%bind key, generate y

primen=max(primes(largeprime));
id=realpoint;


[ q ] = lagrange_mod( u,id,primen,coef_vector);
y=zeros(1,(size(coutput,2))/band);
v3 = setdiff(1:primen,q);


        for jj=1:size(id,2)
            y(id(jj))=q(jj);
 
    
        end
  
 
            y(y==0)=randsample(v3,size(find(y==0),2));

end

