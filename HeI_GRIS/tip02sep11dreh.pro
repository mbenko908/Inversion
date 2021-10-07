; *************************  TIP02SEP11DREH  ************************
;
; Dreht einen Vektor um einen vorzugebenden Winkel (3D)
;
; H. Balthasar,  April 2001, Update Nov. 2011
;
;  f"ur  02. 09.2011
;
; *********************************************************************
;
    pro tip02sep11dreh,extrc,vecd, TIPSC=TIPSC

; values with respect to the surface normal
;restore,'/mnt/RAIDofsH/mbenko/data1/inversion/calcium/data_processing/phys_param_gris_ca_10839_big_map_1_jun_20_correct.save'          
restore,'phys_corrected.save'
restore,'hazelres_10830_degrad.save'
;vecd - all komp. of mag. vector - Bx and By - with respect to the slit orient.
;bver - vertical comp.
;bhor - horizontal comp.
;gams + azis - inclination + azimuth 


;
;hazelres[*,*,2]=180.+hazelres[*,*,2]
    alpha=53.9;65.9521  ; theta in degrees ; 43.9-9
    beta=3.0;-9;-8.89;-9.05;8.7093678
    if keyword_set(TIPSC) then begin
       alpha=53.9;65.9521
       beta=-3;22;3;-9.05;-8.7093678
    endif
;
;a = hazelres[*,*,0] gt 800

    alphy=atan(sin(alpha*!dtor)*cos(beta*!dtor)/cos(alpha*!dtor))
    alphx=atan(sin(alpha*!dtor)*sin(beta*!dtor)/cos(alpha*!dtor))   
    vector=extrc[*,*,7:9]    ;extrc(*,*,7:9)
 ;   vector[*,*,0] = hazelres[*,*,4]*(hazelres[*,*,0] gt 450)
 ;   vector[*,*,1] = hazelres[*,*,3]*(hazelres[*,*,0] gt 450)
 ;   vector[*,*,2] = vector[*,*,2]*(hazelres[*,*,0] gt 450)
;vector[*,*,2]=abs(vector[*,*,2])
    btot=extrc(*,*,3)
    sz=size(vector)
;
  ; stop                             ;stop
    ;a=reform(vector[*,*,0])
   ; vector[106:183,0:75,1]=vector[106:183,0:75,1]+2*vector[106:183,0:75,1]*(a[106:183,0:75,0] lt -400)
   ; vector[88:167,70:155,1]=vector[88:167,70:155,1]-2*vector[88:167,70:155,1]*(a[88:167,70:155] gt 400)
   ; vector[110:188,0:155,0]=abs(vector[110:188,0:155,0])
    ;stop
  ;  vector[97:52,0:97,0]=(abs(vector[97:52,0:97,2])>600)*abs(vector[97:52,0:97,2]
  ;  vector[81:142,97:190,0]=(-1)*(abs(vector[81:142,97:190,2])>600)*abs(vector[81:142,97:190,2]

    
    dm=fltarr(3,3)
    dm(*,0)=[cos(alphy),sin(-alphx)*sin(alphy),cos(alphx)*sin(alphy)]
    dm(*,1)=[0.,cos(alphx),sin(alphx)]
    dm(*,2)=[sin(-alphy),sin(-alphx)*cos(alphy),cos(alphx)*cos(alphy)]
;

    vecd=fltarr(sz(1),sz(2),9)
    for i=0,sz(1)-1 do for j=0,sz(2)-1 do vecd(i,j,0:2)=dm#reform(vector(i,j,*))
;


;stop    
;    
    bver=vecd(*,*,2)
    bhor=sqrt(vecd(*,*,0)^2+vecd(*,*,1)^2) > 10.
    ;gams1=(1/!dtor)*acos(extrc(*,*,9)/(btot>1.))
;
   ; a=sqrt(vecd(*,*,0)*vecd(*,*,0)+vecd(*,*,1)*vecd(*,*,1)+vecd(*,*,2)*vecd(*,*,2))
    gams=(1./!dtor)*acos(bver/(btot>1.)); inclination
;
    psi1=(1./!dtor)*acos(vecd(*,*,0)/bhor);azimuth calculated
    mska=(vecd(*,*,1) lt 0) 
    psi1=psi1*(1-mska)+mska*(360.-psi1)
;
  
  ;  psi1 = a
    
    vecd[*,*,3]=gams;0-180 inc
    vecd[*,*,4]=psi1;0-360 az
    vecd[*,*,5]=bhor
;
 vecd(*,*,8)=reform(btot*cos(!dtor*vecd[*,*,3])) ;Bz
    vecd(*,*,7)=reform(btot*sin(!dtor*vecd[*,*,3])*sin(!dtor*vecd(*,*,4))) ;By
    vecd(*,*,6)=reform(btot*sin(!dtor*vecd[*,*,3])*cos(!dtor*vecd(*,*,4))) ;Bx 

;    tvscl, (vecd[*,*,6])<(2000.0)>(-2000.0)
;    tvscl, (vecd[*,*,7])<(2000.0)>(-2000.0),270,0
;    tvscl, (vecd[*,*,8]),540,0
;for i = 0, 9 do extrc[*,*,i] = rot(extrc[*,*,i], 9)
;for i = 0, 8 do vecd[*,*,i] = rot(vecd[*,*,i], 9)

    
;b = sqrt(vecd[*,*,6]^2+vecd[*,*,7]^2+vecd[*,*,8]^2)
;inc = acos(vecd[*,*,8]/b)
;az = atan(vecd[*,*,6]/vecd[*,*,7])

;tvscl, b, 0,200
;tvscl, vecd[*,*,3], 270,200
;tvscl, vecd[*,*,4], 540, 200
;a = make_map(vecd[*,*,4])
;c = make_map(cont)
;plot_map, a, drange=[0.,360.]
;plot_map, c, /over, level=[0.5], color= 256

;    stop  
 stokes = fltarr(238,170,6)
cint = cont

;stop
;vsuvka na rot;
;;     sz=size(cint)            ;cint
;;theta =!dtor*53.9;65.9521; 28.25
;;   fcsth=cos(theta)
;;   azinull=-22;-62;-22;-90.
;   cazx2=100  &  cazy2=2      ; centers of azimuth
;;   cazx=125 &  cazy=39 ;188,68 
;;sz=size(cint)
;;   azineg = 0
;;   if n_elements(TIPSC) eq 0 then TIPSC = 0
;
;;   if (TIPSC eq 3) then begin
;;       cazx2=sz[1]-2 &  cazy2=sz[2]-2              ; centers of azimuth
;;       cazx=sz[1]-2 &  cazy=sz[2]-2 ;142/188 ;-10, 94
;;       xazisep=sz[1]-1    &  yazisep=sz[2]-1
;;   endif
;;   if n_elements(TIPSC) eq 0 then TIPSC = 0 

   
;;  azi0=fltarr(sz[1],sz[2])
;;    zdel=0
;;    if TIPSC eq 3 then begin
;;       zdel=20 
;;       azi0=fltarr(sz[1]+zdel,sz[2])
;;    endif
;;    sz0=size(azi0)
;;    mazi=fltarr(sz0[1],sz0[2])
   ; mazi[xazisep+zdel:*,yazisep:*] = 1. ;;;;;;;;;;;;;
;tvscl,mazi,600,400

;;    xyazi0=fltarr(sz0[1],sz0[2],2)    
    
;;    for i=0,sz0[2]-1 do xyazi0[*,i,0]=findgen(sz0[1])-(cazx+zdel)
;tvscl,xyazi0(*,*,0)
   
;;   for j=0,sz0[1]-1 do xyazi0[j,*,1]=findgen(sz0[2])-cazy
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
;;    for i=0,sz0[1]-1 do $
;;       for j=0,sz0[2]-1 do azi0[i,j]=(1./!dtor)*atan(xyazi0[i,j,1]*   $
;;         (fcsth/float(xyazi0[i,j,0])))
;tvscl, azi0
;stop
;;    azi0 = azi0 + 180.*(xyazi0[*,*,0] lt 0)
;;    azi0 = azi0 + 360.*(xyazi0[*,*,1] lt 0 and xyazi0[*,*,0] gt 0)
;;    azi0[cazx+zdel,cazy+1:*]=90.
;;    azi0[cazx+zdel,0:cazy-1]=270.
;;    azi0 +=azineg
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
;;    azi0=(mazi le 0)*azi0; + (mazi gt 0)*azi2
;;    azi0=azi0[zdel:*,*]
;
    ;tvscl, azi0
    ;stop
   ; azi0 *= mskp
;
;;    azi0=azi0-360.*(azi0 ge 360.)
;;    azi0=azi0-360.*(azi0 ge 360.)
;    azi0=azi0-360.*(azi0 ge 360.)   
;;    azi0=azi0+360.*(azi0 lt 0.)
;tvscl, azi0;, 400, 0
;;azi1 = reform(vecd[*,*,4]) + azinull
;;msk=(abs(azi1-azi0) gt 91. and abs(azi1-azi0) lt 269.)
;;azi1=azi1+180.*msk
;;azi1=azi1-360.*(azi1 ge 360.)
;;   azi1=azi1+360.*(azi1 lt 0.) 


;;   az = abs( vecd[*,*,4]-360*(vecd[*,*,4]-azi0 lt -270))-10*(vecd[*,*,4]-azi0 gt 0)
;b = vecd[*,*,4] - 22
;b = b +360*(b lt 0)
;b = b*(cont lt 0.73)

;   by = reform(btot*sin(!dtor*vecd[*,*,3])*sin(!dtor*(b)))
;   bx = reform(btot*sin(!dtor*vecd[*,*,3])*cos(!dtor*(b)))
;    stop
;   vecd[*,*,4] = b
;   vecd[*,*,7] = by
;   vecd[*,*,6] = bx


;stop






;stop
for i = 0, 9 do extrc[*,*,i] = rot(extrc[*,*,i], 9)
for i = 0, 8 do vecd[*,*,i] = rot(vecd[*,*,i], 9)
for i = 0, 5 do stokes[*,*,i] = rot(stokes[*,*,i], 9)
;print,'a'
cint = rot(cint, 9)


;stop
    save,filename='tip1.save',extrc,vecd, cint, stokes
stop
    return
    end
        
    




