CREATE OR REPLACE PROCEDURE adm_person.ldc_prcdevcausotspag(dtpafecha IN DATE) 
IS
    /**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2022-05-16
    Descripcion : Actualiza causal de la orden de pago con causal anterior
                para ordenes actualizadas en una fecha inicial en adelante
    
    Parametros Entrada
    dtpafecha fecha
    
    Valor de salida
    
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR   DESCRIPCION
    17/04/2024      PAcosta             OSF-2532: Se crea el objeto en el esquema adm_person  
    ***************************************************************************/
    
    CURSOR cu_otspagos(dtcufechapag DATE) IS
    SELECT L.locoorde orden_trabajo
      ,L.lococaan causal_anterior
      ,L.lococaac causal_actual
      ,L.locoobse observacion
    FROM OPEN.ldc_logcacaorsu L
    WHERE L.locofeca >= dtcufechapag;
    
    nmvaerr NUMBER;
    sbvaerr VARCHAR2(1000);
    nmconta   NUMBER(6);
    nmcontaok NUMBER(6);
    nmcontaer NUMBER(6);
    nuparano  NUMBER(4);
    nuparmes  NUMBER(2);
    nutsess   NUMBER;
    sbparuser VARCHAR2(30);
    
BEGIN
    nmconta   := 0;
    nmcontaok := 0;
    nmcontaer := 0;
    
    SELECT to_number(to_char(sysdate,'YYYY'))
       ,to_number(to_char(sysdate,'MM'))
       ,userenv('SESSIONID')
       ,USER INTO nuparano,nuparmes,nutsess,sbparuser
    FROM dual;
    -- Se inicia log del programa
    
    ldc_proinsertaestaprog(nuparano,nuparmes,'LDC_PRCDEVCAUSOTSPAG','En ejecucion',nutsess,sbparuser);
    
    FOR I IN cu_otspagos(dtpafecha) LOOP
        nmconta := nmconta + 1;
        
        UPDATE or_order ot
         SET ot.causal_id = I.causal_anterior
        WHERE ot.order_id = I.orden_trabajo;
        
        sbvaerr := NULL;
        
        os_addordercomment(
                         I.orden_trabajo
                        ,-1
                        ,'Se reversa la causal por el caso : OSF-297'
                        ,nmvaerr
                        ,sbvaerr
                        );
        IF sbvaerr IS NULL THEN
            nmcontaok := nmcontaok + 1;
            COMMIT;
        ELSE
            nmcontaer := nmcontaer + 1;
            ROLLBACK;
        END IF;
    END LOOP;
    
    COMMIT;
    
    sbvaerr := 'Total registros encontrados : '||to_char(nmconta)||' total registros ok : '||to_char(nmcontaok)||' total registros con error : '||to_char(nmcontaer);    
    ldc_proactualizaestaprog(nutsess,nvl(sbvaerr,'Ok'),'LDC_PRCDEVCAUSOTSPAG','Termino ');

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        sbvaerr := 'Error en : LDC_PRCDEVCAUSOTSPAG : '||SQLCODE||' - '||sqlerrm;
        ldc_proactualizaestaprog(nutsess,nvl(sbvaerr,'Ok'),'LDC_PRCDEVCAUSOTSPAG','ERROR ');
END ldc_prcdevcausotspag;
/
PROMPT Otorgando permisos de ejecucion a ldc_prcdevcausotspag
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PRCDEVCAUSOTSPAG','ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre ldc_prcdevcausotspag para reportes
GRANT EXECUTE ON adm_person.ldc_prcdevcausotspag TO rexereportes;
/