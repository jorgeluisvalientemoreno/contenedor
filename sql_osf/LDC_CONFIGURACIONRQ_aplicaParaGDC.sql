declare

  isbDesarrollo open.ldc_confrequ.requerimiento%type := 'CRM_JLVM_CAMBIO_8744';

  sbNit        open.ldc_confrequ.nit_efi%type;
  sbNitSistema open.sistema.sistnitc%type;

  nuErrorCode    NUMBER;
  sbErrorMessage VARCHAR2(4000);

  CURSOR cuGasera IS
    select nit_gdc
      from open.ldc_confrequ
     where requerimiento = isbDesarrollo;

  Cursor cuSistema(isbNit open.sistema.sistnitc%type) IS
    select SISTNITC from open.sistema where SISTNITC = isbNit;

BEGIN
  open cuGasera;
  fetch cuGasera
    into sbNit;
  close cuGasera;

  if sbNit is not null then
  
    open cuSistema(sbNit);
    fetch cuSistema
      into sbNitSistema;
    close cuSistema;
  
    if sbNitSistema is not null then
      dbms_output.put_line('return true');
    end if;
  end if;

  dbms_output.put_line('return false');

end;
