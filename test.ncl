a = ispan(1, 24, 1)
b = reshape(a, (/2,3,4/))
print(dimsizes(b))
print(b)
print("——————————————————————————————")

c = dim_rmvmean_n (b,0)
print(c)

print("——————————————————————————————")
d = dim_avg_n(b,0)
print(d)



