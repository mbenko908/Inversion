x=[1,2,3,4]
;y=[2366.5, 2072.99, 2231.54, 1966.38]
;yer=[291.16, 253.16, 285.93, 376]

;yp=[646.9, 612.63, 596.4, 691.16]
;yper=[663.49, 509, 513.95, 563.95]

y = [2478, 2066, 2208, 2052]
yer = [232, 174, 289, 432]

yp=[605, 643, 635, 731]
yper=[678, 521, 488, 504]
device, decomposed = 0
;!p.front = 0
;!p.charsize = 1.5

aspect_ratio=1.0
xdimcm=20
ydimcm=25;xdimcm/aspect_ratio
fileout='graph_Bz.eps'
set_plot,'ps'
device,/encapsulated
device,/times
device,/isolatin1
device,/color,xsize=xdimcm,ysize=ydimcm,/portrait
device,bits=8,filename=fileout
loadct, 39
plot, x, y, xrange=[0,5], yr=[-1000,3000], psym = -4, XTITLE="Number of spectral line", YTITLE="B!Dz!n component of the magnetic field [Gauss]", TITLE = "Average of B!Dz!n component of the magnetic field", thick = 3

errplot, x, y-yer, y+yer, COLOR = 250, errorbar_thick = 3

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
