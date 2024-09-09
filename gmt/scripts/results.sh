gmt begin ../figures/results pdf

#gmt set MAP_POLAR_CAP none
#gmt set FONT_ANNOT_PRIMARY 20p,Helvetica,black
gmt set FONT 25p,Helvetica,black
lowlat=58
#regionpen=5p,black,-
#regionpen1=6p,80
#regionpen2=2p,200
regionpen1=3p,80
regionpen2=1p,green

gmt makecpt -Cvik -T-4e5/4e5

gmt basemap -JA0/90/14c -R0/360/${lowlat}/90 -Bnews
gmt grdimage ../data/Class_opt_Lmax90.nc -Ba30g10
gmt plot ../data/smallcap6.txt -W${regionpen1}
gmt plot ../data/smallcap6.txt -W${regionpen2}
gmt plot ../data/largecap29.txt -W${regionpen1}
gmt plot ../data/largecap29.txt -W${regionpen2}
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
0 1 a
0.5 1.15 classical
EOF
gmt text -F+a90 -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
-0.15 0.5 model
EOF

gmt basemap -X16.5c -JA0/90/14c -R0/360/${lowlat}/90 -Bnews
gmt grdimage ../data/ACSF_opt_Lmax90.nc -Ba30g10
gmt plot ../data/smallcap6.txt -W${regionpen1}
gmt plot ../data/smallcap6.txt -W${regionpen2}
gmt plot ../data/largecap29.txt -W${regionpen1}
gmt plot ../data/largecap29.txt -W${regionpen2}
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
0 1 b
0.5 1.15 fixed
EOF


gmt basemap -X16.5c -JA0/90/14c -R0/360/${lowlat}/90 -Bnews
gmt grdimage ../data/VACSF_opt_Lmax90.nc -Ba30g10
gmt plot ../data/smallcap6.txt -W${regionpen1}
gmt plot ../data/smallcap6.txt -W${regionpen2}
gmt plot ../data/largecap29.txt -W${regionpen1}
gmt plot ../data/largecap29.txt -W${regionpen2}
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
0 1 c
0.5 1.15 variable
EOF

gmt colorbar  -B+l"magnetic potential [Tm]" -W1e-9 -D+jCB+w35c/0.5c+h+o-9.5c/-2c 

# Error

gmt makecpt -Clajolla -T-5/-3.5  #-T4/5.6
gmt basemap -X-33c -Y-20c -JA0/90/14c -R0/360/${lowlat}/90 -Bnews
gmt grdmath ../data/Class_err_Lmax90.nc ABS LOG10 9 SUB  = field.nc
gmt grdimage field.nc -Ba30g10
rm field.nc
gmt plot ../data/smallcap6.txt -W${regionpen1}
gmt plot ../data/smallcap6.txt -W${regionpen2}
gmt plot ../data/largecap29.txt -W${regionpen1}
gmt plot ../data/largecap29.txt -W${regionpen2}
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
0 1 d
EOF
gmt text -F+a90 -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
-0.15 0.5 error
EOF


gmt makecpt -Clajolla -T-5/-3.5  #-T4/5.6
gmt basemap -X16.5c -JA0/90/14c -R0/360/${lowlat}/90 -Bnews
gmt grdmath ../data/ACSF_err_Lmax90.nc ABS LOG10 9 SUB  = field.nc
gmt grdimage field.nc -Ba30g10
rm field.nc
gmt plot ../data/smallcap6.txt -W${regionpen1}
gmt plot ../data/smallcap6.txt -W${regionpen2}
gmt plot ../data/largecap29.txt -W${regionpen1}
gmt plot ../data/largecap29.txt -W${regionpen2}
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
0 1 e
EOF


gmt basemap -X16.5c -JA0/90/14c -R0/360/${lowlat}/90 -Bnews
gmt grdmath ../data/VACSF_err_Lmax90.nc ABS LOG10 9 SUB = field.nc
gmt grdimage field.nc -Ba30g10
rm field.nc
gmt plot ../data/smallcap6.txt -W${regionpen1}
gmt plot ../data/smallcap6.txt -W${regionpen2}
gmt plot ../data/largecap29.txt -W${regionpen1}
gmt plot ../data/largecap29.txt -W${regionpen2}
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
0 1 f
EOF

gmt colorbar  -B+l"log10 of magnetic potential absolute misfit" -D+jCB+w35c/0.5c+h+o-9.5c/-2c 


gmt end show
