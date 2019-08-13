close all;
clear all;

load('Qin_Data_10C_subsoil.mat');
load('Qin_Data_20C_subsoil.mat');
load('Qin_Data_10C_topsoil.mat');
load('Qin_Data_20C_topsoil.mat');

fid1=openfile_ascii('Qin_Data_10C_subsoil.csv','w');
fid2=openfile_ascii('Qin_Data_20C_subsoil.csv','w');
fid3=openfile_ascii('Qin_Data_10C_topsoil.csv','w');
fid4=openfile_ascii('Qin_Data_20C_topsoil.csv','w');

[~,id]=sort(Qin_Data_10C_subsoil(:,1));
len=size(Qin_Data_10C_subsoil,1);

for jj = 1 : len
    fprintf(fid1,'%d,%.3f\n',ceil(Qin_Data_10C_subsoil(id(jj),1)),Qin_Data_10C_subsoil(id(jj),2));
end
fclose(fid1);

[~,id]=sort(Qin_Data_20C_subsoil(:,1));
len=size(Qin_Data_20C_subsoil,1);

for jj = 1 : len
    fprintf(fid2,'%d,%.3f\n',ceil(Qin_Data_20C_subsoil(id(jj),1)),Qin_Data_20C_subsoil(id(jj),2));
end

fclose(fid2);
[~,id]=sort(Qin_Data_10C_topsoil(:,1));
len=size(Qin_Data_10C_topsoil,1);

for jj = 1 : len
    fprintf(fid3,'%d,%.3f\n',ceil(Qin_Data_10C_topsoil(id(jj),1)),Qin_Data_10C_topsoil(id(jj),2));
end

fclose(fid3);
[~,id]=sort(Qin_Data_20C_topsoil(:,1));
len=size(Qin_Data_20C_topsoil,1);

for jj = 1 : len
    fprintf(fid4,'%d,%.3f\n',ceil(Qin_Data_20C_topsoil(id(jj),1)),Qin_Data_20C_topsoil(id(jj),2));
end

fclose(fid4);
