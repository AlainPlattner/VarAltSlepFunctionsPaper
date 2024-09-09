gmt begin ../figures/exampleFunctions pdf

gmt set FONT 25p,Helvetica,black
titlesh=1.15
labelsh=-0.15

gmt makecpt -Cvik -T-1/1


gmt grdimage -JG20/5/14c ../data/Classical_L60_ind1.nc -C
gmt coast -Wblack -B -A100000 -Dc
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 a
EOF
gmt text -N --FONT=50p <<EOF
0.5 ${titlesh} classical
EOF
gmt text -F+a90 -N --FONT=50p <<EOF
${labelsh} 0.5 @[j=1@[
EOF


gmt grdimage -Y-15c -JG20/5/14c ../data/Classical_L60_ind100.nc -C
gmt coast -Wblack -B -A100000
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 d
EOF
gmt text -F+a90 -N --FONT=50p <<EOF
${labelsh} 0.5 @[j=100@[
EOF

gmt grdimage -Y-15c -JG20/5/14c ../data/Classical_L60_ind200.nc -C
gmt coast -Wblack -B -A100000
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 g
EOF
gmt text -F+a90 -N --FONT=50p <<EOF
${labelsh} 0.5 @[j=200@[
EOF


gmt grdimage -Y+30c -X15c -JG20/5/14c ../data/AltCog_L60_ind1.nc -C
gmt coast -Wblack -B -A100000 -Dc
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 b
EOF
gmt text -N --FONT=50p <<EOF
0.5 ${titlesh} fixed
EOF

gmt grdimage -Y-15c -JG20/5/14c ../data/AltCog_L60_ind100.nc -C
gmt coast -Wblack -B -A100000
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 e
EOF

gmt grdimage -Y-15c -JG20/5/14c ../data/AltCog_L60_ind200.nc -C
gmt coast -Wblack -B -A100000
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 h
EOF



gmt grdimage -Y+30c -X15c -JG20/5/14c ../data/VarAltCog_L60_ind1.nc -C
gmt coast -Wblack -B -A100000 -Dc
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 c
EOF
gmt text -N --FONT=50p <<EOF
0.5 ${titlesh} variable
EOF

gmt grdimage -Y-15c -JG20/5/14c ../data/VarAltCog_L60_ind100.nc -C
gmt coast -Wblack -B -A100000
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 f
EOF

gmt grdimage -Y-15c -JG20/5/14c ../data/VarAltCog_L60_ind200.nc -C
gmt coast -Wblack -B -A100000
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=60p <<EOF
0.07 0.93 i
EOF



gmt end show
