restore,'results_rot_new.save'

sz=size(physres)
nx = sz[1]
ny = sz[2]

scalex=0.29; arcsec/pix
scaley=0.32; arcsec/pix

x = findgen(sz[1]) * scalex ;scale of x
y = findgen(sz[2]) * scaley; scale of y

;asp = float(sz[2]) / sz[1] ;
asp = 0.2
asp2 = 0.5 ;1.95

;width = 15                      ;28.24 is for 800pix
;height = width * asp2
height = 30
width = 7;height * asp


xs  = 0.25;0.2
ys  =0.12112956;2.* xs / nx * ny / height * width
;ys = 0.33
;xs = ys / nx * ny / height * width /3

xs2=0.1 
ys2 =0.035

x0 = 0.3 
y0 = 0.1
;
y_col= 0.015
y_text = 0.01
;
y1=y0+ys+ys2
y2= y1 + y_col
y3= y2 + y_text

;sh = 0.09

angstrom = STRING(197B)
set_plot, 'ps'

device, BITS_PER_PIXEL=8, /CMYK, /COLOR, /ENCAPSULATED, $
    FILENAME='fig03_newfe.eps', /ISOLATIN1, LANGUAGE_LEVEL=2, XOFFSET=0, $
XSIZE=3*width, YOFFSET=0, YSIZE=height

device, /ITALIC, FONT_INDEX=20, /TIMES

XYOUTS, 0.02, 0.48, ['!7y [Mm]'], ORIENTATION=90, charsize=1., /NORMAL ; name of y axis
;XYOUTS, 0.42, 0.11, ['!7x [Mm]'], charsize=1., /NORMAL

ax = 48;
ay = 242                        ;
axy = 242-48 + 1
a0 = 0  ;
a1 = -(ax-ay)*0.22;0.220;
b1 = 0            ;
b2 = 301*0.220;

c = physres[*,*,4] gt 550

; 1. fig
r_min = -3100
r_max = 3100

loadct, 39, /SILENT
tvscl, physres[*,ax:ay,9]>(r_min)<(r_max),/NORM, x0, y0, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x0, y0, x0+xs, y0+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max, $
      xrange = [a0,a1], yrange = [b1,b2]
     
loadct, 0
contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x0, y0, x0+xs, y0+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta
loadct,39
;contour, physres[*,ax:ay,9], findgen(nx), findgen(axy), $
;    C_COLOR=[70], /NOERASE, /NORM,  LEVELS=[1867], POSITION=[x0, y0, x0+xs, y0+ys], $
;    XSTYLE=5, YSTYLE=5, THICK=5

contour, c[*,ax:ay], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x0, y0, x0+xs, y0+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

colorbar_charsize=1.
colorbar,position=[x0, y1, x0 + xs, y1 + y_col],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, 0.52, 0.01, ['!7x [Mm]'], charsize=1., /NORMAL, alignment=0.5  	 ; name of x axis
XYOUTS, x0 + xs*0.52, y3, ['!7 B!Dz!n component of the magnetic field [Gauss]'], charsize=1., /NORMAL, alignment=0.5 

;2. fig
y4 = y3 + ys2
y5 = y4 + ys + ys2
y6 = y5 + y_col
y7 = y6 + y_text

r_min = -2000
r_max = 2000

loadct, 39, /SILENT
tvscl, physres[*,ax:ay,8]>(r_min)<(r_max),/NORM, x0, y4, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x0, y4, x0+xs, y4+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max, $
     xrange = [a0,a1], yrange = [b1,b2]

contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x0, y4, x0+xs, y4+ys], $
    XSTYLE=5, YSTYLE=5, THICK=5;zlta

contour, c[*,ax:ay], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x0, y4, x0+xs, y4+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

colorbar_charsize=1.
colorbar,position=[x0, y5, x0 + xs, y5 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x0 + xs*0.52, y7, ['!7 B!Dy!n component of the magnetic field [Gauss]'], charsize=1., /NORMAL, alignment=0.5 

;3. fig
y8 = y7  +ys2
y9 = y8+ys+ys2
y10 = y9 + y_col
y11 = y10 + y_text

r_min = -2000
r_max = 2000

loadct, 39, /SILENT
tvscl, physres[*,ax:ay,7]>(r_min)<(r_max),/NORM, x0, y8, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x0, y8, x0+xs, y8+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max, $
      xrange = [a0,a1], yrange = [b1,b2]

contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x0, y8, x0+xs, y8+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

contour, c[*,ax:ay], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x0, y8, x0+xs, y8+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

colorbar_charsize=1.
colorbar,position=[x0, y9, x0 + xs, y9 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x0 + xs*0.52, y11, ['!7 B!Dx!n component of the magnetic field [Gauss]'], charsize=1., /NORMAL, alignment=0.5 

;4. fig
y12 = y11  +ys2
y13 = y12+ys+ys2
;y10 = y9 + y_col
;y11 = y10 + y_text

;r_min = -1500
;r_max = 1500

loadct, 0, /SILENT
tvscl, physres[*,ax:ay,0],/NORM, x0, y12, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x0, y12, x0+xs, y12+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max, $
      xrange = [a0,a1], yrange = [b1,b2]

contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x0, y12, x0+xs, y12+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

contour, c[*,ax:ay], findgen(nx), findgen(axy), $
    C_COLOR=[90], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x0, y12, x0+xs, y12+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

loadct,39
contour, physres[*,ax:ay,9], findgen(nx), findgen(axy), $
    C_COLOR=[90], /NOERASE, /NORM,  LEVELS=[1867], POSITION=[x0, y12, x0+xs, y12+ys], $
    XSTYLE=5, YSTYLE=5, THICK=5

;colorbar_charsize=1.
;colorbar,position=[x0, y9, x0 + xs, y9 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
;XYOUTS, 0.52, y11, ['!7 Bx [Gauss]'], charsize=1., /NORMAL, alignment=0.5 

;2. column

x1 = x0  + xs + xs2

; 1. fig
r_min = 0.
r_max = 360.

loadct, 40, /SILENT
tvscl, physres[*,ax:ay,6]>(r_min)<(r_max),/NORM, x1, y0, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x1, y0, x1+xs, y0+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max, $
      xrange = [a0,a1], yrange = [b1,b2]

loadct,0
contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y0, x1+xs, y0+ys], $
    XSTYLE=5, YSTYLE=5, THICK=5;zlta

contour, c[*,ax:ay], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y0, x1+xs, y0+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

loadct,39
colorbar_charsize=1.
colorbar,position=[x1, y1, x1 + xs, y1 + y_col],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
;XYOUTS, 0.52, 0.01, ['!7x [Mm]'], charsize=1., /NORMAL, alignment=0.5  	 ; name of x axis
XYOUTS, x1+xs*0.52, y3, ['!7 Azimut [degrees]'], charsize=1., /NORMAL, alignment=0.5 

;2. fig

r_min = 0.
r_max = 180.

loadct, 39, /SILENT
tvscl, physres[*,ax:ay,5]>(r_min)<(r_max),/NORM, x1, y4, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x1, y4, x1+xs, y4+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max, $
      xrange = [a0,a1], yrange = [b1,b2]

contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y4, x1+xs, y4+ys], $
    XSTYLE=5, YSTYLE=5, THICK=5;zlta

contour, c[*,ax:ay], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y4, x1+xs, y4+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

colorbar_charsize=1.
colorbar,position=[x1, y5, x1 + xs, y5 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x1 + xs*0.52, y7, ['!7 Inclination [degrees]'], charsize=1., /NORMAL, alignment=0.5 

;3. fig

;r_min = 0.
;r_max = 3200.

;loadct, 39, /SILENT
;tvscl, physres[*,ax:ay,4]>(r_min)<(r_max),/NORM, x1, y8, XSIZE=xs, YSIZE=ys

;plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
;    POSITION=[x1, y8, x1+xs, y8+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
;    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
;     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_;VALUE = r_max, $
;     xrange = [a0,a1], yrange = [b1,b2]

;contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
;    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y8, x1+xs, y8+ys];, $
 ;        XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

;contour, c[*,ax:ay], findgen(nx), findgen(axy), $
;    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y8, x1+xs, y8+ys];, $
;         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

;colorbar_charsize=1.
;colorbar,position=[x1, y9, x1 + xs, y9 + y_col ],range=[r_min,r_max],divisions=4;,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
;XYOUTS, x1 + xs*0.52, y11, ['!7 Total field strength [Gauss]'], charsize=1., /NO;RMAL, alignment=0.5 

;4. fig

r_min = -3000
r_max = 3000

loadct, 39, /SILENT
tvscl, physres[*,ax:ay,4]>(r_min)<(r_max),/NORM, x1, y8, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x1, y8, x1+xs, y8+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max, $
     xrange = [a0,a1], yrange = [b1,b2]

contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y8, x1+xs, y8+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

contour, c[*,ax:ay], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y8, x1+xs, y8+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

colorbar_charsize=1.
colorbar,position=[x1, y9, x1 + xs, y9 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x1 + xs*0.52, y9+y_text+y_col, ['!7 Btot [G]'], charsize=1., /NORMAL, alignment=0.5 
;3.column

;x2 = x1  + xs + xs2

; 1. fig
;r_min = -1.
;r_max = 1.

;loadct, 39, /SILENT
;tvscl, physres[*,*,10]>(r_min)<(r_max),/NORM, x2, y0, XSIZE=xs, YSIZE=ys

;plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
;    POSITION=[x2, y0, x2+xs, y0+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
;    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
;    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max

;contour, physres[*,*,0], findgen(nx), findgen(ny), $
;    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x2, y0, x2+xs, y0+ys], $
 ;   XSTYLE=5, YSTYLE=5, THICK=5;zlta

;colorbar_charsize=1.
;colorbar,position=[x2, y1, x2 + xs, y1 + y_col],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(f5.2)'
;XYOUTS, 0.52, 0.01, ['!7x [Mm]'], charsize=1., /NORMAL, alignment=0.5  	 ; name of x axis
;XYOUTS, x2+xs*0.52, y3, ['!7 vertical deriv. of the vert. comp [Gauss km!u-1!n]'], charsize=1., /NORMAL, alignment=0.5 

;2. fig

;r_min = -75.
;r_max = 75.

;loadct, 39, /SILENT
;tvscl, physres[*,*,11]>(r_min)<(r_max),/NORM, x2, y4, XSIZE=xs, YSIZE=ys

;plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
;    POSITION=[x2, y4, x2+xs, y4+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
;    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
;    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max

;contour, physres[*,*,0], findgen(nx), findgen(ny), $
;    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x2, y4, x2+xs, y4+ys], $
;    XSTYLE=5, YSTYLE=5, THICK=5;zlta

;colorbar_charsize=1.
;colorbar,position=[x2, y5, x2 + xs, y5 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
;XYOUTS, x2 + xs*0.52, y7, ['!7 Vertical current densities [mA m!u-2!n]'], charsize=1., /NORMAL, alignment=0.5 

;3. fig

;r_min = -1.
;r_max = 1.

;loadct, 39, /SILENT
;tvscl, physres[*,*,20]>(r_min)<(r_max),/NORM, x2, y8, XSIZE=xs, YSIZE=ys

;plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
;    POSITION=[x2, y8, x2+xs, y8+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
;    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
;    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max

;contour, physres[*,*,0], findgen(nx), findgen(ny), $
;    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x2, y8, x2+xs, y8+ys], $
;    XSTYLE=5, YSTYLE=5, THICK=5;zlta

;colorbar_charsize=1.
;colorbar,position=[x2, y9, x2 + xs, y9 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
;XYOUTS, x2 + xs*0.52, y11, ['!7 Helicity [Gauss!u2!n m!u-1!n]'], charsize=1., /NORMAL, alignment=0.5 

;4. fig


r_min = -2
r_max = 2

loadct, 39, /SILENT

a = physres[*,*,3]/1000.

;tvscl, a[*, ax:ay],/NORM, x1, y8, XSIZE=xs, YSIZE=ys
tvscl, a[*, ax:ay],/NORM, x1, y12, XSIZE=xs, YSIZE=ys
plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x1, y12, x1+xs, y12+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max,  $
      xrange = [a0,a1], yrange = [b1,b2]

contour, physres[*,ax:ay,0], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y12, x1+xs, y12+ys], $
    XSTYLE=5, YSTYLE=5, THICK=5;zlta

contour, c[*,ax:ay], findgen(nx), findgen(axy), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x1, y12, x1+xs, y12+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

colorbar_charsize=1.
colorbar,position=[x1, y12+ys + y_col+0.01, x1 + xs, y12 + ys + y_col + y_text+0.01 ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x1 + xs*0.52, y12 + y_col + ys + y_text + 0.015, ['!7 Doppler velocity [km s!u-1!n]'], charsize=1., /NORMAL, alignment=0.5 

device, /CLOSE
set_plot, 'x'

end
