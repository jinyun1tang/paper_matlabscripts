close all;
clear all;
fl1='Qin_Data_10C_subsoil.csv';
fl2='Qin_Data_20C_subsoil.csv';
fl3='Qin_Data_10C_topsoil.csv';
fl4='Qin_Data_20C_topsoil.csv';

Qin_Data_10C_subsoil=load(fl1);
[dm,errb]=organize_Qin_data(Qin_Data_10C_subsoil);

errorbar(dm(:,1),dm(:,2),errb,'LineWidth',2);
Qinsub10C=[dm(:,1:2),errb];

hold on;
Qin_Data_20C_subsoil=load(fl2);
[dm,errb]=organize_Qin_data(Qin_Data_20C_subsoil);
errorbar(dm(:,1),dm(:,2),errb,'LineWidth',2);

Qinsub20C=[dm(:,1:2),errb];

Qin_Data_10C_topsoil=load(fl3);
[dm,errb]=organize_Qin_data(Qin_Data_10C_topsoil);

errorbar(dm(:,1),dm(:,2),errb,'LineWidth',2);
Qintop10C=[dm(:,1:2),errb];

hold on;
Qin_Data_20C_topsoil=load(fl4);
[dm,errb]=organize_Qin_data(Qin_Data_20C_topsoil);
errorbar(dm(:,1),dm(:,2),errb,'LineWidth',2);
Qintop20C=[dm(:,1:2),errb];

legend('10C\circ subsoil','20C\circ subsoil',...
    '10C\circ topsoil','20C\circ topsoil','FontSize',18);
set(gcf,'color','w');
set(gca,'FontSize',18);
xlabel('Day','FontSize',18);
ylabel('Cumulative % of soil C respired','FontSize',18);

save('Qin_topsoil.mat','Qintop10C','Qintop20C');
save('Qin_subsoil.mat','Qinsub10C','Qinsub20C');
