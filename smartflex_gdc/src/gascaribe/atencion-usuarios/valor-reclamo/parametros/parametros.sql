declare

  cursor cuparametroexiste(IsbParametro ld_parameter.parameter_id %type) is
    select count(1)
      from ld_parameter lp
     where lp.parameter_id = IsbParametro;

  nuexisteparametro number;

Begin
  ---------------------------------------------------
  --Parametro RECLAMO_UNICO
  nuexisteparametro := 0;
  open cuparametroexiste('RECLAMO_UNICO');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('RECLAMO_UNICO',
       NULL,
       'N',
       'INDICA LA CREACION DEL TRAMITE DE RECLAMO S(RECLAMO UNICO) o N(RECLAMO POR CUENTA DE COBRO) OSF-96');
    commit;
    dbms_output.put_line('Parametro RECLAMO_UNICO creado...');
  else
    dbms_output.put_line('Parametro RECLAMO_UNICO ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
  ---------------------------------------------------
  --Parametro CATEGORIA_RECLAMO
  nuexisteparametro := 0;
  open cuparametroexiste('CATEGORIA_RECLAMO');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('CATEGORIA_RECLAMO',
       NULL,
       '-1',
       'CATEGORIA A VALIDAR EN RECLAMO SEPARADOR POR COMA(,) OSF-96');
    commit;
    dbms_output.put_line('Parametro CATEGORIA_RECLAMO creado...');
  else
    dbms_output.put_line('Parametro CATEGORIA_RECLAMO ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
  ---------------------------------------------------
  --Parametro CONSUMO_SUBSIDIO_RECLAMO
  nuexisteparametro := 0;
  open cuparametroexiste('CONSUMO_SUBSIDIO_RECLAMO');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('CONSUMO_SUBSIDIO_RECLAMO',
       NULL,
       '-1',
       'CONSUMO Y SUBSIDIO SEPARADOR POR PIPE FORMATO CONSUMO1,SUBSIDIO1|CONSUMON,SUBSIDION OSF-96');
    commit;
    dbms_output.put_line('Parametro CONSUMO_SUBSIDIO_RECLAMO creado...');
  else
    dbms_output.put_line('Parametro CONSUMO_SUBSIDIO_RECLAMO ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------  
  ---------------------------------------------------
  --Parametro COD_CONSUMO_RESCREG048
  nuexisteparametro := 0;
  open cuparametroexiste('COD_CONSUMO_RESCREG048');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('COD_CONSUMO_RESCREG048',
       -1,
       null,
       'CODIGO DEL CONSUMO DE CONSUMO RESCREG048 OSF-96');
    commit;
    dbms_output.put_line('Parametro COD_CONSUMO_RESCREG048 creado...');
  else
    dbms_output.put_line('Parametro COD_CONSUMO_RESCREG048 ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
  --Parametro COD_CARGDOSO_SUBSIDIO
  nuexisteparametro := 0;
  open cuparametroexiste('COD_CARGDOSO_SUBSIDIO');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('COD_CARGDOSO_SUBSIDIO',
       null,
       'YY',
       'CODIGO INICIALES DEL DOCUMENTO CREADO PARA EL SUBSIDIO OSF-96');
    commit;
    dbms_output.put_line('Parametro COD_CARGDOSO_SUBSIDIO creado...');
  else
    dbms_output.put_line('Parametro COD_CARGDOSO_SUBSIDIO ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
  --Parametro COD_CARGDOSO_CONSUMO
  nuexisteparametro := 0;
  open cuparametroexiste('COD_CARGDOSO_CONSUMO');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('COD_CARGDOSO_CONSUMO',
       null,
       'YY',
       'CODIGO INICIALES DEL DOCUMENTO CREADO PARA EL CONSUMO OSF-96');
    commit;
    dbms_output.put_line('Parametro COD_CARGDOSO_CONSUMO creado...');
  else
    dbms_output.put_line('Parametro COD_CARGDOSO_CONSUMO ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------

end;
/