uncorrected azimuth, min -78 deg, max 356.7deg

![alttext](https://github.com/mbenko908/Inversion/blob/7d28a4bfd61d00073e394f87ebded97eb6f8c1b2/CaI_GRIS/azimuth.png)

After azimuth correction and rotate map (9deg) (first do correction and then do rotation)
centrum of az x/y (188/68), azimull(-74), theta(53.9deg)

![alttext](https://github.com/mbenko908/Inversion/blob/3d815a8f586b336b5bb7169b014bb55fb00f525a/CaI_GRIS/extrc.png)

tip.pro
alpha = 53.9, beta = 3.0
output vecd[3-8]
![alttext](https://github.com/mbenko908/Inversion/blob/f1fd30f3b14e9c26d3c1b69d93b072c3fd853ed2/CaI_GRIS/tip_fig.png)

sp.pro
theta 53.9, beta = 3.0
   OBSPARAM = {DATE_OBS:   '2016-06-20T10:57:16.000', $             ; !!!!
               XCEN:       765.5,                      $             ; !!!!
               YCEN:       -119.8,                     $             ; !!!!
               XARCS:      0.136,                   $
               YARCS:      0.134,                   $
               SCLKM:      98.6                       } 
physres
![alttext](https://github.com/mbenko908/Inversion/blob/bfb4568f98e15f3142e8daf28c9e198028d933a3/CaI_GRIS/fig.png)
