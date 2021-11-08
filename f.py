import numpy as np;
N_time = 10;
N_window = 132;
N_lon =180;
N_lat = 90;

time =  ncread('data\pr_mon_GISS-E2-R_past_1000_850-1850_new2x2_maskocean_anom.nc','time');
% 180 90 132 10
pr =  ncread('data\pr_mon_GISS-E2-R_past_1000_850-1850_new2x2_maskocean_anom.nc','pr');
lat =  ncread('data\pr_mon_GISS-E2-R_past_1000_850-1850_new2x2_maskocean_anom.nc','lat');
lon =  ncread('data\pr_mon_GISS-E2-R_past_1000_850-1850_new2x2_maskocean_anom.nc','lon');


N_time = length(time); % 10 
N_window = size(pr,3); % 132
N_lon = length(lon); % 180
N_lat = length(lat); % 90

res = np.zeros( (N_lon, N_lat, 10000) );

for i in range(10000):
    # temp用于存放随机选出的10组数据
    temp = np.zeros( (N_lon, N_lat, N_time) );
    
    for j in range(N_time):
        # 生成 1-132 的随机数
        rand_num = randrange(N_window);
        temp[:,:,j] = pr[:,:,rand_num,j];
        
    % 10组数据做平均
    res[:,:,i] = np.mean(temp,3);

res(:,:,1)


