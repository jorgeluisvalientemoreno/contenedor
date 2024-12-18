column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-3348');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
    nuerror   NUMBER;
    sberror   VARCHAR2(4000);
    
    --cursor obtiene diferidos duplicados para mes 9 y año 2024
    CURSOR culdc_osf_diferido IS
    SELECT  /*+ index( a OSF_DIFERIDO_IDX)*/
            a.difenuse,
            a.difecodi,            
            COUNT(*) cant
    FROM    open.ldc_osf_diferido a
    WHERE   a.difeano = 2024
            AND a.difemes = 9
    GROUP BY
        a.difenuse,
        a.difecodi 
    HAVING
    COUNT(*) > 1;
    
    --cursor ROWID mas CULDC_OSF_DIFERIDO
    CURSOR  cuRwiDife IS
    SELECT  ROWID as rd, 
            a.*
    FROM    open.ldc_osf_diferido a;
    
    rcRegistro cuRwiDife%ROWTYPE;
    nuCont      NUMBER := 0;
     
    blLog           pkg_gestionarchivos.styarchivo;
    sbRutaGen    	VARCHAR2(1000) := '/smartfiles/tmp';
    sbNombreArchivo VARCHAR2(100)  := 'log_osf_diferido_'||TO_CHAR(SYSDATE, 'DD_MM_YYYY_HH24_MI_SS')||'.txt';
begin
    
    IF (pkg_gestionarchivos.fblarchivoabierto_smf(blLog) = FALSE) THEN
        blLog := pkg_gestionarchivos.ftabrirarchivo_smf(sbRutaGen, sbNombreArchivo, 'W');
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, 'LOG BORRADO REGISTROS DUPLICADOS TABLA LDC_OSF_DIFERIDO'); 
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, '');  
    END IF;
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, 'Se borran los registros duplicados para el mes 9 año 2024');  
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, 'DIFEANO, DIFEMES, DIFECODI, DIFESUSC, DIFECONC, DIFEVATD, DIFEVACU, DIFECUPA, DIFENUCU, DIFESAPE, DIFENUDO, DIFEINTE, DIFEINAC, DIFEUSUA, DIFETERM, DIFESIGN, DIFENUSE, DIFEMECA, DIFECOIN, DIFEPROG, DIFEPLDI, DIFEFEIN, DIFEFUMO, DIFESPRE, DIFETAIN, DIFEFAGR, DIFECOFI, DIFETIRE, DIFEFUNC, DIFELURE, DIFEENRE, DIFECORR, DIFENCORR');  
  

    --obtiene todos los registros duplicados para el mes 9 y año 2024 
    FOR reg1 IN culdc_osf_diferido LOOP        
        
        nuCont := nuCont +1;
               
        --si son repetidos realiza borrado dejando solo uno
        SELECT /*+ index(a OSF_DIFERIDO_IDX3)*/ 
            a.ROWID as rd, 
            a.*
        INTO rcRegistro
        FROM open.ldc_osf_diferido a
        WHERE a.difeano = 2024
        AND a.difemes = 9
        AND a.difenuse = reg1.difenuse
        AND a.difecodi = reg1.difecodi
        AND ROWNUM = 1;
        
        DELETE /*+ index(a OSF_DIFERIDO_IDX3)*/  
            open.ldc_osf_diferido a
        WHERE a.difeano = 2024
            AND a.difemes = 9
            AND a.difenuse = reg1.difenuse
            AND a.difecodi = reg1.difecodi
            AND ROWID = rcRegistro.rd;                   
        
        pkg_gestionarchivos.prcescribirlinea_smf(blLog, rcRegistro.DIFEANO||','||
                                                        rcRegistro.DIFEMES||','||
                                                        rcRegistro.DIFECODI||','||
                                                        rcRegistro.DIFESUSC||','||
                                                        rcRegistro.DIFECONC||','||
                                                        rcRegistro.DIFEVATD||','||
                                                        rcRegistro.DIFEVACU||','||
                                                        rcRegistro.DIFECUPA||','||
                                                        rcRegistro.DIFENUCU||','||
                                                        rcRegistro.DIFESAPE||','||
                                                        rcRegistro.DIFENUDO||','||
                                                        rcRegistro.DIFEINTE||','||
                                                        rcRegistro.DIFEINAC||','||
                                                        rcRegistro.DIFEUSUA||','||
                                                        rcRegistro.DIFETERM||','||
                                                        rcRegistro.DIFESIGN||','||
                                                        rcRegistro.DIFENUSE||','||
                                                        rcRegistro.DIFEMECA||','||
                                                        rcRegistro.DIFECOIN||','||
                                                        rcRegistro.DIFEPROG||','||
                                                        rcRegistro.DIFEPLDI||','||
                                                        rcRegistro.DIFEFEIN||','||
                                                        rcRegistro.DIFEFUMO||','||
                                                        rcRegistro.DIFESPRE||','||
                                                        rcRegistro.DIFETAIN||','||
                                                        rcRegistro.DIFEFAGR||','||
                                                        rcRegistro.DIFECOFI||','||
                                                        rcRegistro.DIFETIRE||','||
                                                        rcRegistro.DIFEFUNC||','||
                                                        rcRegistro.DIFELURE||','||
                                                        rcRegistro.DIFEENRE||','||
                                                        rcRegistro.DIFECORR||','||
                                                        rcRegistro.DIFENCORR);

        IF mod(nuCont, 10) = 0 THEN
            commit;
        END IF;
    
    
    END LOOP;
      
    pkg_gestionarchivos.prccerrararchivo_smf(blLog);
    
    commit;
    
EXCEPTION
    WHEN pkg_error.controlled_error THEN      
        pkg_error.geterror(nuerror, sberror);
        pkg_gestionarchivos.prcescribirlinea_smf(blLog,'nuerror: '||nuerror||' - '||'sberror: '||sberror);
        pkg_gestionarchivos.prccerrararchivo_smf(blLog);
        RAISE pkg_error.controlled_error;
    WHEN OTHERS THEN     
        pkg_error.seterror;
        pkg_error.geterror(nuerror, sberror);   
        pkg_gestionarchivos.prcescribirlinea_smf(blLog,'nuerror: '||nuerror||' - '||'sberror: '||sberror);
        pkg_gestionarchivos.prccerrararchivo_smf(blLog);
        RAISE pkg_error.controlled_error;
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/