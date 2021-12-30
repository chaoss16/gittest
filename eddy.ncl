;*************************************************
; NCL Graphics: polar_1.ncl
;
; Concepts illustrated:
;   - Drawing black-and-white contours over a polar stereographic map
;   - Drawing the northern hemisphere of a polar stereographic map
;
;************************************************
;
; These files are loaded by default in NCL V6.2.0 and newer
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_code.ncl"
; load "$NCARG_ROOT/lib/ncarg/nclscripts/csm/gsn_csm.ncl" 


begin

; read in netCDF file
f = addfile("hgt.2020.nc","r")

;print(f)
print("————————————————————————————————————————")
;list_filevars(f)
print("————————————————————————————————————————")
;printVarSummary(f)
print("————————————————————————————————————————")


;l = f->level                                
;l(5)不是整数？？
;print(l(5))

print("————————————————————————————————————————")
;500hPa位势高度场
hgt = f->hgt(:, 5, :, :)
print(dimsizes(hgt))  ;size:366 73 144

print("————————————————————————————————————————")
;选取时间范围为2020年冬季1、2月
hgt12 = hgt(0:59,:,:)
print(dimsizes(hgt12))

print("————————————————————————————————————————")
;纬偏值（减去纬向平均） size:60 73 144 
;无法画图，因为需要用wrap返回修改后的原始数据
; hgt12_zm = dim_rmvmean_n(hgt12,2)
; print(dimsizes(hgt12_zm))
; print(hgt12_zm(:,1,1)

print("————————————————————————————————————————")
;计算纬偏值（减去纬向平均） size: days(60),lat(73),lon(144) 
hgt12_zm = dim_rmvmean_n_Wrap(hgt12, 2)
print(dimsizes(hgt12_zm))

print("————————————————————————————————————————")
;定常涡旋：纬偏值的时间平均（2020年1、2月,共60天）
eddy_stationary = dim_avg_n_Wrap(hgt12_zm,0)
print(dimsizes(eddy_stationary))

;瞬变涡旋：瞬时纬偏值
eddy_transient = dim_rmvmean_n_Wrap(hgt12, 0)
print(dimsizes(eddy_transient))


;画图
  wks = gsn_open_wks("png","eddy_stationary")              ; send graphics to PNG file
  res            = True                          ; plot mods desired
  res@gsnPolar   = "NH"                          ; specify the hemisphere
  plot = gsn_csm_contour_map_polar(wks,eddy_stationary,res)    ; create the plot

  wks = gsn_open_wks("png","eddy_transient")          
  res            = True                          
  res@gsnPolar   = "NH"                        
  plot = gsn_csm_contour_map_polar(wks,eddy_transient(0,:,:),res)    
end
