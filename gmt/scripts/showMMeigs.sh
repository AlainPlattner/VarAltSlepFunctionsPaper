#INPUT: offrad value
# ./showMMeigs.sh 0
# or 
#./showMMeigs.sh 100
#or
#./showMMeigs.sh 200

gmt begin ../figures/MMeigs-offrad$1 pdf

gmt set FONT 20p

gmt basemap -JX20c/7cl -R1/300/1e-11/5e-5 -Bx+l"Slepian function number j" -By+l"eigenvalue"
gmt plot ../data/MM/Vm_offrad${1}.txt -W2p,black,-- -l"variable"
gmt plot ../data/MM/Vm_fix_offrad${1}.txt -W2p,darkgray,.- -l"fixed"
gmt plot ../data/MM/Vm_classical_offrad${1}.txt -W2p,lightgray,. -l"classical"

gmt end show
