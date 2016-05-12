function ratio=normalized_std2mean_ratio(dat_std,dat_mean)

ratio=dat_std./(dat_std+abs(dat_mean));

end