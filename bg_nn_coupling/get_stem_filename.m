function stem=get_stem_filename(indir)
%get stem of the filename

dat=ls(indir);
str=strsplit(dat,'.nc');
sstr=strsplit(str{1},'.h0');
stem=sstr{1};
end