gmt begin ../figures/bestJ pdf

gmt set FONT 18p,Helvetica,black
linew=3p 


gmt basemap -JX10c/5c -R1/450/0/1 -Bnesw
gmt plot ../data/relativeMSE_Class_Lmax90-bestJ100.txt -W${linew},black
gmt plot -Sc0.3c -W${linew},100 <<EOF
100 0.853 
EOF
gmt plot -N -W${linew},100 -Bya0.2g0.2 -Bxa100g50 -BneSW -Bx+l"number @[J@[ of Slepian functions" -By+l"relative mse"<<EOF
100 1
100 0.853
EOF
gmt text -N <<EOF
100 1.08 100
EOF
gmt text -R0/1/0/1 -N --FONT=30p <<EOF
-0.14 1.05 a
EOF
gmt text -N --FONT=25p <<EOF
0.5 1.15 classical
EOF

gmt basemap -X11c -JX10c/5c -R150/600/0/1 -Bnesw
gmt plot ../data/relativeMSE_ACSF_Lmax90-bestJ485.txt -W${linew},black
gmt plot -Sc0.3c -W${linew},100 <<EOF
485 0.405 
EOF
gmt plot -N -W${linew},100 -Bya0.2g0.2 -Bxa100g50 -BneSw -Bx+l"number @[J@[ of Slepian functions" -By+l"relative mse"<<EOF
485 1
485 0.405
EOF
gmt text -N <<EOF
485 1.08 485
EOF
gmt text -R0/1/0/1 -N --FONT=30p <<EOF
-0.04 1.05 b
EOF
gmt text -N --FONT=25p <<EOF
0.5 1.15 fixed
EOF


gmt basemap -X11c -JX10c/5c -R150/600/0/1 -Bnesw
gmt plot ../data/relativeMSE_VACSF_Lmax90-bestJ500.txt -W${linew},black
gmt plot -Sc0.3c -W${linew},100 <<EOF
500 0.2098 
EOF
gmt plot -N -W${linew},100 -Bya0.2g0.2 -Bxa100g50 -BneSw -Bx+l"number @[J@[ of Slepian functions" -By+l"relative mse"<<EOF
500 1
500 0.2098
EOF
gmt text -N <<EOF
500 1.08 500
EOF
gmt text -R0/1/0/1 -N --FONT=30p <<EOF
-0.04 1.05 c
EOF
gmt text -N --FONT=25p <<EOF
0.5 1.15 variable
EOF


gmt end show
