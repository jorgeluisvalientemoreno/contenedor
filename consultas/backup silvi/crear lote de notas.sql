DECLARE

   nulote        number;
   inufactura    number;
   inuciclo       perifact.pefacicl%type;
   inuempresa    lote_fact_electronica.empresa%type;
   onuerror      number;
   osberror      varchar2(4000);
   sesion        number;
   nuidreporte   number;

  CURSOR getNotas is
  SELECT notanume
  FROM notas
  WHERE notanume in (163416120,163416119,163416118);

BEGIN

  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);

  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
  dbms_output.put_line('Lote creado : '||nuLote);
  
  update notas set notafecr = trunc(sysdate) where notanume in (163416120,163416119,163416118);
  
  SELECT DISTINCT susccicl
  INTO inuciclo
  FROM suscripc
  WHERE susccodi in (
  SELECT notasusc
  FROM notas
  WHERE notanume in (163416120,163416119, 163416118) )
  ;


  SELECT distinct empresa
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
              12 ,
              -1 ,
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
             3,
             inuempresa );
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
