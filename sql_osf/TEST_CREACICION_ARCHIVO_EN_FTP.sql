declare

  gsbRutaDirectorio ge_directory.PATH%TYPE;
  nuiddirectorio    number := 1034;
  isbRuta           ge_directory.PATH%TYPE := '/smartfiles/tmp'; -- pkg_BCDirectorios.fsbGetRuta(nuiddirectorio);

  gsbNombArchAnexoA VARCHAR2(250);

  inuAno number := 2026;
  inuMes number := 2;

  isbEmpresa VARCHAR2(50) := 'GDCA';

  gflArchivoAnexoA pkg_gestionArchivos.styArchivo;

  gsbLineaDeta VARCHAR2(2000);

  cursor cudata is
    select distinct nvl(a.identification, 0) Identificacion,
                    nvl(a.subscriber_name, 'SIN NOMBRE') || ' ' ||
                    nvl(a.subs_last_name, 'SIN APELLIDO') Nombre,
                    aa.address Direccion,
                    loca.description Localidad,
                    depa.description Departamento
      from OPEN.GE_SUBSCRIBER a
     inner join OPEN.AB_ADDRESS aa
        on a.address_id = aa.address_id
       and (upper(aa.address) like '%GENERICA%' or
           upper(aa.address) like '%KR NO EXISTE CL NO EXISTE%')
     inner join OPEN.GE_GEOGRA_LOCATION loca
        on loca.geograp_location_id = aa.geograp_location_id
     inner join OPEN.GE_GEOGRA_LOCATION depa
        on depa.geograp_location_id = loca.geo_loca_father_id
     where not exists (select ss.susccodi
              from OPEN.SUSCRIPC ss
             where ss.suscclie = a.subscriber_id);

  rfData cuData%rowtype;

begin

  dbms_output.put_line(sysdate);

  --Ruta FTP para alojar archivo
  gsbRutaDirectorio := TRIM(isbRuta) || '/';
  dbms_output.put_line('Ruta: ' || gsbRutaDirectorio);

  --Nombre archivo
  /*gsbNombArchAnexoA := 'Formato_' || inuAno || '_' || inuMes || '_' ||
  TO_CHAR(SYSDATE, 'YYYY_MM_DD_HH_MI_SS') || '_' ||
  isbEmpresa || '.csv';*/
  gsbNombArchAnexoA := 'clientes_sin_contrato_con_direccion_dummy.csv';

  dbms_output.put_line('Archivo: ' || gsbNombArchAnexoA);

  dbms_output.put_line('Inicia Apertura y creacion Archivo FTP');
  gflArchivoAnexoA := pkg_gestionArchivos.ftAbrirArchivo_SMF(gsbRutaDirectorio,
                                                             gsbNombArchAnexoA,
                                                             'W');
  gsbLineaDeta     := 'IDENTIFICACION,NOMBRE,DIRECCION,LOCALIDAD,DEPARTAMENTO';
  pkg_gestionArchivos.prcEscribirLinea_SMF(gflArchivoAnexoA, gsbLineaDeta);

  for rfData in cuData loop
  
    --dbms_output.put_line('Inicia Apertura y creacion Archivo FTP');
    gsbLineaDeta := trim(rfData.Identificacion) || ',' ||
                    trim(rfData.Nombre) || ',' || trim(rfData.Direccion) || ',' ||
                    trim(rfData.Localidad) || ',' ||
                    trim(rfData.Departamento);
    pkg_gestionArchivos.prcEscribirLinea_SMF(gflArchivoAnexoA,
                                             gsbLineaDeta);
  
  end loop;

  -- Cierra archivo de impresion
  pkg_gestionArchivos.prcCerrarArchivo_SMF(gflArchivoAnexoA);
  dbms_output.put_line('Finaliza Apertura y creacion Archivo FTP');

  dbms_output.put_line(sysdate);

end;
