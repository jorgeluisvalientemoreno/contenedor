column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE
  nuJob NUMBER;
BEGIN
 DBMS_JOB.SUBMIT(nuJob,
        'DECLARE
  CURSOR cugetDatos IS
    WITH tarifaserrorneas AS (
    SELECT v1.idmercadorelevante, v1.anoperiodo, v1.mesperiodo, v1.categoria, v1.subcategoria, v1.concepto, v1.tarifafacturada, v1.tarifaactualizada, v1.diferencia,v0.diferencia  dif_nueva
    FROM OPEN.tmp_tarifas_subs_actualizad_v1 v1, OPEN.tmp_tarifas_subs_actualizadas v0
    WHERE v1.idmercadorelevante = v0.idmercadorelevante
     AND v1.anoperiodo = v0.anoperiodo
     AND v1.mesperiodo = v0.mesperiodo
     AND v1.categoria = v0.categoria
     AND v1.subcategoria = v0.subcategoria
     AND v1.concepto= v0.concepto
     AND v1.diferencia <> v0.diferencia) 
     SELECT P.ROWID id_reg, dif_nueva tarifa_nueva, 
        (decode(signo, ''CR'', -1,1) * round(unidades_liquidadas * dif_nueva,0)) valor_nuevo
     FROM OPEN.tmp_producto_procsub P, tarifaserrorneas T
     WHERE P.anio_tarifa = T.anoperiodo
      AND P.mes_tarifa = T.mesperiodo
      AND P.tarifa_facturada = T.tarifafacturada 
      AND P.tarifa_actualizada = T.tarifaactualizada
      AND P.concepto = T.concepto
      AND P.categoria_tarifa = T.categoria
      AND P.estrato_tarifa = T.subcategoria
      AND P.mercado = T.idmercadorelevante;
   
      TYPE tblSubsidioOTT  IS TABLE OF cugetDatos%ROWTYPE;
   v_tblSubsidioOTT   tblSubsidioOTT;
   
   errors NUMBER;
   dml_errors EXCEPTION;
   PRAGMA EXCEPTION_INIT(dml_errors, -24381);
   nuIdReporte  number;
   nuConsecutivo NUMBER := 0;
   NUERROR NUMBER;
   sberror varchar2(4000);
   sbProceso varchar2(4000) := ''LLENAPRSU''||to_char(sysdate, ''ddmmyyyyhh24miss'');
      
  BEGIN
    pkg_estaproc.prinsertaestaproc( sbProceso , 0);
    nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( ''LLENAPRSU'',
                                                        ''Job que llena informacion de subsidio'');
  
   dbms_output.put_line('' nuIdReporte => '' || nuIdReporte);
   OPEN cugetDatos;
   LOOP
 	FETCH cugetDatos BULK COLLECT INTO v_tblSubsidioOTT LIMIT 100;
      BEGIN
          FORALL i IN v_tblSubsidioOTT.FIRST..v_tblSubsidioOTT.LAST SAVE EXCEPTIONS
              UPDATE tmp_producto_procsub SET DIFERENCIA = v_tblSubsidioOTT(i).tarifa_nueva, VALOR_AJUSTE = v_tblSubsidioOTT(i).VALOR_NUEVO
              WHERE rowid =  v_tblSubsidioOTT(i).id_reg; 
      EXCEPTION
        WHEN dml_errors THEN
          errors := SQL%BULK_EXCEPTIONS.COUNT;
          FOR i IN 1..errors LOOP
             nuConsecutivo := nuConsecutivo + 1;
             pkg_reportes_inco.prCrearDetalleRepo( nuIdReporte,
                                                   SQL%BULK_EXCEPTIONS(i).ERROR_INDEX,
                                                   ''Error #''|| i || '' occurred during ''||SQLERRM(-SQL%BULK_EXCEPTIONS(i).ERROR_CODE),
                                                   ''S'',
                                                   nuConsecutivo );
          END LOOP;
       END;
       COMMIT;
    EXIT   WHEN cugetDatos%NOTFOUND;
   END LOOP;
  CLOSE cugetDatos;
  COMMIT;
   pkg_estaproc.practualizaestaproc(isbproceso => sbProceso);
EXCEPTION    
  WHEN pkg_Error.Controlled_Error  THEN
        pkg_error.getError(nuError,sbError);
        dbms_output.put_line('' sbError => '' || sbError);
        pkg_estaproc.practualizaestaproc( sbProceso, ''Error '', sbError  );
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_error.getError(nuError,sbError);
        dbms_output.put_line('' sbError => '' || sbError);
        pkg_estaproc.practualizaestaproc( sbProceso, ''Error '', sbError  );
END;',
    SYSDATE);
 COMMIT;
 DBMS_OUTPUT.PUT_LINE(' nuJob '||nuJob);
END;
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/
