function incubator=get_incubation(Ms,x_locstr)
author_print();

%%
matfldir='./one_bug_model/mat_files/Incubation';
if (strcmpi(x_locstr,'UPPER'))
    name=['Ms',num2str(Ms),'_days330_upper'];
elseif(strcmpi(x_locstr,'MIDDLE'))
    name=['Ms',num2str(Ms),'_days330_middle'];
elseif(strcmpi(x_locstr,'DOWN'))
    name=['Ms',num2str(Ms),'_days330_down'];
elseif(strcmpi(x_locstr,'LAST'))
    name=['Ms',num2str(Ms),'_days330_last'];
end
iofile=[matfldir,'/Incubator_',name,'.mat'];
load(iofile,'incubator');

end