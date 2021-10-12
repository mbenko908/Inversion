x=[1,2,3,4]
;y=[20.92,25.88, 22.6, 25.97]
;yer=[8.76, 7.35, 7.89, 11.31]

;yp=[56.94, 64.43, 50.79, 53.73]
;yper=[30.64, 16, 25.19, 18.59]

y=[16.5, 26,22.2, 21.9]
yer = [6,7.7, 7.7, 12.7]

yp=[50.9, 62.25, 49.5, 53.2]
yper=[30.5, 17.93, 22.53, 18.12]
device, decomposed = 0
;!p.front = 0
;!p.charsize = 1.5

aspect_ratio=1.0
xdimcm=20
ydimcm=25;xdimcm/aspect_ratio
fileout='graph_inc.eps'
set_plot,'ps'
device,/encapsulated
device,/times
device,/isolatin1
device,/color,xsize=xdimcm,ysize=ydimcm,/portrait
device,bits=8,filename=fileout
loadct, 39
plot, x, y, xrange=[0,5], yr=[0,90], psym = -4, XTITLE="Number of spectral line", YTITLE="Inclination [Degrees]", TITLE = "Average of inclination", thick = 3

errplot, x, y-yer, y+yer, COLOR = 250, errorbar_thick = 3

oplot, x, yp,  thick = 3, psym = -4
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
