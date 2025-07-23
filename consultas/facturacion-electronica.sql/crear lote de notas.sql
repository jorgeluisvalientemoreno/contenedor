DECLARE

   nulote        number;
   inufactura    number;
   inuciclo       perifact.pefacicl%type;
   inuempresa    lote_fact_electronica.empresa%type;
   onuerror      number;
   osberror      varchar2(4000);
   sesion        number;
   nuidreporte   number;
   inulote       lote_fact_electronica.codigo_lote%type:= 9101;

  CURSOR getNotas is
  SELECT notanume
  FROM notas
  WHERE notanume in (160086636);

begin

  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);

  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
  dbms_output.put_line('Lote creado : '||nuLote);
  
  update notas set notafecr = trunc(sysdate) where notanume in (160086636);
  delete factura_elect_general where codigo_lote in (inulote);
  delete facturas_emitidas  where codigo_lote in (inulote);
  
  SELECT DISTINCT susccicl
  INTO inuciclo
  FROM suscripc
  WHERE susccodi in (
  SELECT notasusc
  FROM notas
  WHERE notanume in (160086636)
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
             1 as CANTIDAD_REGISTRO ,
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

  FOR rec IN getNotas LOOP
    PKG_BOFACTUELECTRONICAGEN.prGenerarEstrFactElec(
      rec.notanume,
      nuLote,
      'I',
      3,
      nuIdReporte,
      inuempresa,
      'N',
      onuError,
      osbError
    );
    DBMS_OUTPUT.PUT_LINE('Factura: ' || rec.notanume || ' - Error: ' || osbError);


END LOOP;



end;
