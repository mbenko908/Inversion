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
restore,'/mnt/RAIDofsH/mbenko/hinode/data_processing/phys_param_hinode_fe_6302_big_map_1_jun_20_correct1.save'          
;vecd - all komp. of mag. vector - Bx and By - with respect to the slit orient.
;bver - vertical comp.
;bhor - horizontal comp.
;gams + azis - inclination + azimuth 
;
    alpha=53.5;46;53.5;65.9;2  ; theta in degrees
    beta=3;15;180;9.5;-12.43;-8.89;3
    if keyword_set(TIPSC) then begin
       alpha=46.5;54.92
       beta=9;9.5;9.05;-12.43;-8.89;3 
    endif
;
    alphy=atan(sin(alpha*!dtor)*cos(beta*!dtor)/cos(alpha*!dtor))
    alphx=atan(sin(alpha*!dtor)*sin(beta*!dtor)/cos(alpha*!dtor))   
    vector=extrc(*,*,7:9)
    btot=extrc(*,*,4)
    sz=size(vector)
;    
    dm=fltarr(3,3)
    dm(*,0)=[cos(alphy),sin(-alphx)*sin(alphy),cos(alphx)*sin(alphy)]
    dm(*,1)=[0.,cos(alphx),sin(alphx)]
    dm(*,2)=[sin(-alphy),sin(-alphx)*cos(alphy),cos(alphx)*cos(alphy)]
;
    vecd=fltarr(sz(1),sz(2),9)
    for i=0,sz(1)-1 do for j=0,sz(2)-1 do vecd(i,j,0:2)=dm#reform(vector(i,j,*))
;
    
;    
    bver=vecd(*,*,2)
    bhor=sqrt(vecd(*,*,0)^2+vecd(*,*,1)^2) > 10.
    ;gams1=(1/!dtor)*acos(extrc(*,*,9)/(btot>1.))
;
    ;a=sqrt(vecd(*,*,0)*vecd(*,*,0)+vecd(*,*,1)*vecd(*,*,1)+vecd(*,*,2)*vecd(*,*,2))
    gams=(1./!dtor)*acos(bver/(btot>1.))
;
    psi1=(1./!dtor)*acos(vecd(*,*,0)/bhor)
    mska=(vecd(*,*,1) lt 0) 
    psi1=psi1*(1-mska)+mska*(360.-psi1)
;
    vecd[*,*,3]=gams
    vecd[*,*,4]=psi1
    vecd[*,*,5]=bhor
;
 vecd(*,*,8)=reform(extrc[*,*,4]*cos(!dtor*vecd[*,*,3])) ;Bz
    vecd(*,*,7)=reform(extrc[*,*,4]*sin(!dtor*vecd[*,*,3])*sin(!dtor*vecd(*,*,4))) ;By
    vecd(*,*,6)=reform(extrc[*,*,4]*sin(!dtor*vecd[*,*,3])*cos(!dtor*vecd(*,*,4))) ;Bx
    tvscl, vecd[*,*,5]
;stop
 ;   bz = make_map(vecd[*,*,8])
 ;   cc = make_map(extrc[*,*,0])
;loadct,0
  ;  plot_map, cc, xrange=[-100,100], yrange=[-150,50]
    ;plot_map, cc, /over, levels = 0.5
   ; plot_map, bz, /over, levels = 1867,xrange=[-100,100], yrange=[-150,50]
;loadct,39    
                                ;stop
cc = cint/(total(total(cint[0:164,0:128],1),0)/(164*128))
    
    save,filename='/mnt/RAIDofsH/mbenko/hinode/data_processing/tip_new.sav',extrc,vecd

    b = make_map(vecd[*,*,4])
    c = make_map(cint)
    plot_map, b
    plot_map, c, level=0.5, /over
    stop
    return
    end
        
    




