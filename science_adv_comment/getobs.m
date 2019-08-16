function obs=getobs(obsf)

matfldir='./one_bug_model/mat_files/Incubation';


if(strcmpi(obsf,'OBS75'))
    iofile=[matfldir,'/Incubator_obs075.mat'];
elseif(strcmpi(obsf,'OBS100')) 
    iofile=[matfldir,'/Incubator_obs100.mat'];    
elseif(strcmpi(obsf,'OBS75TOP'))
    iofile=[matfldir,'/Incubator_obs075top.mat'];
elseif(strcmpi(obsf,'OBS100TOP'))
    iofile=[matfldir,'/Incubator_obs100top.mat'];       
end
load(iofile,'obs');


end