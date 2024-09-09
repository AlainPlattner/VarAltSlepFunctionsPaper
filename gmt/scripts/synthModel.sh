gmt begin ../figures/synthModel pdf

#gmt set MAP_POLAR_CAP none
#gmt set FONT_ANNOT_PRIMARY 20p,Helvetica,black
gmt set FONT 25p,Helvetica,black

lowlat=58
gmt basemap -JA0/90/14c -R0/360/${lowlat}/90 -Bnews
gmt makecpt -Cvik -T-4e5/4e5
gmt grdimage ../data/potential_true_Lmax90.nc -Ba30g10
gmt colorbar -D+w14c+jML+o-2.5c/7c+m -B+l"magnetic potential [Tm]" -W1e-9

gmt end show
