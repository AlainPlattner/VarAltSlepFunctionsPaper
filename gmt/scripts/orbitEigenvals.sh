gmt begin ../figures/orbitEigenvals pdf

lim=10000

col=120
gmt set FONT 23p,Helvetica,black
maxJ=405

#gmt basemap -JX14c/14c -R-${lim}/${lim}/-${lim}/${lim}
gmt plot ../data/Earth.txt -JX14c/14c -R-${lim}/${lim}/-${lim}/${lim} 
gmt plot ../data/orbit.txt -W3p,100,-
gmt coast -X2.55c -Y2.55c -JG20/5/8.9c  -Rg -A100000 -Dc -G200 #-Wblack
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=40p <<EOF
0.0 0.75 a
EOF


gmt basemap -X14.5c -Y2c -Bya1pf1 -JX16c/8cl -R1/${maxJ}/0.7e-9/1e-5 -BnSWe -Bx+l"eigenvalue number @[j@[" -By+l"eigenvalue  @[\lambda_j@[" -By1e1 #-R1/3721/0/1e-6
gmt plot ../data/AltCog_L60_eigenvalues.txt -W2p,black   -l"fixed" 
gmt plot ../data/VarAltCog_L60_eigenvalues.txt -W2p,black,- -l"variable" 
gmt legend -DjBL+o0c/0.9c
gmt set FONT_ANNOT ${col}/${col}/${col}
gmt set FONT_LABEL ${col}/${col}/${col}
gmt basemap -JX16c/8cl -R1/${maxJ}/0.7e-4/1e0 -BE  -Bya1pf1 -By+l"eigenvalue @[\lambda_j@["
gmt plot ../data/Classical_L60_eigenvals.txt  -W2p,${col},-. -l"classical" 
gmt legend -DjBL
gmt set FONT_ANNOT black
gmt text -JX16c/8c -R0/1/0/1 -N --FONT=40p <<EOF
-0.16 1.05 b
EOF



gmt end show
