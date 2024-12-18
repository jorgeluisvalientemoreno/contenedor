column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
    nuLote              NUMBER;
    nuError             NUMBER;
    sbError             VARCHAR2(4000);
    sesion              NUMBER;
    nuIdReporte         NUMBER; 
    nuTipoDocumento     NUMBER:=1;
    nuCantiExitosas     NUMBER:=0;
  
  cursor cuFacturas is
  select factcodi
  from open.factura
 where factpefa = 113635
   and factfege >= '23/09/2024'
   and factprog = 6
   and not exists(select null from personalizaciones.facturas_emitidas d where d.documento=factcodi);

begin
    nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
    dbms_output.put_line('Lote creado : '||nuLote);
  Insert into lote_fact_electronica 
         select  nuLote CODIGO_LOTE ,
                113635 PERIODO_FACTURACION ,
                2024 ANIO ,
                9 MES ,
                2401 CICLO ,
                38 CANTIDAD_REGISTRO ,
                4 CANTIDAD_HILOS ,
                4 HILOS_PROCESADO ,
                0 HILOS_FALLIDO ,
                0 INTENTOS ,
                'N' FLAG_TERMINADO ,
                SYSDATE FECHA_INICIO ,
                SYSDATE FECHA_FIN ,
                null FECHA_INICIO_PROC ,
                null FECHA_FIN_PROC,
                1 TIPO_DOCUMENTO
        from DUAL;
    commit;
    select SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
    ut_trace.setlevel(99);
    dbms_output.put_line(sesion);
  
    nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                          'Job de facturacion electronica recurrente');
    dbms_output.put_line('factura|error');
    nuCantiExitosas := 0;
    for reg in cuFacturas loop
        nuError :=0 ;
        sbError :='';
        update factura 
           set factfege=sysdate
        where factcodi=reg.factcodi;
        
        PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec( reg.factcodi,
                                nuLote,
                                'I',
                                nuTipoDocumento,
                                nuIdReporte,
                                nuError,
                                sbError );
        dbms_output.put_line(reg.factcodi||'|'||sbError);
        if nuError = 0 then
            commit;
            nuCantiExitosas:=nuCantiExitosas+1;
        else
            rollback;
        end if;
    end loop;
    if nuCantiExitosas = 38 then
        UPDATE OPEN.lote_fact_electronica 
           SET FLAG_TERMINADO = 'S' 
         WHERE codigo_lote = nuLote
           AND TRUNC(FECHA_INICIO) = TRUNC(SYSDATE);
         COMMIT;
    else
        dbms_output.put_line('No se actualiza flag de terminado solo hay '||nuCantiExitosas);
    end if;
exception
  when others then
    pkg_error.setError();
    rollback;
    pkg_error.getError(nuError, sbError);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/