; **********************  HSP02sep11KORREK  *******************************
;
; Korrigiert nachtr"aglich SIR-Ergebnisse f"ur Fleck vom 2. September 2011.
;  HSP f"ur HINODE-Daten.
;
; H. Balthasar, November 2011, nach TIP210510KORREK.
;
; ************************************************************************
; 
   pro hsp28sep11korrek,cint,sirres,extrc,azi0,mskp, TIPSC=TIPSC
;
     restore,'/mnt/RAIDofsH/mbenko/data1/inversion/calcium/data_processing/phys_param_gris_ca_10839_big_map_1_jun_20.save'
restore,'mask.save'
  ;      stokes =  transpose(stokes, [1,0,2])
  ; cint =  transpose(cint, [1,0])
  ; sirres =  transpose(sirres, [1,0,2])
  ; sirerr = transpose(sirerr, [1,0,2])
    ; restore,'/mnt/RAIDofsH/mbenko/data/calc/stokes_ca.save'
;     r=mean(abs(stokes_3d[*,72:102,*,*]),dimension=2)
;     mskp = sqrt(r[1,*,*]^2+r[2,*,*]^2+r[3,*,*]^2)/r[0,*,*]
;     mskp = mskp ge 0.015
;mskp=0*fltarr(170,238);stokes[*,*,5]
;mskp=mskp+1
;
;     cint=mean(abs(stokes_3d[0,0:20,*,*]),dimension=2)  
;     cint = reform(cint)
cint=cin
     sz=size(cint)            ;cint
theta =!dtor*53.9;65.9521; 28.25
   fcsth=cos(theta)
   azinull=-74;-62;-22;-90.
;   cazx2=100  &  cazy2=2      ; centers of azimuth
   cazx=188 &  cazy=68 ;188,68
  ; xazisep=150  &  yazisep=150
   if n_elements(TIPSC) eq 0 then TIPSC = 0
;
   if (TIPSC eq 3) then begin
;       cazx2=sz[1]-2 &  cazy2=sz[2]-2              ; centers of azimuth
       cazx=sz[1]-2 &  cazy=sz[2]-2 ;142/188 ;-10, 94
    ;   xazisep=sz[1]-1    &  yazisep=sz[2]-1
   endif
;   if n_elements(TIPSC) eq 0 then TIPSC = 0
;
   azineg = -9
   ;
   extrc=fltarr(sz[1],sz[2],10)
   extrc[*,*,1]=sirres[*,*,4]
   extrc[*,*,2]=sirres[*,*,6]
   extrc[*,*,3]=sirres[*,*,3]
   extrc[*,*,4]=sirres[*,*,0]
   extrc[*,*,5]=(sirres[*,*,1] mod 360.)
   extrc[*,*,6]=(sirres[*,*,2] mod 360.)
   mp=3
;
   mskp = reform(stokes[*,*,5]);fltarr(340,476) +1;
   extrc[*,*,0]=cint
 ;stop  
   for k=4,6 do extrc[*,*,k]=extrc[*,*,k]*mskp
;   extrc(*,*,1)=extrc(*,*,1)+(1-mskp)*6450.           ; temp from the nonmag. area
;
   bmed=median(extrc[*,*,4],mp)*mskp
   mskb=abs(extrc[*,*,4]-bmed) gt 500                ; check for mag field
   extrc[*,*,4]=(1-mskb)*extrc[*,*,4]+mskb*bmed
;   bsm=smoothe(reform(extrc[*,*,4]),15)
;   where2,(extrc[*,*,4] gt 3100.),ix,iy              ; chcek for mag field upper level
;   nxy=n_elements(ix)  
;   if nxy gt 1 or (nxy eq 1 and ix(0) ge 0) then $
;      for ii=0,nxy-1 do extrc[ix[ii],iy[ii],4]=bsm[ix[ii],iy[ii]]
   vmed=median(extrc[*,*,3],mp) 
   mskv=abs(extrc[*,*,3]-vmed) gt 1000               ; check for velo
   extrc[*,*,3]=(1-mskv)*extrc[*,*,3]+mskv*vmed
   extrc[*,*,5] = extrc[*,*,5] + 360.*(extrc[*,*,5] lt -180.) 
   extrc[*,*,5] = extrc[*,*,5] * signum(extrc[*,*,5]) 
   gmed=median(extrc[*,*,5],mp)*mskp  
   extrc[*,*,5]=(1-mskb)*extrc[*,*,5]+mskb*gmed
;
   extrc[*,*,6] = extrc[*,*,6] + 360.*(extrc[*,*,6] lt 0.)
    extrc[*,*,6] = extrc[*,*,6] - 360.*(extrc[*,*,6] ge 360.)
;
   azi1=(extrc[*,*,6]) + azinull 
;              ----    azinull: --> Azimut 0 in positive x-Richtung
   azi1 += 360 * (azi1 lt 0)
;tvscl, azi1
;stop
;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
    azi0=fltarr(sz[1],sz[2])
    zdel=0
    if TIPSC eq 3 then begin
       zdel=20 
       azi0=fltarr(sz[1]+zdel,sz[2])
    endif
    sz0=size(azi0)
    mazi=fltarr(sz0[1],sz0[2])
   ; mazi[xazisep+zdel:*,yazisep:*] = 1. ;;;;;;;;;;;;;
;tvscl,mazi,600,400

    xyazi0=fltarr(sz0[1],sz0[2],2)    
    
    for i=0,sz0[2]-1 do xyazi0[*,i,0]=findgen(sz0[1])-(cazx+zdel)
;tvscl,xyazi0(*,*,0)
   
    for j=0,sz0[1]-1 do xyazi0[j,*,1]=findgen(sz0[2])-cazy
;delet
;    xyazi2=fltarr(sz0[1],sz0[2],2)    
;    for i=0,sz0[2]-1 do xyazi2[*,i,0]=findgen(sz0[1])-(cazx2+zdel)
;    for j=0,sz0[1]-1 do xyazi2[j,*,1]=findgen(sz0[2])-cazy2
;
;    xyazi3=fltarr(sz[1],sz[2],2)    
;    for i=0,sz[2]-1 do xyazi3[*,i,0]=findgen(sz[1])-cazx3
;    for j=0,sz[1]-1 do xyazi3[j,*,1]=findgen(sz[2])-cazy3
;delet
;tvscl, xyazi0(*,*,0)    
;stop
    for i=0,sz0[1]-1 do $
       for j=0,sz0[2]-1 do azi0[i,j]=(1./!dtor)*atan(xyazi0[i,j,1]*   $
         (fcsth/float(xyazi0[i,j,0])))
;tvscl, azi0
;stop
    azi0 = azi0 + 180.*(xyazi0[*,*,0] lt 0)
    azi0 = azi0 + 360.*(xyazi0[*,*,1] lt 0 and xyazi0[*,*,0] gt 0)
    azi0[cazx+zdel,cazy+1:*]=90.
    azi0[cazx+zdel,0:cazy-1]=270.
    azi0 +=azineg
;    azi0 += 180.
;    tvscl, azi0
;    stop
;delet
;    azi2=fltarr(sz0[1],sz0[2])
;    for i=0,sz0[1]-1 do $
;       for j=0,sz0[2]-1 do azi2[i,j]=(1./!dtor)*atan(xyazi2[i,j,1]/   $
;         (fcsth*float(xyazi2[i,j,0])))
;    azi2 = azi2 + 180.*(xyazi2[*,*,0] lt 0)
;    azi2 = azi2 + 360.*(xyazi2[*,*,1] lt 0 and xyazi2[*,*,0] gt 0)
;    azi2[cazx2+zdel,cazy2+1:*]=90.
;    azi2[cazx2+zdel,0:cazy2-1]=270.
;    azi2 += 180.
;    azi2 = azi2 mod 360.
;delet                    ;delet
    azi0=(mazi le 0)*azi0; + (mazi gt 0)*azi2
    azi0=azi0[zdel:*,*]
;
    ;tvscl, azi0
    ;stop
    azi0 *= mskp
;
    azi0=azi0-360.*(azi0 ge 360.)
    azi0=azi0-360.*(azi0 ge 360.)
;    azi0=azi0-360.*(azi0 ge 360.)   
    azi0=azi0+360.*(azi0 lt 0.)
;tvscl, azi0;, 400, 0
 ;   stop
;
;   azi0=azi0*mskp
   msk=(abs(azi1-azi0) gt 91. and abs(azi1-azi0) lt 269.)
;tvscl, msk
;  stop
;
;tvscl, azi1
   azi1=azi1+180.*msk
; tvscl, azi1 
;   stop

   azi1=azi1-360.*(azi1 ge 360.)
   azi1=azi1+360.*(azi1 lt 0.)
;azi1 = transpose(azi1, [1,0])
;   tvscl, azi1 
;print, max(azi1)
;   stop
;   
; Manuelle Korrekturen: 
   msk=0*msk

;      for i=307,363 do for j=109,288 do if (azi1(i,j) gt 300 and
;      azi1[i,j] lt 360.) then $
   ;totofor i=307,363 do for j=109,288 do if (azi1(i,j) gt 300) then $
   ;     msk(i,j)=1b 
;;   for i=0,64 do for j=100,225 do if (azi1(i,j) gt 90 and azi1[i,i] lt 270.) then $
;;        msk(i,j)=1b 
;;;   for i=50,339 do for j=100,404 do if (azi1(i,j) gt 170) && (azi1(i,j) lt 360) then $
;;;        msk(i,j)=1b ;260
;;;;   for i=100,230 do for j=0,70 do if (azi1(i,j) lt 180) && (azi1(i,j) gt 90) then $
;;        msk(i,j)=1b

;  for i=132,200 do for j=100,240 do if (azi1(i,j) lt 70) then $
;     msk(i,j)=1b
;    for i=132,170 do for j=70,100 do if (azi1(i,j) lt 70) then $
;       msk(i,j)=1b
;  for i=170,185 do for j=80,100 do if (azi1(i,j) lt 55) then $
;;;;     msk(i,j)=1b
;;;    for i=70,100 do for j=132,180 do if (azi1(i,j) lt 30) then $
;;;       msk(i,j)=1b

;;;    for i=0,54 do for j=337,410 do if (azi1(i,j) gt 200) && (azi1(i,j) lt 300) then $
;;;        msk(i,j)=1b
;; for i=91,196 do for j=313,363 do if (azi1(i,j) gt 170) then $
;;        msk(i,j)=1b 
;   msk[0:40,55:120] = (azi1[0:40,55:120] gt 90 and azi1[0:40,55:120] lt 270.)
;   msk[138:194,141:169] = (azi1[138:194,141:169] gt 180 and azi1[138:194,141:169] lt 310.)
   azi1=azi1+180.*msk  
   msk=msk*0
;   msk[73:248,185:250] = (azi1[73:248,185:250] gt 220 and azi1[73:248,185:250] lt 260.)
;   msk[78:122,145:171] = (azi1[78:122,145:171] gt 220 and azi1[78:122,145:171] lt 260.)
;   azi1=azi1+180.*msk  
;   msk=msk * 0
;   msk[118:173,117:177] =   (azi1[118:173,117:177] lt 90 )
;   azi1=azi1+180.*msk  
;   for i=0,104 do for j=100,225 do if (azi1(i,j) gt 90 and azi1[i,i] lt 270.) then $
;        msk(i,j)=1b 
;for i=71,94 do for j=137,190 do if (azi1(i,j) lt 90) then $
;        msk(i,j)=1b 
;  for i=81,92 do for j=40,54 do if azi1(i,j) gt 200. then msk(i,j)=1b 
;  for i=302,335 do for j=100,139 do if azi1(i,j) gt 150. then msk(i,j)=1b 
;   for i=0,100 do for j=100,260 do if (azi1(i,j) gt 90) && (azi1(i,j) lt 180) then $
       ; msk(i,j)=1b
;;;   for i=105,240 do for j=130,210 do if (azi1(i,j) gt 300) then $
;;;      msk(i,j)=1b
;;;   for i=0,339 do for j=404,475 do if (azi1(i,j) gt 200) then $
;;;      msk(i,j)=1b
;;;   azi1=azi1-180.*msk  
;
    ;    stop
   azi1=azi1-360.*(azi1 ge 360.)
   azi1=azi1+360.*(azi1 lt 0.)
;
  ; extrc[*,*,5] = 180. - extrc[*,*,5]
  ; extrc[*,*,6] = 360. - extrc[*,*,6]
   bz=reform(extrc[*,*,4]*cos(!dtor*extrc[*,*,5]))
   by=reform(extrc[*,*,4]*sin(!dtor*extrc[*,*,5])*sin(!dtor*azi1))
   bx=reform(extrc[*,*,4]*sin(!dtor*extrc[*,*,5])*cos(!dtor*azi1))
   bm=median(bz,5)
   mskb=abs(bz-bm) gt 1000 and mskp eq 1
   bz=(1-mskb)*bz+mskb*bm
   bm=median(bx,5)
   mskb=abs(bx-bm) gt 1000 and mskp eq 1
   bx=(1-mskb)*bx+mskb*bm
   bm=median(by,5)
   mskb=abs(by-bm) gt 1000 and mskp eq 1
   by=(1-mskb)*by+mskb*bm
   extrc[*,*,6]=azi1*mskp
   extrc[*,*,7]=bx
   extrc[*,*,8]=by
   extrc[*,*,9]=bz
;
;do rotate of maps   
for i = 0, 9 do extrc[*,*,i] = rot(extrc[*,*,i], 9)
cint = rot(cint, 9)
for i = 0, 10 do sirres[*,*,i] = rot(sirres[*,*,i], 9)
  ; sirres= rot(sirres, -12)

   
;   tvscl, reform(extrc[*,*,6])
;   profiles, reform(extrc[*,*,6])
;   tvscl, extrc[*,*,5],200,0
;   tvscl, extrc[*,*,7],380,0
;   tvscl, extrc[*,*,8],530,0
;   tvscl, extrc[*,*,9],710,0
  ; tvscl, sirres[*,*,2], 200, 0
;   extrc = transpose(extrc, [1,0,2])
;   stokes =  transpose(stokes, [1,0,2])
;   cint =  transpose(cint, [1,0])
;   sirres =  transpose(sirres, [1,0,2])
tvscl, extrc[*,*,6]
;profiles, extrc[*,*,6]
;print, max(azi1)
;stop
   save,filename='/mnt/RAIDofsH/mbenko/data1/inversion/calcium/data_processing/phys_param_gris_ca_10839_big_map_1_jun_20_correct.save',sirres,sirerr,cint,stokes, extrc
stop
   return
   
   end
   
   











