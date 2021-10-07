; create eps file for extrc figure, x, y axis are pixel

restore,'/mnt/RAIDofsH/mbenko/data1/inversion/helium/tip1.save'  

  
sz=size(extrc)
nx = sz[1]
ny = sz[2]

scalex=1;0.32; arcsec/pix
scaley=1;0.32; arcsec/pix

x = findgen(sz[1]) * scalex ;scale of x
y = findgen(sz[2]) * scaley; scale of y

;asp = float(sz[2]) / sz[1] ;
asp = 0.49
asp2 = 0.33 ;1.95

;width = 15                      ;28.24 is for 800pix
;height = width * asp2
height = 30
width = height * asp

;lev = 0.93

xs  = 0.23
ys  = 0.15;0.14431372;3.22* xs / nx * ny / height * width
;ys = 0.33
;xs = ys / nx * ny / height * width /3

xs2=0.04 
ys2 =0.04

x0 = 0.1 
y0 = 0.1
;
y_col= 0.01
y_text = 0.005
;
y1=y0+ys+ys2
y2= y1 + y_col
y3= y2 + y_text

;sh = 0.09

angstrom = STRING(197B)
set_plot, 'ps'

device, BITS_PER_PIXEL=8, /CMYK, /COLOR, /ENCAPSULATED, $
    FILENAME='corrected_fig_he.eps', /ISOLATIN1, LANGUAGE_LEVEL=2, XOFFSET=0, $
XSIZE=3*width, YOFFSET=0, YSIZE=height

device, /ITALIC, FONT_INDEX=20, /TIMES

XYOUTS, 0.02, 0.48, ['!7y [pixel]'], ORIENTATION=90, charsize=1., /NORMAL ; name ofy axis

ax = 100;165;
ay = 724;665                        ;
axy = 724-100 + 1
a0 = 0  ;
a1 = nx;-(ax-ay)*0.0986;
b1 = 0            ;
b2 = ny;320*0.0986;

; 1. fig
r_min = -3000
r_max = 3000

loadct, 39, /SILENT
tvscl, extrc[*,*,7]>(r_min)<(r_max),/NORM, x0, y0, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x0, y0, x0+xs, y0+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max, $
     xrange = [a0,a1], yrange = [b1,b2]

colorbar_charsize=1.
colorbar,position=[x0, y1, x0 + xs, y1 + y_col],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, 0.52, 0.05, ['!7x [pixel]'], charsize=1., /NORMAL, alignment=0.5  	 ; name of x axis
XYOUTS, x0 + xs*0.52, y3, ['!7 B!Dx!n component of the magnetic field [Gauss]'], charsize=1., /NORMAL, alignment=0.5 

;2. fig
y4 = y3 + ys2
y5 = y4 + ys + ys2
y6 = y5 + y_col
y7 = y6 + y_text

r_min = -3000
r_max = 3000

;loadct, 39, /SILENT


plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x0, y4, x0+xs, y4+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max, $
     xrange = [a0,a1], yrange = [b1,b2]

tvscl, extrc[*,*,8]>(r_min)<(r_max),/NORM, x0, y4, XSIZE=xs, YSIZE=ys

colorbar_charsize=1.
colorbar,position=[x0, y5, x0 + xs, y5 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x0 + xs*0.52, y7, ['!7 B!Dy!n component of the magnetic field [Gauss]'], charsize=1., /NORMAL, alignment=0.5 

;3. fig
y8 = y7  +ys2
y9 = y8+ys+ys2
y10 = y9 + y_col
y11 = y10 + y_text

r_min = -3000
r_max = 3000

loadct, 39, /SILENT
tvscl, extrc[*,*,9]>(r_min)<(r_max),/NORM, x0, y8, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x0, y8, x0+xs, y8+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max, $
      xrange = [a0,a1], yrange = [b1,b2]

colorbar_charsize=1.
colorbar,position=[x0, y9, x0 + xs, y9 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x0 + xs*0.52, y11, ['!7 B!Dz!n component of the magnetic field [Gauss]'], charsize=1., /NORMAL, alignment=0.5 

;device, /CLOSE
;set_plot, 'x'

;stop
;4. fig
y12 = y11  +ys2
y13 = y12+ys+ys2
;y10 = y9 + y_col
;y11 = y10 + y_text

;r_min = -1500
;r_max = 1500

;2. column

x1 = x0  + xs + xs2

; 1. fig
r_min = 0.
r_max = 360.

loadct, 40, /SILENT
tvscl, extrc[*,*,5]>(r_min)<(r_max),/NORM, x1, y0, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x1, y0, x1+xs, y0+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max, $
    xrange = [a0,a1], yrange = [b1,b2]

colorbar_charsize=1.
colorbar,position=[x1, y1, x1 + xs, y1 + y_col],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
;XYOUTS, 0.52, 0.01, ['!7x [Mm]'], charsize=1., /NORMAL, alignment=0.5  	 ; name of x axis
XYOUTS, x1+xs*0.52, y3, ['!7 Azimut [degrees]'], charsize=1., /NORMAL, alignment=0.5 

;2. fig

r_min = 0.
r_max = 180.

loadct, 39, /SILENT
tvscl, extrc[*,*,4]>(r_min)<(r_max),/NORM, x1, y4, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x1, y4, x1+xs, y4+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max, $
    xrange = [a0,a1], yrange = [b1,b2]

colorbar_charsize=1.
colorbar,position=[x1, y5, x1 + xs, y5 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x1 + xs*0.52, y7, ['!7 Inclination [degrees]'], charsize=1., /NORMAL, alignment=0.5 

;3. fig

r_min = 0.
r_max = 3200.

loadct, 39, /SILENT
tvscl, extrc[*,*,3]>(r_min)<(r_max),/NORM, x1, y8, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x1, y8, x1+xs, y8+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max, $
      xrange = [a0,a1], yrange = [b1,b2]

colorbar_charsize=1.
colorbar,position=[x1, y9, x1 + xs, y9 + y_col ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(i5)'
XYOUTS, x1 + xs*0.52, y11, ['!7 Total field strength [Gauss]'], charsize=1., /NORMAL, alignment=0.5 

;3.column

x2 = x1  + xs + xs2

loadct, 0, /SILENT
tvscl, cint,/NORM, x2, y8, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x2, y8, x2+xs, y8+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max, $
      xrange = [a0,a1], yrange = [b1,b2]


device, /CLOSE
set_plot, 'x'

stop
; 1. fig
r_min = -2.
r_max = 2.

;loadct, 39, /SILENT
;tvscl, physres[*,*,10]>(r_min)<(r_max),/NORM, x2, y0, XSIZE=xs, YSIZE=ys

;plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
;    POSITION=[x2, y0, x2+xs, y0+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
;    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
;    YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=50, MIN_VALUE = r_min, MAX_VALUE = r_max

;contour, physres[*,*,0], findgen(nx), findgen(ny), $
;    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x2, y0, x2+xs, y0+ys], $
;    XSTYLE=5, YSTYLE=5, THICK=5;zlta

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

a = physres[ax:ay,*,3]/1000.

tvscl, a,/NORM, x2, y12, XSIZE=xs, YSIZE=ys

plot,x, y, CHARSIZE=1., FONT = 0, /NODATA, /NOERASE, /NORM, $
    POSITION=[x2, y12, x2+xs, y12+ys], TITLE='!7', XMINOR=5, XSTYLE=1, $
    XTHICK=4, XTICKLEN=-0.025, YMINOR=5, YSTYLE=1, YTHICK=4, $ 
     YTICKLEN=-0.025*asp, YTITLE='!7', XTICKINTERVAL=10, MIN_VALUE = r_min, MAX_VALUE = r_max, $
     xrange = [a0,a1], yrange = [b1,b2]

contour, physres[ax:ay,*,0], findgen(axy), findgen(ny), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.5], POSITION=[x2, y12, x2+xs, y12+ys], $
    XSTYLE=5, YSTYLE=5, THICK=5;zlta

contour, cc[ax:ay,*], findgen(axy), findgen(ny), $
    C_COLOR=[0], /NOERASE, /NORM,  LEVELS=[0.9], POSITION=[x2, y12, x2+xs, y12+ys], $
         XSTYLE=5, YSTYLE=5, THICK=5 ;zlta

colorbar_charsize=1.
colorbar,position=[x2, y12 + ys + ys2, x2 + xs, y12  + y_col +ys +ys2 ],range=[r_min,r_max],divisions=4,charsize=colorbar_charsize,/horizontal,/right,format='(f7.1)'
XYOUTS, x2 + xs*0.52, y12 + y_col + ys + ys2+ y_text, ['!7 Doppler velocity [km s!u-1!n]'], charsize=1., /NORMAL, alignment=0.5 

XYOUTS, 0.47, 0.03, ['!7x [Mm]'], ORIENTATION=0, charsize=1., /NORMAL 

device, /CLOSE
set_plot, 'x'
stop
end
