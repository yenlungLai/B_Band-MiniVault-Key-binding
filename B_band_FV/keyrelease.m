function [regen_u,matched_point,matched_point_get ] = keyrelease( B,coutput,y,num_chaff,primen,keylength,band )
%UNTITLED5 Summary of this function goes here
%   Detailed explanation goes here

coutput2=repmat(B',1,num_chaff);
coutput2=reshape(coutput2',1,size(coutput2',1)*size(coutput2',2));

%processing final
match_AB_realpoint=(coutput2-coutput)==0;

final=zeros(1,size(coutput2,2));
final(match_AB_realpoint)=1;

% columnfinal=size(final,2)/num_chaff;
% reshapefinal = reshape(final,[num_chaff,columnfinal]);
% 
% %auto-correcting
% for i=1:size(reshapefinal,2)
%    if sum( reshapefinal(:,i))>1
%        reshapefinal(:,i)=0;
%    end
%     
%     
% end


AA=final;
processed_final=reshape(AA,1,size(AA,1)*size(AA,2));
processed_final=processed_final';

bandrelease=size(processed_final,1)/band;

bandrelease2=repmat(bandrelease,1,band);

processed_final=mat2cell(processed_final,bandrelease2, size(processed_final,2));

emptyM=sum(cat(10,processed_final{:}),10);

processed_final=logical(emptyM);
processed_final=processed_final';

matched_point=find(processed_final==1);

if (size(matched_point,2)>=keylength)
    matched_point_get=randsample(matched_point,keylength);
else
    matched_point_get=matched_point;
    
end




%key release

regen_u=lagrangeown(0,matched_point_get,y(matched_point_get),primen,size(matched_point_get,2));

end

