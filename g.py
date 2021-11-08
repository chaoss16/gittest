import numpy as np;
a = np.arange(12).reshape(3,4);
b = np.zeros( (3,4,2) );
b[:,:,0] = a; b[:,:,1] = a;
# print(b);
c = np.zeros( (3,4,2,10) );
for i in range(10):
    c[:,:,:,i] = b
print(c);


import numpy as np;
import random as rd;
N_time = 10;
N_window = 2;
N_lon = 3;
N_lat = 4;

# time =  ncread('data\pr_mon_GISS-E2-R_past_1000_850-1850_new2x2_maskocean_anom.nc','time');
# % 180 90 132 10
# pr =  ncread('data\pr_mon_GISS-E2-R_past_1000_850-1850_new2x2_maskocean_anom.nc','pr');
# lon =  ncread('data\pr_mon_GISS-E2-R_past_1000_850-1850_new2x2_maskocean_anom.nc','lon');
# lat =  ncread('data\pr_mon_GISS-E2-R_past_1000_850-1850_new2x2_maskocean_anom.nc','lat');

# N_time = length(time); % 10 
# N_window = size(pr,3); % 132
# N_lon = length(lon); % 180
# N_lat = length(lat); % 90

res = np.zeros( (N_lon, N_lat, 10000) );

for i in range(10000):
    # temp用于存放随机选出的10组数据
    temp = np.zeros( (N_lon, N_lat, N_time) );
    
    for j in range(N_time):
        # 生成 1-132 的随机数
        rand_num = rd.randrange(N_window);
        temp[:,:,j] = c[:,:,rand_num,j];
        
    # 10组数据做平均
    res[:,:,i] = np.mean(temp,2);

print (res[:,:,9999] );