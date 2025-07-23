DECLARE

   nulote        number;
   inufactura    number; 
   inupefa       perifact.pefacodi%type := 116674;
   inuempresa    lote_fact_electronica.empresa%type;
   onuerror      number;
   osberror      varchar2(4000);
   sesion        number;
   nuidreporte   number;
   inulote        number := 9291;
  
  CURSOR getFactura is
  SELECT factcodi
  FROM factura
  WHERE factpefa = inupefa
  AND factprog=6;
   
begin
  
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  
  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
  dbms_output.put_line('Lote creado : '||nuLote);
  
 delete factura_elect_general where codigo_lote in (inulote);
 delete facturas_emitidas  where codigo_lote in (inulote);
 update lote_fact_electronica  l set periodo_facturacion = -1 where  codigo_lote = inulote;
 update ldc_pecofact l set pcfaobse = null where l.pcfapefa= inupefa;
 update factura set factfege = trunc(sysdate) where factpefa= inupefa and factprog= 6 ; 
 
  SELECT empresa
  INTO inuempresa
  FROM ciclo_facturacion
  WHERE ciclo = (select pefacicl 
                 from perifact 
                 where pefacodi= inupefa);
  
  Insert into lote_fact_electronica
     select  nuLote CODIGO_LOTE ,
             inupefa ,
             ANIO ,
             MES ,
             CICLO ,
             CANTIDAD_REGISTRO ,
             CANTIDAD_HILOS ,
             HILOS_PROCESADO ,
             HILOS_FALLIDO ,
             INTENTOS ,
             'S' FLAG_TERMINADO ,
             SYSDATE FECHA_INICIO ,
             SYSDATE FECHA_FIN ,
             null FECHA_INICIO_PROC ,
             null FECHA_FIN_PROC,
             TIPO_DOCUMENTO,
            inuempresa
    from PERSONALIZACIONES.lote_fact_electronica        
    where CODIGO_LOTE = inulote ;
  
  nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                          'Job de facturacion electronica recurrente');
  
  FOR rec IN getFactura LOOP
    PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec(
      rec.factcodi,
      nuLote,
      'I',
      1,
      nuIdReporte,
      inuempresa,
      'N',
      onuError,
      osbError
    );
    DBMS_OUTPUT.PUT_LINE('Factura: ' || rec.factcodi || ' - Error: ' || osbError);

  
END LOOP;
   
end;
