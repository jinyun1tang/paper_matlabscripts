close all;
clear all;
clc;
figure;

plot([0.3, 0.3, 0.3]+0.2, [0.1,0.5,0.9],'.');
xlim([0,1]);ylim([0,1]);
hold on;
[x,y]=wiggle(0.4,0.05);
%plot(x+0.4,y+0.5);
[x,y]=wiggle(0.4,0.05,1);
plot(x+0.5,y+0.1);
plot(x+0.5,y+0.5);
%put_tag(gcf,gca,[0.55,0.6],'r_v_e_g',12);
put_tag(gcf,gca,[0.4,0.3],'r_s',12);
put_tag(gcf,gca,[0.4,0.7],'r_a',12);
put_tag(gcf,gca,[0.32,0.92],'z_a-------(q_a)',12);
%put_tag(gcf,gca,[0.22,0.5],'z_r-----C_r',12);
put_tag(gcf,gca,[0.32,0.05],'z_g-------(q_g, \theta_1, \epsilon_1)',12);
%put_tag(gcf,gca,[0.825,0.5],'C_i_,_v',12);
set(gca,'XTickLabel','','YTickLabel','');
line([0,1.0],[0.5,0.5]);
line([0,1.0],[0.1,0.1],'linestyle','--');

arrow([0.75,0.35],[0.75,0.5]);
arrow([0.75,0.25],[0.75,0.1]);
put_tag(gcf,gca,[0.7,0.3],'\Deltaz_1/2',12);