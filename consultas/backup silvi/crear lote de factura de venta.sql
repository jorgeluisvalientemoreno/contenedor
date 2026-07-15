DECLARE

   nulote        number;
   inufactura    number;
   inuciclo       perifact.pefacicl%type;
   inuempresa    lote_fact_electronica.empresa%type;
   onuerror      number;
   osberror      varchar2(4000);
   sesion        number;
   nuidreporte   number;
   inulote       lote_fact_electronica.codigo_lote%type:= 14589;

  CURSOR getFactura is
  SELECT factcodi
  FROM factura
  WHERE factcodi in (2153762413);

begin

  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);

  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
  dbms_output.put_line('Lote creado : '||nuLote);
  
  update factura set factfege = trunc(sysdate) where factcodi in (2153762413);
  delete factura_elect_general where codigo_lote in (inulote);
  delete facturas_emitidas  where codigo_lote in (inulote);
  
  SELECT DISTINCT susccicl
  INTO inuciclo
  FROM suscripc
  WHERE susccodi in (
  SELECT factsusc
  FROM factura
  WHERE factcodi in (2153762413)
  );


  SELECT empresa
  INTO inuempresa
  FROM ciclo_facturacion
  WHERE ciclo in (inuciclo);
  
  DBMS_OUTPUT.PUT_LINE('Empresa: ' || inuempresa || ' - Error: ' || osbError);
  
  Insert into lote_fact_electronica
     select  nuLote CODIGO_LOTE ,
             -1 periodo_facturacion ,
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
             inuempresa EMPRESA
    from PERSONALIZACIONES.lote_fact_electronica
    where CODIGO_LOTE = inulote ;

  nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'JOBFAELGE',
                                                          'Job de facturacion electronica recurrente');

  FOR rec IN getFactura LOOP
    PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec(
      rec.factcodi,
      nuLote,
      'I',
      2,
      nuIdReporte,
      inuempresa,
      'N',
      onuError,
      osbError
    );
    DBMS_OUTPUT.PUT_LINE('Factura: ' || rec.factcodi || ' - Error: ' || osbError);


END LOOP;



end;
