function [dm,errb]=organize_Qin_data(qdata)

len=size(qdata,1);

dm=zeros(len,2);
dm(:,1)=qdata(:,1);
dm(:,2)=median(qdata(:,2:4),2);
errb=(max(qdata(:,2:4),[],2)-min(qdata(:,2:4),[],2))*0.5;
dm(:,2)=dm(:,2).*0.01;
errb=errb.*0.01;
end