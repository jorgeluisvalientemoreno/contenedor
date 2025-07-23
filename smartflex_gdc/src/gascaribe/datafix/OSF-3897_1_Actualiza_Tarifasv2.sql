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
  with TarifasErrorneas AS (
    select v1.IDMERCADORELEVANTE, v1.ANOPERIODO, v1.MESPERIODO, v1.CATEGORIA, v1.SUBCATEGORIA, v1.CONCEPTO, v1.TARIFAFACTURADA, v1.TARIFAACTUALIZADA, v1.DIFERENCIA,v0.DIFERENCIA  dif_nueva
    from open.tmp_tarifas_subs_actualizad_v1 v1, open.tmp_tarifas_subs_actualizadas v0
    where v1.IDMERCADORELEVANTE = v0.IDMERCADORELEVANTE
     and v1.ANOPERIODO = v0.ANOPERIODO
     and v1.MESPERIODO = v0.MESPERIODO
     and v1.CATEGORIA = v0.CATEGORIA
     and v1.SUBCATEGORIA = v0.SUBCATEGORIA
     and v1.CONCEPTO= v0.CONCEPTO
     and v1.DIFERENCIA <> v0.DIFERENCIA) 
     select P.rowid id_reg, DIF_NUEVA tarifa_nueva,  (DECODE(SIGNO, ''CR'', -1,1) * ROUND(UNIDADES_LIQUIDADAS * DIF_NUEVA,0)) VALOR_NUEVO
     from open.TMP_PRODUCTO_PROCSUB P, TarifasErrorneas T
     where P.ANIO = T.ANOPERIODO
      AND P.MES = T.MESPERIODO
      AND P.TARIFA_FACTURADA = T.TARIFAFACTURADA 
      AND P.TARIFA_ACTUALIZADA = T.TARIFAACTUALIZADA
      AND P.CONCEPTO = T.CONCEPTO
      AND P.CATEGORIA_PRODUCTO = T.CATEGORIA
      AND  P.ESTRATO_PRODUCTO = T.SUBCATEGORIA
      AND P.MERCADO = T.IDMERCADORELEVANTE;
       TYPE tblSubsidioOTT  IS TABLE OF cugetDatos%ROWTYPE;
   v_tblSubsidioOTT   tblSubsidioOTT;
   
   errors NUMBER;
   dml_errors EXCEPTION;
   PRAGMA EXCEPTION_INIT(dml_errors, -24381);
   nuIdReporte  number;
   nuConsecutivo NUMBER := 0;
   NUERROR NUMBER;
   sberror varchar2(4000);
      
  BEGIN
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
EXCEPTION    
  WHEN pkg_Error.Controlled_Error  THEN
        pkg_error.getError(nuError,sbError);
        dbms_output.put_line('' sbError => '' || sbError);
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_error.getError(nuError,sbError);
        dbms_output.put_line('' sbError => '' || sbError);
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