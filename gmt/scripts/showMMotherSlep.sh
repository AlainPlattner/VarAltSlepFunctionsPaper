#INPUT
#otherslep name: Either 'classical' or 'fix'

if [ $1 = 'classical' ]
then
    rng=1e-8/5e0
else
    rng=1e-11/5e-5
fi



gmt begin ../figures/MM_$1 pdf

gmt set FONT 20p

gmt grd2cpt ../data/MM/MM_$1_offrad0.grd -Cvik -Sl

gmt grdimage ../data/MM/MM_$1_offrad0.grd -JX10c/-10c -R1/300/1/300 -Bx+l"Slepian function number j" -By+l"Slepian function number j" -BNesW
gmt text <<EOF
230 20 @[r_\mathrm{rand} = 0@[ km
EOF
gmt text -N --FONT=30p <<EOF
5 -25 a
EOF

gmt grdimage ../data/MM/MM_$1_offrad100.grd -X11c -Bx+l"Slepian function number j" -By+l"Slepian function number j" -BNesw
gmt text -N <<EOF
220 20 @[r_\mathrm{rand} = 100@[ km
EOF
gmt text -N --FONT=30p <<EOF
5 -25 b
EOF

gmt grdimage ../data/MM/MM_$1_offrad200.grd -X11c -Bx+l"Slepian function number j" -By+l"Slepian function number j" -BNEsw
gmt text -N <<EOF
220 20 @[r_\mathrm{rand} = 200@[ km
EOF
gmt text -N --FONT=30p <<EOF
5 -25 c
EOF

gmt colorbar -D+w26c/0.5c+o-19c/-1c+h+e -B+l"matrix entry value" --FONT=16p


## Next: Plot the diagonal elements of V and of MM
colV=160/160/160

gmt basemap -X-15c -Y-10.5c -JX20c/7cl -R1/300/$rng -Bx+l"Slepian function number j" -By+l"matrix diagonal entry"
gmt plot ../data/MM/MM_$1-diag_offrad0.txt -W2p,black,.- -l"@[r_\mathrm{rand}  = 0@[ @[\mathrm{km}@["
gmt plot ../data/MM/MM_$1-diag_offrad100.txt -W2p,black,-- -l"@[r_\mathrm{rand} = 100@[ @[\mathrm{km}@["
gmt plot ../data/MM/MM_$1-diag_offrad200.txt -W2p,black,. -l"@[r_\mathrm{rand} = 200@[ @[\mathrm{km}@["
gmt plot  ../data/MM/V_$1.txt  -W2p,${colV} -l"eigenvalues"

if [ $1 = 'classical' ]
then
    gmt legend -DjCL+o0c/0.5c
else
    gmt legend -DjBL
fi
# gmt text -R0/1/0/1 -JX20c/7c -F+a90 -N <<EOF 
# -0.2 0.5 eigenvalue or 
# -0.15 0.5 @[\bf MM^\top@[ diagonal entry
# EOF
gmt text -R0/1/0/1 -JX20c/7c -N --FONT=30p <<EOF
-0.17 1 d
EOF

gmt end show
