gmt begin ../figures/orbitTalk pdf

gmt set PS_PAGE_COLOR black
gmt set MAP_FRAME_PEN white

lim=10000

#gmt basemap -JX14c/14c -R-${lim}/${lim}/-${lim}/${lim}
gmt plot ../data/Earth.txt -JX14c/14c -R-${lim}/${lim}/-${lim}/${lim} -W2p,150
gmt plot ../data/orbit.txt -W3p,white,-
gmt coast -X2.55c -Y2.55c -JG20/5/8.9c  -Rg -A100000 -Dc -G200 #-Wblack
gmt end show
