   pro hsp30sep11read,cint,sirres,sirerr,stokes ;PG , HSC=HSC, FE6301=FE6301
;
;    for August 30, 2011  => pouziva sa na vycitanie ked uz mas
;    data_together
     perpath='/mnt/RAIDofsH/mbenko/data1/inversion/silicon/data_processing/' ; adresar kde sa nachadzju velke textove subory obsahyjuce vsetky hodnoty
restore,'mask1.save'
;                                                                         fyzikalnych parametrov a ich chyby
     scan='gris'
;

   inic=0
   ntau=55   &   itau=10    &  itau2=25 & itau3=35
   step=1
;
;  Default:   Fe 6302.5, TIPSC= 1
;   x=0-149 ; y=23-157
   ya=0   &   ye=475   &   y1=0   &    y2=475                        ;treba dat pozor na spravny rozmer mapy
   xa=0   &   xe=339   &   x1=0    &    x2=339
; 
   elmnt='_ca_10839_'
;
   kscan=1
   sctype='big_map_jun_20'                                          ; treba menit podla skutocneho mena velkeych textovych suborov
;-------------------------------------------------------------------------------------------
;   svfile='/home/guests/mbenko/Data/AR11277_2808_0309_2011/2011_08_29_07_34_09/Stokes_Image_Save_File/20110829_073409_stksimg.save' ; treba menit
                                ; treba nacitat spravny subor
                                ; obsahujuci pomocne data k jenotlivym
                                ; mapam (hlavne kvoli intenzite
                                ; kontinuua - conti)
;
;
   nx = xe+1 - xa  &   ny = ye+1 - ya   &   ny2 = y2+1 - y1   &  nx2 = x2+1 -xa
;
;   restore,svfile
;   cint=conti
;
;   stokes = fltarr(nx2,ny2,6) 
;   stkv=abs(pv)
;   stkl=pll
;
;   mskp=(stkv gt 0.003 or stkl gt 0.003)

;   stokes(*,*,0)=stkv                          ;  0  circular polarization (uncorrected)
;   stokes(*,*,1)=stkl                          ;  1  linear polarization (corrected)  
;   stokes(*,*,2)=abs(pq)                       ;  2  Stokes-Q  (uncorrected)
;   stokes(*,*,3)=abs(pu)                       ;  3  Stokes-U  (uncorrected)
;   stokes(*,*,4)=ptot                          ;  4  total polarization  (uncorrected)
;   stokes(*,*,5)=mskp                          ;  5  polarization significance mask      
 cin=cont[ 0:475, *]
totp=sqrt(q^2.+u^2.+v^2.)/cont
; stop
   stokes = fltarr(ny2,nx2,6) 
;   stkv=abs(pv)
;   stkl=pll
;
   mskp=fltarr(476,340);(stkv gt 0.003 or stkl gt 0.003)

   stokes(*,*,0)=abs(v[0:475,*]);stkv                          ;  0  circular polarization (uncorrected)
   stokes(*,*,1)=stok_lin[0:475,*];stkl                          ;  1  linear polarization (corrected)  
   stokes(*,*,2)=abs(q[0:475,*]);abs(pq)                       ;  2  Stokes-Q  (uncorrected)
   stokes(*,*,3)=abs(u[0:475,*]);abs(pu)                       ;  3  Stokes-U  (uncorrected)
   stokes(*,*,4)=totp[0:475,*];ptot                          ;  4  total polarization  (uncorrected)
   stokes(*,*,5)=mskp[0:475,*]  ;  5  polarization significance mask
;-------------------------------------------------------------------------------------------
;   restore,'/home/mbenko/20160620/pro/contin.save'
;   cin=fltarr(nx2,ny2)
;   cin=ii2(0,*,*)
;   cin=reform(cin(0,*,*))
;stop
    restore,'/mnt/RAIDofsH/mbenko/data/calc/stokes_ca.save'

   openr,unit,perpath+'calmod_'+scan+elmnt+sctype,/get_lun
   daten=assoc(unit,fltarr(ntau,ny))
   openr,unit_err,perpath+'calerr_'+scan+elmnt+sctype,/get_lun
   error=assoc(unit_err,fltarr(ntau,ny))
;
   btot=fltarr(nx,ny)
   gamm=fltarr(nx,ny)
   azim=fltarr(nx,ny)
   velo=fltarr(nx,ny)
   temp=fltarr(nx,ny)
   p_el=fltarr(nx,ny)
   pgas=fltarr(nx,ny)
   hgeo=fltarr(nx,ny)
   dens=fltarr(nx,ny)
   auxi_1=fltarr(nx,ny)
   auxi_2=fltarr(nx,ny)
;
   berr=fltarr(nx,ny)
   gerr=fltarr(nx,ny)
   aerr=fltarr(nx,ny)
;   xerr=fltarr(nx,ny)
   terr=fltarr(nx,ny)
   terr_2=fltarr(nx,ny)
   terr_3=fltarr(nx,ny)
   pel_err=fltarr(nx,ny)
   velo_err=fltarr(nx,ny)
   hgeo_err=fltarr(nx,ny)
   pgas_err=fltarr(nx,ny)
   dens_err=fltarr(nx,ny)
;
   cont=0
   conte=0
   inic=0

;   for ii=xa,xe do begin          ;scans 
   for ii=xa,xe do begin
      print,ii
; 
        mtem=daten(cont)
        for jj=0,ny -1 do temp(ii,jj)=mtem(itau,jj)
        for jj=0,ny -1 do auxi_1(ii,jj)=mtem(itau2,jj)
        for jj=0,ny -1 do auxi_2(ii,jj)=mtem(itau3,jj)
        cont=cont+1
        mpel=daten(cont)
        for jj=0,ny -1 do p_el(ii,jj)=mpel(itau,jj)
        cont=cont+1
        mmic=daten(cont)
        cont=cont+1
        mbto=daten(cont)
        for jj=0,ny -1 do btot(ii,jj)=mbto(itau,jj)
        cont=cont+1
        mvel=daten(cont)
        for jj=0,ny-1 do velo(ii,jj)=mvel(itau,jj)  
        cont=cont+1
        mgam=daten(cont)
        for jj=0,ny-1 do gamm(ii,jj)=mgam(itau,jj)
        cont=cont+1
        mphi=daten(cont)
        for jj=0,ny-1 do azim(ii,jj)=mphi(itau,jj)
        cont=cont+1  
        mgeo=daten(cont)
        for jj=0,ny-1 do hgeo(ii,jj)=mgeo(itau2,jj)  
        cont=cont+1
        mpgs=daten(cont)
        for jj=0,ny-1 do pgas(ii,jj)=mpgs(itau,jj)
        cont=cont+1
        mrho=daten(cont)
        for jj=0,ny-1 do dens(ii,jj)=mrho(itau,jj)
        cont=cont+1
	maux=daten(cont)
;        for jj=0,ny-1 do auxi(ii,jj)=maux(0,jj)
        cont=cont+1
;
;    goto, skip_this
        mtem=error(conte)
        for jj=0,ny -1 do terr(ii,jj)=mtem(itau,jj)
        for jj=0,ny -1 do terr_2(ii,jj)=mtem(itau2,jj)
        for jj=0,ny -1 do terr_3(ii,jj)=mtem(itau3,jj)
        conte=conte+1
        mpel=error(conte)
        for jj=0,ny -1 do pel_err(ii,jj)=mpel(itau,jj)
        conte=conte+1
        mmic=error(conte)
        conte=conte+1
        mbto=error(conte)
        for jj=0,ny -1 do berr(ii,jj)=mbto(itau,jj)
        conte=conte+1
        mvel=error(conte)
        for jj=0,ny-1 do velo_err(ii,jj)=mvel(itau,jj)  
        conte=conte+1
        mgam=error(conte)
        for jj=0,ny-1 do gerr(ii,jj)=mgam(itau,jj)
        conte=conte+1
        mphi=error(conte)
        for jj=0,ny-1 do aerr(ii,jj)=mphi(itau,jj)
        conte=conte+1
        mgeo=error(conte)
        for jj=0,ny-1 do hgeo_err(ii,jj)=mgeo(itau2,jj)  
        conte=conte+1
        mpgs=error(conte)
        for jj=0,ny-1 do pgas_err(ii,jj)=mpgs(itau,jj)
        conte=conte+1
        mrho=error(conte)
        for jj=0,ny-1 do dens_err(ii,jj)=mrho(itau,jj)
        conte=conte+1
	maux=error(conte)
;        for jj=0,ny-1 do xerr(ii,jj)=maux(0,jj)
        conte=conte+1	
;skip_this:
   endfor 
;
   free_lun,unit
   free_lun,unit_err
;
   sirres=fltarr(nx2,ny2,11)
   sirres(*,*,0)=btot[x1:x2,y1:y2]   ; 0 : total magentis field
   sirres(*,*,1)=gamm[x1:x2,y1:y2]   ; 1 : los-inclination of B
   sirres(*,*,2)=azim[x1:x2,y1:y2]   ; 2 : uncorrected mag. azimuth
   sirres(*,*,3)=velo[x1:x2,y1:y2]   ; 3 ; Doppler velocity
   sirres(*,*,4)=temp[x1:x2,y1:y2]   ; 4 ; Temperature at lg tau = 0.0
   sirres(*,*,5)=auxi_1[x1:x2,y1:y2]   ; 5 ; Temperature at lg tau = -1.5
   sirres(*,*,6)=auxi_2[x1:x2,y1:y2]   ; 6 ; Temperature at lg tau = -2.5
   sirres(*,*,7)=p_el[x1:x2,y1:y2]   ; 7 ; electron pressure
   sirres(*,*,8)=pgas[x1:x2,y1:y2]   ; 8 ; gas pressure
   sirres(*,*,9)=dens[x1:x2,y1:y2]   ; 9 : matter density
   sirres(*,*,10)=hgeo[x1:x2,y1:y2]  ; 10 ; geometrical height
;
   sirerr=fltarr(nx2,ny2,11)
   sirerr(*,*,0)=berr[x1:x2,y1:y2]
   sirerr(*,*,1)=gerr[x1:x2,y1:y2]
   sirerr(*,*,2)=aerr[x1:x2,y1:y2]
   sirerr(*,*,3)=velo_err[x1:x2,y1:y2]   
   sirerr(*,*,4)=terr[x1:x2,y1:y2]   
   sirerr(*,*,5)=terr_2[x1:x2,y1:y2]   
   sirerr(*,*,6)=terr_3[x1:x2,y1:y2]   
   sirerr(*,*,7)=pel_err[x1:x2,y1:y2]   
   sirerr(*,*,8)=pgas_err[x1:x2,y1:y2]   
   sirerr(*,*,9)=dens_err[x1:x2,y1:y2]   
   sirerr(*,*,10)=hgeo_err[x1:x2,y1:y2]  
;tvscl,berr(*,*,0)
btot_err=sirerr(*,*,0)
gamm_err=sirerr(*,*,1)
azim_err=sirerr(*,*,2)

   stokes =  transpose(stokes, [1,0,2])
   cint =  transpose(cint, [1,0])
   sirres =  transpose(sirres, [1,0,2])
   sirerr = transpose(sirerr, [1,0,2])

save,filename='/mnt/RAIDofsH/mbenko/data1/inversion/silicon/data_processing/phys_param_gris_si_10828_big_map_1_jun_20.save',sirres,sirerr, stokes, cint;,cin;,cint,stokes ; treba menit podla toho kam chces
; ulozit data

   return 
   end

