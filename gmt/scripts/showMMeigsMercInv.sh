

gmt begin ../figures/MMeigsMercInv pdf

gmt set FONT 20p

gmt basemap -JX20c/7cl -R1/10000/2e-25/2e-1 -Bx+l"Slepian function number j" -By+l"eigenvalue"
gmt plot ../data/MercInvEig/Vinv_var.txt -W2p,black,-- -l"variable"
gmt plot ../data/MercInvEig/Vinv_fix.txt -W2p,darkgray,.- -l"fixed"
gmt plot ../data/MercInvEig/Vinv_classical.txt -W2p,lightgray,. -l"classical"

gmt end show
