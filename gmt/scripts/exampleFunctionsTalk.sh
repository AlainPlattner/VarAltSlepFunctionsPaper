gmt begin ../figures/exampleFunctionsTalk pdf

gmt set PS_PAGE_COLOR black
gmt set MAP_FRAME_PEN white

gmt set FONT 50p,Helvetica,white
titlesh=1.1
#labelsh=-0.15

gmt makecpt -Cvik -T-1/1


gmt grdimage -JG20/5/14c ../data/VarAltCog_L60_ind1.nc -C
gmt coast -Wblack -B -A100000 -Dc
gmt text -JX14c/14c -R0/1/0/1 -N <<EOF
0.5 ${titlesh} @%2%j = 1@%% 
EOF

gmt grdimage -X15c -JG20/5/14c ../data/VarAltCog_L60_ind100.nc -C
gmt coast -Wblack -B -A100000
gmt text -JX14c/14c -R0/1/0/1 -N <<EOF
0.5 ${titlesh} @%2%j = 100@%% 
EOF

gmt grdimage -X15c -JG20/5/14c ../data/VarAltCog_L60_ind200.nc -C
gmt coast -Wblack -B -A100000
gmt text -JX14c/14c -R0/1/0/1 -N <<EOF
0.5 ${titlesh} @%2%j = 200@%% 
EOF



gmt end show
