function [rgs,pes,rCO2,rds,mobXs]=micbphysiology(x,extra)
%micbphysiology(x,extra)
%do microbial physiology 
%Jinyun Tang: jinyuntang@lbl.gov
%central dogma
%DNA->RNA-> protein
%transcription: DNA-> mRNA (RNA polymerease)
%translation: mRNA->protein
%protein sends signal to ribosome, which does transcription
%return variable:
%rgs: specific structural growth
%pes: specific enzyme production
%rms: CO2 cost for specific respiration
%rCO2: total specific CO2 cost, for maintenance, growth and enzyme
%production
%mobX: reserve mobilization
vid=extra.vid;
micb=extra.micb;
nB=numel(vid.micBV);
rgs=zeros(nB,1);  %normalized growth of structural biomass
pes=zeros(nB,1);  %normalzied production of exoenzyme
%rms=zeros(nB,1);
rCO2=zeros(nB,1);
rds=zeros(nB,1);  %normalized starvation induced mortality
mobXs=zeros(nB,1);
for jj = 1 : nB
    %potenial reserve flux excess
    xe=x(vid.micBX(jj))/x(vid.micBV(jj));
    rd=0.0;
    if(micb.mic_ho(jj)*xe<micb.mic_m(jj))
        %mobilized reserve flux is insufficient for maintenance
        
        %electron acceptor is limiting?
        if(micb.mic_h(jj)*xe<micb.mic_m(jj))
            %no
            fprintf('structural biomass is shrinked to support maintenance\n');
            rg=-(micb.mic_m(jj)-micb.mic_h(jj)*xe)...
                /(xe+extra.mic_yldVm(jj));   
            %total amount of respired CO2 for maintenance
            rmCO2=(micb.mic_ho(jj)-rg)*xe-rg; 
            mobX=(micb.mic_ho(jj)-rg)*xe;          
            
        else
            fprintf('yes, then cells are killed.\n');
            rd=-(micb.mic_ho(jj)*xe-micb.mic_m(jj)); %>0
            %amount of CO2 respired for maintenance
            rmCO2=micb.mic_ho(jj)*xe; 
            mobX=rmCO2;
            rg=0.0;
        end
        rgCO2=0.;
        pe=0.0;peCO2=0.;
        
    else
        fprintf('active growth is allowed\n');
        rg=(micb.mic_ho(jj)*xe-micb.mic_m(jj))...
            /(xe+(1.0+micb.mic_ea(jj))/extra.mic_YldV(jj));
        pe=rg/extra.mic_YldV(jj)*extra.mic_YldE(jj);
        rmCO2=micb.mic_m(jj);
        rgCO2=rg*(1./extra.mic_YldV(jj)-1.0);
        peCO2=pe*(1./extra.mic_YldE(jj)-1.0);
        mobX=(micb.mic_ho(jj)-rg)*xe;
    end
    rgs(jj)=rg;
    pes(jj)=pe;
%    rms(jj)=rm;
    rCO2(jj)=rmCO2+rgCO2+peCO2;
    rds(jj)=rd;
    mobXs(jj)=mobX;
    fprintf('mobX=%e,rmCO2=%e,rgCO2=%e,peCO2=%e,rg=%e,pe=%e\n',mobX,rmCO2,rgCO2,peCO2,rg,pe);
    fprintf('mr=%e,err=%e\n',micb.mic_m(jj),-mobX+rmCO2+rgCO2+peCO2+rg+pe);
end
end