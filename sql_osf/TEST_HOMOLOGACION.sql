declare

  sbObjeto varchar2(4000) := upper('pkg_bogopcvnel');

  cursor cuHomologaciones is
    select servicio_origen, servicio_destino
      from homologacion_servicios
     where servicio_origen is not null
     group by servicio_origen, servicio_destino;

  rfcuHomologaciones cuHomologaciones%rowtype;

  cursor cuCodigoFuente is
    select trim(ds.TEXT) TEXT
      from dba_source ds
     where upper(ds.name) = upper(sbObjeto);

  rfcuCodigoFuente cuCodigoFuente%rowtype;

  --EsquemaOPEN         varchar2(100) := 'OPEN.';
  --ContadorEsquemaOPEN number := 0;
  --ExisteEsquemaOPEN   boolean;

  --EsquemaADM_PERSON         varchar2(100) := 'ADM_PERSON.';
  --ContadorEsquemaADM_PERSON number := 0;
  --ExisteEsquemaADM_PERSON   boolean;

  --EsquemaPERSONALIZACIONES         varchar2(100) := 'PERSONALIZACIONES.';
  --ContadorEsquemaPERSONALIZACIONES number := 0;
  --ExisteEsquemaPERSONALIZACIONES   boolean;

  CaracterInterrogacion1 varchar2(100) := '?';
  ContadorInterrogacion1 number := 0;
  ExisteInterrogacion1   boolean;

  ContadorHomologacion number := 0;
  ExisteHomologacion   boolean;

begin

  --Homologaciones
  ExisteHomologacion := false;
  for rfcuCodigoFuente in cuCodigoFuente loop
    --dbms_output.put_line(rfcuCodigoFuente.TEXT);
  
    --/*
    for rfcuHomologaciones in cuHomologaciones loop
    
      --Valida Homologacion
      select INSTR(upper(rfcuCodigoFuente.TEXT),
                   upper(rfcuHomologaciones.servicio_origen))
        into ContadorHomologacion
        from dual;
    
      --dbms_output.put_line(rfcuHomologaciones.servicio_origen);
      --dbms_output.put_line('Contrador ' || ContadorHomologacion);
    
      --/*
      if (nvl(ContadorHomologacion, 0) <> 0) then
        dbms_output.put_line('Reemplazar ' ||
                             rfcuHomologaciones.servicio_origen || ' - ' ||
                             rfcuHomologaciones.servicio_destino);
      end if;
      --*/
    -------------------------------------
    
    end loop;
    --*/
  
    if ExisteHomologacion then
      exit;
    end if;
  
  end loop;

end;
