DECLARE

   nulote        number;
   inufactura    number; 
  -- inupefa       perifact.pefacodi%type := 112625;
   inuciclo       perifact.pefacicl%type;
   inuempresa    lote_fact_electronica.empresa%type;
   onuerror      number;
   osberror      varchar2(4000);
   sesion        number;
   nuidreporte   number;
--   inulote       lote_fact_electronica.periodo_facturacion%type:= 17567;
  
  CURSOR getNotas is
  SELECT notanume
  FROM notas
  WHERE notanume in (166382891);

   
begin
  
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  
  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
  dbms_output.put_line('Lote creado : '||nuLote);

 -- update notas set notafecr = trunc(sysdate) where notanume in (163416120,163416119,163416118);
  --delete factura_elect_general where codigo_lote= inulote;

  SELECT DISTINCT susccicl
  INTO inuciclo
  FROM suscripc
  WHERE susccodi in (
  SELECT notasusc
  FROM notas
  WHERE notanume in (166382891) )
  ;

  SELECT distinct empresa
  INTO inuempresa
  FROM ciclo_facturacion
  WHERE ciclo in (inuciclo);
  

   INSERT INTO lote_fact_electronica (
      CODIGO_LOTE,
      PERIODO_FACTURACION,
      ANIO,
      MES,
      CICLO,
      CANTIDAD_REGISTRO,
      CANTIDAD_HILOS,
      HILOS_PROCESADO,
      HILOS_FALLIDO,
      INTENTOS,
      FLAG_TERMINADO,
      FECHA_INICIO,
      FECHA_FIN,
      FECHA_INICIO_PROC,
      FECHA_FIN_PROC,
      TIPO_DOCUMENTO,
      EMPRESA
   ) VALUES (
      nuLote,
      -1,
      inuano,
      inumes,
      -1,
      1,
      4,
      4,
      0,
      0,
      'N',
      SYSDATE,
      SYSDATE,
      NULL,
      NULL,
      1,
      inuempresa
   );
  
  
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
