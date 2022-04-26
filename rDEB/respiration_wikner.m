close all;
%respiration data from Johan Wikner, 
%Vikstrom and Wikner, 2019'Importance of Bacterial Maintenance Respiration in a Subarctic Estuary:
%a Proof of Concept from the Field'

%because both specific growth rate and specific respiration are measured
%with uncertainty, model II regression is used.
addpath('/Users/jinyuntang/work/github/paper_matlabscripts/rDEB');
addpath('/Users/jinyuntang/work/github/matlab_tools/errorbarxy');
addpath('/Users/jinyuntang/work/github/matlab_tools/');
addpath('/Users/jinyuntang/work/github/matlab_tools/export_fig');
mpath='/Users/jinyuntang/work/github/paper_matlabscripts/rDEB';

csv=[mpath,'/MaintenanceRespirationFig3VikstromWikner2019.csv'];
fid=fopen(csv,'r');
for j = 1 : 4
    tline = fgetl(fid);
end
resp1=[];
resp2=[];
%resp1
%entry 1:4, BR_fmol_April, specific growth rate 1/day_april, 2xsd BR, 2xsd
%growth (mu)
%resp2
%entry 1:4, BR_fmol_Aug, specific growth rate 1/day_aug, 2xsd BR, 2xsd
%growth (mu)

while 1
    tline = fgetl(fid);
    if ~ischar(tline), break, end
    
    if(strlength(tline)>30)
        data1=sscanf(tline,'%f,%f,%f,%f,%f,%f,%f,%f');
        resp=resp1;
        resp1=[resp,data1(1:4)];
        resp=resp2;
        resp2=[resp,data1(5:8)];
    else
        data1=sscanf(tline,',,,,%f,%f,%f,%f');
        resp=resp2;
        resp2=[resp,data1(1:4)];        
    end

end
fclose(fid);
mu1=(0:0.01:0.26); 

%errorbarxy(resp1(2,:),resp1(1,:),resp1(4,:),resp1(3,:),{'bo','b','b'});
%hold on;
H=errorbarxy(resp2(2,:),resp2(1,:),resp2(4,:),resp2(3,:),{'ko','k','k'});
%set(H,'MarkerFaceColor','k');
hold on;
[b,bintr,bintjm,r21] = gmregress(resp2(2,:),resp2(1,:));
yy=b(2).*mu1+b(1);
yhat=b(2)*resp2(2,:)+b(1);
fprintf('linear model: R=%f*mu+%f, R^2=%f, rmse=%f\n',b(2),b(1),r21,rmse(resp2(1,:),yhat));

plot(mu1,yy,'k','LineWidth',2);
%[b1,bintr1,bintjm1,r21]=gmregress(resp2(2,:).^2,resp2(1,:));
%yy1=b1(2).*sort(resp2(2,:)).^2+b1(1);
w=linearfit(resp2(2,:).^2,resp2(1,:),0.05,'disp');
yht=resp2(2,:).^2.*w(1)+w(3);
fprintf('quadratic model: R=%f*mu*mu+%f, R^2=%f, rmse=%f\n',w(1),w(3),...
    w(6),rmse(resp2(1,:),yht));
mu=sort(resp2(2,:));
rb=sort(resp2(1,:));
yy1=mu1.^2.*w(1)+w(3);

r22=w(6);
plot(mu1,yy1,'b--','LineWidth',2);

[a1,b1,c1,r23]=nlRregress(resp2(2,:),resp2(1,:));
dn=1.-b1.*mu1;
rbh=(a1./dn-1.).*mu1+c1./dn;
plot(mu1,rbh,'r','LineWidth',2);
xlim([-0.001,0.3]);
%The original study reported b(2)=0.32(+-95% CI 0.18)
% b(1)=0.32 (+-95% CI 2.96)
legend('Measurement','Linear Model','Quadratic model','DEB model',...
    'location','best');
set(gca,'FontSize',16);
ylabel('Specific bacterial respiration (fmol O_2 cell^-^1 day^-^1)');
xlabel('Specific growth rate (day^-^1)');
set(gcf,'color','w');
%using Monte Carlo method to compute uncertainty of the nonlinear model
%standard deviation of growth rate
musd=std(resp2(2,:));
dn1=1.-b1.*resp2(2,:);
rhat=(a1./dn1-1).*resp2(2,:)+c1./dn1;
rsd=std(resp2(1,:)-rhat);
ns=1000;
nel=numel(mu);
mun=randn(ns,nel);
rsn=randn(ns,nel);
as=zeros(ns,1);
bs=zeros(ns,1);
cs=zeros(ns,1);
for jj = 1 : ns
    %get mun
    muu=resp2(2,:)+musd.*mun(jj,:);
%    muu(muu<0.)=0.0;
    dn1=1.-b1.*muu;
    rhat1=(a1./dn1-1).*muu+c1./dn1;    
    rh=rhat1+rsd.*rsn(jj,:);
 %   rh(rh<0)=0.;
    [as(jj),bs(jj),cs(jj),r231]=nlRregress(muu,rh);    
    if(as(jj)<0 || bs(jj)<0 || cs(jj)<0)
        as(jj)=0./0.;
        bs(jj)=0./0.;
        cs(jj)=0./0.;
    end
end

fprintf('best R=(%f/(1-%f*mu)-1)*mu+%f/(1-%f*mu), R^2=%f, rmse=%f\n',a1,b1,c1,b1,r23,rmse(rhat,resp2(1,:)));
fprintf('monte a: %f,%f,%f\n',mean(as,'omitnan'),prctile(as,[2.5,97.5]));
fprintf('monte b: %f,%f,%f\n',mean(bs,'omitnan'),prctile(bs,[2.5,97.5]));
fprintf('monte c: %f,%f,%f\n',mean(cs,'omitnan'),prctile(cs,[2.5,97.5]));


