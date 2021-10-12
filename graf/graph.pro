x=[1,2,3,4]
y=[2604,2340, 2409, 2224]
yer=[196,226,222,366.5]
;  y=[2565,2330, 2441, 2222]
;yer=[203,229,209,276]

;yp=[1199,1296,1092,1159]
;yper=[681,445,617,477]

yp=[1178, 1308, 1104, 1188]
yper=[681, 455, 583, 457]

device, decomposed = 0
;!p.front = 0
;!p.charsize = 1.5

aspect_ratio=1.0
xdimcm=20
ydimcm=25;xdimcm/aspect_ratio
fileout='graph_B.eps'
set_plot,'ps'
device,/encapsulated
device,/times
device,/isolatin1
device,/color,xsize=xdimcm,ysize=ydimcm,/portrait
device,bits=8,filename=fileout
loadct, 39
plot, x, y, xrange=[0,5], yr=[0,3000], psym = -4, XTITLE="Number of spectral line", YTITLE="Total magnetic field [Gauss]", TITLE = "Average of magnetic field", thick = 3

errplot, x, y-yer, y+yer, COLOR = 250, errorbar_thick = 3
;stop
oplot, x, yp, thick = 3, psym = -4
errplot, x, yp-yper, yp+yper, COLOR = 70, errorbar_thick = 3

xyouts, 4.1, 2500, "Umbra"
xyouts, 4.1, 1200, "Penumbra"
xyouts, 4000, 900, "Ca I", /DEVICE
xyouts, 7000, 900, "Fe I", /DEVICE
xyouts, 10300, 900, "Si I", /DEVICE
xyouts, 13300, 900, "He I", /DEVICE
;t = text(0.1, 0.5, "XX")

device, /close
set_plot,'ps'
device, /encapsulated
device,encapsulated=0
device, /close
set_plot,'x'

END
