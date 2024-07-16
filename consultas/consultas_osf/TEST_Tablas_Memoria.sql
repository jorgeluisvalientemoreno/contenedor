declare

  TYPE rsServicios IS RECORD(
    servicio VARCHAR2(4000));

  TYPE tbServicios IS TABLE OF rsServicios INDEX BY BINARY_INTEGER;

  vtbServicios tbServicios;
  nuIndex      number := 1;
  nuExiste     number := 0;

  cursor cuPRE is
    select t.procesopre servicioPRE
      from open.LDC_PACKAGE_TYPE_OPER_UNIT t
     where t.procesopre is not null
     group by t.procesopre;

  rfPRE cuPRE%rowtype;

  cursor cuPOST is
    select t.procesopost servicioPOST
      from open.LDC_PACKAGE_TYPE_OPER_UNIT t
     where t.procesopost is not null
     group by t.procesopost;

  rfPOST cuPOST%rowtype;

  cursor cuSeparar(sbCadena varchar2) is
    SELECT regexp_substr(sbCadena, '[^.]+', 1, LEVEL) AS column_value
      FROM dual
    CONNECT BY regexp_substr(sbCadena, '[^.]+', 1, LEVEL) IS NOT NULL;

  sbServicio varchar2(4000);

begin

  for rfPRE in cuPRE loop
  
    --dbms_output.put_line('PRE - Servicio Origen: ' || rfPRE.servicioPRE);
    open cuSeparar(rfPRE.servicioPRE);
    fetch cuSeparar
      into sbservicio;
    close cuSeparar;
    --dbms_output.put_line('PRE - Servicio Final: ' || sbservicio);
    /*begin
      --pkg_utilidades.prCrearSinonimos(upper(sbservicio), 'OPEN'); 
      dbms_output.put_line('Servicio ' || upper(sbservicio) ||' con sinonimo Ok.');
    exception
      when others then
        dbms_output.put_line('Servicio ' || upper(sbservicio) ||' - Error: ' || sqlerrm);
    end;*/
  
    nuExiste := 0;
    FOR i IN 1 .. vtbServicios.count LOOP
    
      if vtbServicios(i).servicio = upper(sbservicio) then
        nuExiste := 1;
      end if;
    
    END LOOP;
  
    if nuExiste = 0 then
      vtbServicios(nuIndex).servicio := upper(sbservicio);
      nuIndex := nuIndex + 1;
    end if;
  
  end loop;

  for rfPOST in cuPOST loop
  
    --dbms_output.put_line('POST - Servicio Origen: ' || rfPOST.servicioPOST);
    open cuSeparar(rfPOST.servicioPOST);
    fetch cuSeparar
      into sbservicio;
    close cuSeparar;
    --dbms_output.put_line('POST - Servicio Final: ' || sbservicio);
    /*begin
      --pkg_utilidades.prCrearSinonimos(upper(sbservicio), 'OPEN'); 
      dbms_output.put_line('Servicio ' || upper(sbservicio) ||' con sinonimo Ok.');
    exception
      when others then
        dbms_output.put_line('Servicio ' || upper(sbservicio) ||' - Error: ' || sqlerrm);
    end;*/
  
    nuExiste := 0;
    FOR i IN 1 .. vtbServicios.count LOOP
    
      if vtbServicios(i).servicio = upper(sbservicio) then
        nuExiste := 1;
      end if;
    
    END LOOP;
  
    if nuExiste = 0 then
      vtbServicios(nuIndex).servicio := upper(sbservicio);
      nuIndex := nuIndex + 1;
    end if;
  
  end loop;

  FOR i IN 1 .. vtbServicios.count LOOP
  
    dbms_output.put_line('Servicio ' || vtbServicios(i).servicio);
  
  END LOOP;

end;
