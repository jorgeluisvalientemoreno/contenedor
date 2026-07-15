
DECLARE

    CURSOR periodos IS
        SELECT DISTINCT PEFACODI
        FROM open.perifact pf
        left join open.pericose pc on pc.pecsfecf between pf.pefafimo and pf.pefaffmo 
        WHERE pefacicl in (6005)
        and pefaactu ='N' 
        and pefaffmo <= sysdate 
        and pc.pecsproc='S'
        and not exists ( select NULL from procejec pc2 where pc2.prejcope= pefacodi and pc2.prejprog = 'FCRI') ;


BEGIN

 FOR rec IN periodos LOOP
    INSERT INTO PROCEJEC 
    SELECT rec.PEFACODI AS prejcope, 
    'FCRI', 
    SYSDATE , 
    'DIASAL', 
    'NO TERMINAL', 
    -1, 
    'T', 
    NULL, 
    '1495841532,755,26565|1495841533,1135,24915|1495841534,755,26567|1495841535,1135,24917|', 
    SQ_PROCEJEC_PREJIDPR.NEXTVAL AS prejidpr , 
    NULL
    FROM DUAL ; 
    
 END LOOP;
 COMMIT;
 
END ; 
