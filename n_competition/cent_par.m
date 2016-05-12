function Extra=cent_par(opt)
%sec  =1, opt=1
%day  = 86400, opt=2
%yr   = 365*86400, opt=3
if(nargin<1)
    opt=1;
end
par.rcn=[90   90   90     90,  13,  16, 7.9 ];
par.rcp=[4500 1600 2000 2500,  110, 320, 114];

switch opt
    case 1
        tscal=1;        
    case 2
        tscal=86400;
    case 3
        tscal=86400*365;
end
tau= [4.1 0.066 0.25 0.25 0.17 6.1 270].*86400*365./tscal;
par.kd=1./tau;

%sand=30
par.lit1_to_som1=0.45;
par.lit2_to_som1=0.5;
par.lit3_to_som2=0.5;
par.som1_to_som2=0.6235;
par.som1_to_som3=0.0025;
par.som2_to_som1=0.42;
par.som2_to_som3=0.03;
par.som3_to_som1=0.45;
par.cwd_to_lit2=0.76;
par.cwd_to_lit3=0.24;
par.lchn=1d-6*tscal*1;                                                             %removing rate of mineral nitrogen
par.lchp=1d-6*tscal*1;                                                             %removing rate of mineral phosphorus 
par.k_minn=1d-6;
par.k_minp=1d-6;
par.pct_mcb = 0d-6;


vid.cwd =1;vid.cwd_reac =1;
vid.lit1=2;vid.lit1_reac=2;
vid.lit2=3;vid.lit2_reac=3;
vid.lit3=4;vid.lit3_reac=4;
vid.som1=5;vid.som1_reac=5;
vid.som2=6;vid.som2_reac=6;
vid.som3=7;vid.som3_reac=7;
vid.minn=8;vid.minn_reac=8;
vid.minp=9;vid.minp_reac=9;
vid.nvars=9;
vid.ids=[vid.cwd,vid.lit1,vid.lit2,vid.lit3,vid.som1,vid.som2,vid.som3];
vid.lits=[vid.cwd,vid.lit1,vid.lit2,vid.lit3];
vid.soms=[vid.som1,vid.som2,vid.som3];
vid.nreacs=9;

Extra.par=par;
Extra.vid=vid;


end