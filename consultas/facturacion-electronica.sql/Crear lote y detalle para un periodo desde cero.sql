DECLARE

   nulote        number;
   inufactura    number; 
   inupefa       perifact.pefacodi%type := 117531;
   inuempresa    lote_fact_electronica.empresa%type;
   onuerror      number;
   osberror      varchar2(4000);
   sesion        number;
   nuidreporte   number;
   inuciclo      perifact.pefacicl%type ;
   inuano        perifact.pefaano%type ; 
   inumes        perifact.pefames%type ; 
   
  
  CURSOR getFactura is
  SELECT factcodi
  FROM factura
  WHERE factpefa = inupefa
  AND factprog=6 and factsusc= 67690206 ; --factcodi
   
begin
  
  SELECT SYS_CONTEXT ('USERENV', 'SESSIONID') into sesion FROM DUAL ;
  ut_trace.setlevel(99);
  dbms_output.put_line(sesion);
  
  nuLote := personalizaciones.SEQ_LOTE_FACT_ELECTRONICA.NEXTVAL;
  dbms_output.put_line('Lote creado : '||nuLote);
  update factura set factfege = trunc(sysdate) where factcodi in (2147621292);

  SELECT empresa
  INTO inuempresa
  FROM ciclo_facturacion
  WHERE ciclo = (select pefacicl 
                 from perifact 
                 where pefacodi= inupefa);

  SELECT pefaano , pefames, pefacicl 
  INTO inuano , inumes , inuciclo
  FROM perifact 
  WHERE pefacodi= inupefa;
                 
                 
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
      inupefa,
      inuano,
      inumes,
      inuciclo,
      1,
      4,
      4,
      0,
      0,
      'S',
      SYSDATE,
      SYSDATE,
      NULL,
      NULL,
      1,
      inuempresa
   );
  
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
