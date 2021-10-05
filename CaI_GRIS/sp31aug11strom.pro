; MENIT CESTU K DATAM !!!!!!
; restore,'/mnt/RAIDofsF/gomory/data/martin/phys_parameters_sep_31/phys_param_hinode_fe_6302_big_map_1_sep_31_correct.save'
; CINT (1 param), EXTRC(10), SIRERR (11 param), SIRRES (11 param), STOKES
; (6 param)
; sirres,sirerr,cint,stokes -> su z read procedury
;
; restore,'/mnt/RAIDofsF/gomory/data/martin/phys_parameters_sep_31/tip.sav'
; vecd -> 9 param
   pro sp31aug11strom,vecd,extrc,sirres,sirerr,stokes,date_obs,xcen,ycen,physres

restore,'/mnt/RAIDofsH/mbenko/data1/inversion/calcium/data_processing/phys_param_gris_ca_10839_big_map_1_jun_20_correct.save'
restore,'/mnt/RAIDofsH/mbenko/data1/inversion/calcium/data_processing/tip.save'
; vecd - from dreh.pro
; extrc - from korrek.pro
; sirres, sirerr, stokes - from read procedure
;extrc =  transpose(extrc, [1,0,2])
;stokes =  transpose(stokes, [1,0,2])
;sirerr =  transpose(sirerr, [1,0,2])
;cint =  transpose(cint, [1,0])
;stop
   my0=4*!pi*1.e-3            ; [G m /A ]
;   
   theta=53.9;65.921                                     ; edituj podla daneho dna  !!!!!! PRE KAZDY DEN INE
   beta=3.0;9.05;12;-8.89;-8.7093678                                     ; edituj podla daneho dna  !!!!!! PRE KAZDY DEN INE
   mx1 = 17 & mx2 = 833 &  my1 = 23  &  my2 = 343  ;364,161 aky chces mat finalny vyrez !!!! cenrovan vyrez na streds skvrnu;30;1612;42;662;14;806;21;331
   mx=mx2-mx1+1  &  my=my2-my1+1
   ;mx = 340 & my = 476
   physres=fltarr(mx,my,24) 
;   
   sz=size(vecd)
;
   OBSPARAM = {DATE_OBS:   '2016-06-20T10:57:16.000', $             ; !!!!
               XCEN:       765.5,                      $             ; !!!!
               YCEN:       -119.8,                     $             ; !!!!
               XARCS:      0.136,                   $
               YARCS:      0.134,                   $
               SCLKM:      98.6                       }   ;48.654
   dx=obsparam.xarcs*735000;1136363;735000. ;*1136363               ; toto treba menit podla toho        
   dy=obsparam.yarcs*735000;1136363; 735000.                ; aky pouzivas pristroj
;
   mskp=stokes[*,*,5]
   mskp=mskp+1
   berr=sirerr[*,*,0]*mskp    
   gerr=(sirerr[*,*,1] < 180.)*mskp*!dtor
   aerr=(sirerr[*,*,2] < 180.)*mskp*!dtor
   dbpar=sqrt((berr*cos(!dtor*extrc[*,*,5]))^2+(gerr*extrc[*,*,4]*   $
         sin(!dtor*extrc[*,*,5]))^2)
   dbtx=sqrt((berr*sin(!dtor*extrc[*,*,5])*cos(!dtor*extrc[*,*,6]))^2  + $
        (extrc(*,*,4)*cos(!dtor*extrc[*,*,5])*cos(!dtor*extrc[*,*,6])*gerr)^2 +$
        (extrc(*,*,4)*sin(!dtor*extrc[*,*,5])*sin(!dtor*extrc[*,*,6])*aerr)^2)
   dbty=sqrt((berr*sin(!dtor*extrc[*,*,5])*sin(!dtor*extrc[*,*,6]))^2  + $
        (extrc(*,*,4)*cos(!dtor*extrc[*,*,5])*sin(!dtor*extrc[*,*,6])*gerr)^2 +$
        (extrc(*,*,4)*sin(!dtor*extrc[*,*,5])*cos(!dtor*extrc[*,*,6])*aerr)^2)
;
   beta0=beta-90.
   alphy=atan(sin(theta*!dtor)*cos(beta0*!dtor)/cos(theta*!dtor))
   alphx=atan(sin(theta*!dtor)*sin(beta0*!dtor)/cos(theta*!dtor))
;
   fbx=sqrt((dbtx*cos(alphy))^2+(dbpar*sin(alphy))^2)
   fby=sqrt((dbtx*sin(alphx)*sin(alphy))^2+(dbty*cos(alphx))^2 +  $
              (dbpar*sin(alphx)*cos(alphy))^2)
   fbz=sqrt((dbtx*cos(alphx)*sin(alphy))^2+(dbty*sin(alphx))^2 +  $
              (dbpar*cos(alphx)*cos(alphy))^2)
;
;   fbx = transpose(fbx, [1,0])
;   fby = transpose(fby, [1,0])
;   fbz = transpose(fbz, [1,0])
;   
   bxraw=vecd[*,*,0]
   bxmed=median(bxraw,3)             ; to smooth the values
   bmsk=abs(bxraw-bxmed) gt 500.
   bx = (1-bmsk)*bxraw+bmsk*bxmed
   byraw=vecd[*,*,1];1
   bymed=median(byraw,3)
   bmsk=abs(byraw-bymed) gt 500.
   by=(1-bmsk)*byraw+bmsk*bymed
   bz = vecd[*,*,2];2
   ci = extrc[*,*,0]
   stv =stokes[*,*,0]
   ;stv=stv+1
   stl = stokes[*,*,1]
   ;stl=stl+1
   bb = extrc[*,*,4]
   tm = extrc[*,*,1]
;   pe = extrc[*,*,2]            ; electron preasure nie je v premenj extrc (lebo
                                ; nasa povodna premenna sirres mala
                                ; az 11 param (s troma teplotami),
                                ; takze ked sme robili extrc a
                                ; vycitali sme do pozicie 2, poziciu
                                ; sirres (6) tak to odpovedalo teplote
                                ; a nie el_preasure
                                ; ale el_preasure je skalar, takze
                                ; mozem pouzit to co je v sirres ->
                                ; preto zmena
   pe = sirres[*,*,7] 
   vv = extrc[*,*,3]
   pg = sirres[*,*,8]           ; musela byt zmena, lebo v nasom pripade je gas presurre na pozicii 8 
   gh = sirres[*,*,10]          ; to iste ako pri pg
;
help, bx
;stop
   cir = deproject(ci, obsparam)   
   bbr = deproject(bb, obsparam)
   bxr = deproject(bx, obsparam)
   byr = deproject(by, obsparam)
   bzr = deproject(bz, obsparam)
   vvr = deproject(vv, obsparam)
   tmr = deproject(tm, obsparam)
   per = deproject(pe, obsparam)
   pgr = deproject(pg, obsparam)
   ghr = deproject(gh, obsparam)
   stvr = deproject(stv, obsparam)
   stlr = deproject(stl, obsparam)
   fxr = deproject(fbx, obsparam)
   fyr = deproject(fby, obsparam)
   fzr = deproject(fbz, obsparam)

;for i = 0, 9 do extrc[*,*,i] = rot(extrc[*,*,i], 12)
;cir = rot(cir, -12)
;bbr = rot(bbr, -12)
;bxr = rot(bxr, -12)
;byr = rot(byr, -12)
;bzr = rot(bzr, -12)
;vvr = rot(vvr, -12)
;tmr = rot(tmr, -12)
;per = rot(per, -12)
;pgr = rot(pgr, -12)
;ghr = rot(ghr, -12)
;cinr = rot(cir, -12)


;stop
;
;
help, bx
   bxr=bxr[mx1:mx2,my1:my2]
   byr=byr[mx1:mx2,my1:my2]
   bzr=bzr[mx1:mx2,my1:my2]
   cir=cir[mx1:mx2,my1:my2]
   stvr=stvr[mx1-2:mx2+2,my1-2:my2+2]
   stlr=stlr[mx1-2:mx2+2,my1-2:my2+2] 
   bbr=bbr[mx1:mx2,my1:my2]
   tmr=tmr[mx1:mx2,my1:my2]
   per=per[mx1:mx2,my1:my2]
   vvr=vvr[mx1:mx2,my1:my2]
   pgr=pgr[mx1:mx2,my1:my2]
   ghr=ghr[mx1:mx2,my1:my2]
   fxr=fxr[mx1:mx2,my1:my2]
   fyr=fyr[mx1:mx2,my1:my2]
   fzr=fzr[mx1:mx2,my1:my2]     
;
;stop
   szv=size(stvr)
;   mskpr=bytarr(szv[1]+4,szv[2]+4)
   mskpr = (stvr gt 0.0015 or stlr gt 0.001)
;stop   
mskpr[0,*]=0 & mskpr[*,0]=0 & mskpr[mx+3,*]=0 & mskpr[*,my+3]=0
   mskpc=shift(mskpr,2,0)*shift(mskpr,-2,0)*shift(mskpr,0,2)*   $
       shift(mskpr,0,-2)
   mskpr=mskpr(2:2+mx-1,2:2+my-1)
   mskpc=mskpc(2:2+mx-1,2:2+my-1)    
   mskpc=round(leefilt(mskpc,2))
;   
   dbydx=mskpc*(shift(byr,-1,0)-shift(byr,1,0))/(2*dx)
   dbxdy=mskpc*(shift(bxr,0,-1)-shift(bxr,0,1))/(2*dy)
;   dbzdx=mskpc*(shift(bzr,-1,0)-shift(bzr,1,0))/(2*dx)
;   dbzdy=mskpc*(shift(bzr,0,-1)-shift(bzr,0,1))/(2*dy)
;   dbbdx=mskpc*(shift(bbr,-1,0)-shift(bbr,1,0))/(2*dx)
;   dbbdy=mskpc*(shift(bbr,0,-1)-shift(bbr,0,1))/(2*dy)
ww = 1   
   ;dbydx=mskpc*(shift(smooth(byr,ww),-1,0)-shift(smooth(byr,ww),1,0))/(2*dx)
   
   ;dbxdy=mskpc*(shift(smooth(bxr,ww),0,-1)-shift(smooth(bxr,ww),0,1))/(2*dy)

   dbxdx=mskpc*(shift(bxr,-1,0)-shift(bxr,1,0))/(2*dx)
   dbydy=mskpc*(shift(byr,0,-1)-shift(byr,0,1))/(2*dy)
;stop
   dbzdz=(-(dbydy+dbxdx))*1000.      ; [G/km]
   jz=1000.*(dbydx - dbxdy)/my0      ; [mA/m^2]
   mskz=bzr lt 10. and bzr gt (-10.)
   alpha=jz/(bzr*(1-mskz)+10*mskz)
   heli=bzr*(dbydx - dbxdy)
   azr=acos(bxr/(sqrt(bxr^2+byr^2)+10.))/!dtor
   mska=(byr lt 0)
   azr=azr*(1-mska)+mska*(360.-azr)
;stop
;
   frotbbz=(sqrt((shift(fyr,-1,0)/(2*dx))^2+(shift(fyr,1,0)/(2*dx))^2+   $
         (shift(fxr,0,-1)/(2*dy))^2+(shift(fxr,0,1)/(2*dy))^2))
   fjz=frotbbz*1000./my0
   fheli=sqrt(((dbydx - dbxdy)*fzr)^2+(bzr*frotbbz)^2)
   fdbz=1000.*sqrt((shift(fyr,0,-1)/(2*dy))^2+(shift(fyr,0,1)/(2*dy))^2+   $
            (shift(fxr,-1,0)/(2*dx))^2+(shift(fxr,1,0)/(2*dx))^2 )
   falpha=sqrt((fjz/(bzr*(1-mskz)+10*mskz))^2+(jz*fzr/  $
        ((bzr*(1-mskz)+10*mskz)^2))^2)
;
;   dbpdz=(bzr/((bxr^2+byr^2)>10.))*(bxr*dbbdx+byr*dbbdy)
;   flz_g=(1./4.*!pi)*(bxr*dbzdx+byr*dbzdy-bzr*(dbxdx+dbydy)-bbr*dbpdz)
;
;   s1=fltarr(my)
;   for j=0,my-1 do s1(j)=simps(bxr(*,j)*bzr(*,j))*dx
;   flx=simps(s1)*dy/(4.*!pi)
;   for j=0,my-1 do s1(j)=simps(abs(bxr(*,j))*bzr(*,j))*dx
;   fla=simps(s1)*dy/(4.*!pi)  
;   for j=0,my-1 do s1(j)=simps(byr(*,j)*bzr(*,j))*dx
;   fly=simps(s1)*dy/(4.*!pi) 
;   for j=0,my-1 do s1(j)=simps(bzr(*,j)^2-bxr(*,j)^2-byr(*,j)^2)*dx
;   flz=simps(s1)*dy/(8.*!pi) 
;   for j=0,my-1 do s1(j)=simps(bbr(*,j)*bbr(*,j))*dx
;   f0=simps(s1)*dy/(8.*!pi)   
;   print,(flx/f0),(fla/f0),(fly/f0),(flz/f0)
;   

; all values are with respect to the surface normal
   physres[*,*,0]=cir ; int
   physres[*,*,1]=tmr ;          temperature 

   physres[*,*,2]=per ;          electron pressure
   physres[*,*,3]=vvr ;          Doppler vel
   physres[*,*,4]=bbr ;          total mag. field
   physres[*,*,5]=acos(bzr/(bbr>10.))/!dtor  ; inclination
   physres[*,*,6]=azr                        ; azimuth
   physres[*,*,7]=bxr                        ; Bx
   physres[*,*,8]=byr                        ; By
   physres[*,*,9]=bzr                        ; Bz
   physres[*,*,10]=dbzdz*mskpc  ; vertical deriv. of the vert. comp.
   physres[*,*,11]=jz*mskpc     ; curr. dens.
   physres[*,*,12]=alpha*mskpc  ; alpha
   physres[*,*,13]=float(mskpc) ; mask
   physres[*,*,14]=fjz*mskpc    ; curr. dens error
   physres[*,*,15]=fdbz*mskpc   ; error for the dbzdz
   physres[*,*,16]=falpha*mskpc ; alpha err.
   physres[*,*,17]=fxr          ; errors of the coordinates of the mag. field.
   physres[*,*,18]=fyr
   physres[*,*,19]=fzr
   physres[*,*,20]=heli*mskpc   ; current helicity
   physres[*,*,21]=fheli*mskpc  ; error for current helicity
   physres[*,*,22]=pgr          ; gas pressure
   physres[*,*,23]=ghr          ; gemetrical height

   help, physres
;
  ; for i = 0, 2 do physres[*,*,i] = rot(physres[*,*,i], 12, /INTERP, missing=0)
;stop
 ;  tvscl, physres[*,*,0]
   save,filename='results1.save',physres

 ph = make_map(physres[*,*,0], dx = 0.0986, dy = 0.09715, xc = 40, yc = 15)
 plot_map, ph, xtitle = 'Mm', ytitle = 'Mm';,  drange=[-2000, 2000]
   
stop
   
   return
   end
