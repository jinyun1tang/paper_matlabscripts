close all;
clear all;

figh=1;
ax=multipanel(figh,4,2,[0.1,0.075],[0.4,0.15],[0.04,0.085]);

%% topsoil
%without bound on q10
load('q00100top_summary_o100.mat');

set_curAX(figh,ax(1));
h=histogram(top_o100.k2w./top_o100.k2c,100);hold on;
set(h,'FaceColor',[.95,.95,.95]);
xlabel('Slow pool Q_{10}');

set_curAX(figh,ax(3));
h1=histogram(top_o100.k2c,100); hold on;
set(h1,'FaceColor',[.95,.95,.95]);
xlabel('Slow pool k_2 at 10\circC (day^-^1)');

set_curAX(figh,ax(5));
h2=histogram(top_o100.k2w,100); hold on;
set(h2,'FaceColor',[.95,.95,.95]);
xlabel('Slow pool k_2 at 20\circC (day^-^1)');

set_curAX(figh,ax(7));
h=histogram(top_o100.flab,100); hold on;
set(h,'FaceColor',[.95,.95,.95]);
xlabel('Initial active pool fraction');
%%
load('q00004top_summary_o100.mat');

set_curAX(figh,ax(1));
h=histogram(top_o100.k2w./top_o100.k2c,100);
set(h,'FaceColor','b','EdgeColor','b');

set_curAX(figh,ax(3));
h1=histogram(top_o100.k2c,100);
set(h1,'FaceColor','b','EdgeColor','b');

set_curAX(figh,ax(5));
h2=histogram(top_o100.k2w,100);
set(h2,'FaceColor','b','EdgeColor','b');

set_curAX(figh,ax(7));
h=histogram(top_o100.flab,100);
set(h,'FaceColor','b','EdgeColor','b');

%% q10 without bound
load('q00100bot_summary_o100.mat');
set_curAX(figh,ax(2));
h=histogram(bot_o100.k2w./bot_o100.k2c,100);hold on;
set(h,'FaceColor',[.95,.95,.95]);
xlabel('Slow pool Q_{10}');

set_curAX(figh,ax(4));
h=histogram(bot_o100.k2c,100); hold on;
set(h,'FaceColor',[.95,.95,.95]);
xlabel('Slow pool k_2 at 10\circC (day^-^1)');

set_curAX(figh,ax(6));
h=histogram(bot_o100.k2w,100); hold on;
set(h,'FaceColor',[.95,.95,.95]);
xlabel('Slow pool k_2 at 20\circC (day^-^1)');


set_curAX(figh,ax(8));
h=histogram(bot_o100.flab,100); hold on;
set(h,'FaceColor',[.95,.95,.95]);
xlabel('Initial active pool fraction');
%%

load('q00004bot_summary_o100.mat');

set_curAX(figh,ax(2));hold on;
h2=histogram(bot_o100.k2w./bot_o100.k2c,100);
set(h2,'FaceColor','b','EdgeColor','b');

set_curAX(figh,ax(4));
h2=histogram(bot_o100.k2c,100);
set(h2,'FaceColor','b','EdgeColor','b');

set_curAX(figh,ax(6));hold on;
h2=histogram(bot_o100.k2w,100);
set(h2,'FaceColor','b','EdgeColor','b');


set_curAX(figh,ax(8));hold on;
h=histogram(bot_o100.flab,100);
set(h,'FaceColor','b','EdgeColor','b');


set(ax,'FontSize',16);
set_curAX(figh,ax(1));legend('IQ100','IQ4');title('Topsoil','FontSize',26);
set_curAX(figh,ax(2));title('Subsoil','FontSize',26);
set(ax,'box','on');

put_tag(figh,ax(1),[0.025,0.85],'a',24);
put_tag(figh,ax(2),[0.025,0.85],'b',24);
put_tag(figh,ax(3),[0.025,0.85],'c',24);
put_tag(figh,ax(4),[0.025,0.85],'d',24);
put_tag(figh,ax(5),[0.025,0.85],'e',24);
put_tag(figh,ax(6),[0.025,0.85],'f',24);
put_tag(figh,ax(7),[0.025,0.85],'g',24);
put_tag(figh,ax(8),[0.025,0.85],'h',24);
