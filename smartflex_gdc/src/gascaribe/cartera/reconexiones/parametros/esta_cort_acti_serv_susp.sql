declare

  cursor cuparametroexiste(IsbParametro ld_parameter.parameter_id %type) is
    select count(1)
      from ld_parameter lp
     where lp.parameter_id = IsbParametro;

  nuexisteparametro number;

Begin
  ---------------------------------------------------
  nuexisteparametro := 0;
  open cuparametroexiste('ESTA_CORT_ACTI_SERV_SUSP');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('ESTA_CORT_ACTI_SERV_SUSP',
       NULL,
       '3',
       'ESTADO CORTE ACTIVA SERVICIO SUSPENDIDO - SEPARADOR COMA(,)');
    commit;
    dbms_output.put_line('Parametro ESTA_CORT_ACTI_SERV_SUSP creado...');
  else
    dbms_output.put_line('Parametro ESTA_CORT_ACTI_SERV_SUSP ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
end;
/
