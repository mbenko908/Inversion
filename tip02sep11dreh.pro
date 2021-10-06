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
restore,'/mnt/RAIDofsH/mbenko/data1/inversion/silicon/data_processing/phys_param_gris_si_10828_big_map_1_jun_20_correct.save'          
;vecd - all komp. of mag. vector - Bx and By - with respect to the slit orient.
;bver - vertical comp.
;bhor - horizontal comp.
;gams + azis - inclination + azimuth 
;
    alpha=53.9;65.9521  ; theta in degrees
    beta=3;12;-8.89;-8.7093678
    if keyword_set(TIPSC) then begin
       alpha=53.9;65.9521
       beta=3;-8.89;-8.7093678
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
   ; a=sqrt(vecd(*,*,0)*vecd(*,*,0)+vecd(*,*,1)*vecd(*,*,1)+vecd(*,*,2)*vecd(*,*,2))
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
;  stop  
    save,filename='tip.save',extrc,vecd
    stop
    return
    end
        
    




