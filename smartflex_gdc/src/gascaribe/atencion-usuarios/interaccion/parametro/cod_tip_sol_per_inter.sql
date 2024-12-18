declare

  cursor cuparametroexiste(IsbParametro ld_parameter.parameter_id %type) is
    select count(1)
      from ld_parameter lp
     where lp.parameter_id = IsbParametro;

  nuexisteparametro number;

Begin
  ---------------------------------------------------
  --Parametro COD_TIP_SOL_PER_INTER
  nuexisteparametro := 0;
  open cuparametroexiste('COD_TIP_SOL_PER_INTER');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('COD_TIP_SOL_PER_INTER',
       NULL,
       '545,50,52,100030',
       'CODIGO TIPO SOLICITUD PARA PERMITIR INTERACCION OSF-679');
    commit;
    dbms_output.put_line('Parametro COD_TIP_SOL_PER_INTER creado...');
  else
    dbms_output.put_line('Parametro COD_TIP_SOL_PER_INTER ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
end;
/