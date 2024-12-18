declare

  cursor cuparametroexiste(IsbParametro ld_parameter.parameter_id %type) is
    select count(1)
      from ld_parameter lp
     where lp.parameter_id = IsbParametro;

  nuexisteparametro number;

Begin

  nuexisteparametro := 0;
  open cuparametroexiste('LDC_CAUSAL_SUSP_CART');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into ld_parameter
      (parameter_id, numeric_value, value_chain, description)
    values
      ('LDC_CAUSAL_SUSP_CART',
       NULL,
       '9777,3316,9821',
       'CAUSAL DE LEGALIZACION UTILIZADAS POR USUARIOS ESPECIFICOS PARA LEGALIZAR ORDEN OSF-577');
    commit;
    dbms_output.put_line('Parametro LDC_CAUSAL_SUSP_CART creado...');
  else
    dbms_output.put_line('Parametro LDC_CAUSAL_SUSP_CART ya existe...');
  end if;
  close cuparametroexiste;
 
end;
/
