gmt begin ../figures/dataloc pdf

#gmt set MAP_POLAR_CAP None
#gmt set FONT_ANNOT_PRIMARY 20p,Helvetica,black
gmt set FONT 25p,Helvetica,black

# Polar plot
lowlat=58
gmt basemap -JA0/90/14c -R0/360/${lowlat}/90 -Bnesw
gmt makecpt -Cimola -I -T245/400
gmt plot ../data/dataloc_reducealt200.txt -Ba30g10 -C -Sc0.1c
#gmt colorbar -D+h+w14c+jBC+o7c/-1.5c -B50+l"altitude [km]"
gmt colorbar -D+w14c+jML+o-2.5c/7c+m -B50+l"altitude [km]"
gmt text -JX14c/14c -R0/1/0/1 -N --FONT=50p <<EOF
0 1 a
EOF


# Alt
gmt basemap -X16c -Y2c -JX-20c/10c -R60/85/245/400 -Bnesw 
gmt plot ../data/varalt_reducealt200.txt -i0,1,1 -Sc0.1c -C # -Sp0.1c -G150
gmt plot ../data/varaltFunction_reducealt200.txt  -W8p,black,- -Bxa10g5 -Bya50g25 -BnESw -Bx+l"latitude [@[^\circ@[]" -By+l"altitude [km]"
gmt text -R0/1/0/1 -N --FONT=50p <<EOF
1 1.2 b
EOF


gmt end show
