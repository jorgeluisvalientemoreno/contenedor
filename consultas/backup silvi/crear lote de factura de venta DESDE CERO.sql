DECLARE

   nulote        number;
   inufactura    number;
   inuciclo       perifact.pefacicl%type;
   inuempresa    lote_fact_electronica.empresa%type;
   onuerror      number;
   osberror      varchar2(4000);
   sesion        number;
   nuidreporte   number;

  CURSOR getFactura is
  SELECT factcodi
  FROM factura
  WHERE factcodi in (2153989565);

begin

  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);

  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
  dbms_output.put_line('Lote creado : '||nuLote);
  
/*  update factura set factfege = trunc(sysdate) where factcodi in (2153762413);
  delete factura_elect_general where documento in (2153989565);
  delete facturas_emitidas  where documento in (2153989565);*/
  
  SELECT DISTINCT susccicl
  INTO inuciclo
  FROM suscripc
  WHERE susccodi in (
  SELECT factsusc
  FROM factura
  WHERE factcodi in (2153989565)
  );


  SELECT empresa
  INTO inuempresa
  FROM ciclo_facturacion
  WHERE ciclo in (inuciclo);
  
  DBMS_OUTPUT.PUT_LINE('Empresa: ' || inuempresa || ' - Error: ' || osbError);
  
  Insert into lote_fact_electronica (codigo_lote, 
        periodo_facturacion, 
        anio, 
        mes, 
        ciclo, 
        cantidad_registro, 
        cantidad_hilos, 
        hilos_procesado, 
        hilos_fallido, 
        intentos, 
        flag_terminado, 
        fecha_inicio, 
        fecha_fin, 
        fecha_inicio_proc, 
        fecha_fin_proc, 
        tipo_documento, 
        empresa
        ) 
   VALUES(
              nuLote  ,
              -1  ,
              2025 ,
              7 ,
              inuciclo ,
              1 ,
              4  ,
              4 ,
              0 ,
              0  ,
             'S'  ,
             SYSDATE ,
             SYSDATE ,
             null  ,
             null ,
             2,
             inuempresa );

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
      'S',
      onuError,
      osbError
    );
    DBMS_OUTPUT.PUT_LINE('Factura: ' || rec.factcodi || ' - Error: ' || osbError);


END LOOP;



end;
