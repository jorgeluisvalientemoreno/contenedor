declare

  cursor cuparametroexiste(IsbParametro ld_parameter.parameter_id %type) is
    select count(1)
      from ld_parameter lp
     where lp.parameter_id = IsbParametro;

  nuexisteparametro number;

Begin
  ---------------------------------------------------
  --Parametro COD_SOL_EST_REGISTRADA_100225
  nuexisteparametro := 0;
  open cuparametroexiste('COD_SOL_EST_REGISTRADA_100225');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('COD_SOL_EST_REGISTRADA_100225',
       NULL,
       '100225,100237,100262,100295',
       'CODIGO DE SOLICITUDES EN ESTADO REGISTRADAS - SEPARADOR COMA(,) OSF-445');
    commit;
    dbms_output.put_line('Parametro COD_SOL_EST_REGISTRADA_100225 creado...');
  else
    dbms_output.put_line('Parametro COD_SOL_EST_REGISTRADA_100225 ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
end;
/
