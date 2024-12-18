declare

  cursor cuparametroexiste(IsbParametro LD_PARAMETER.PARAMETER_ID %type) is
    select count(1)
      from LD_PARAMETER lp
     where lp.PARAMETER_ID = IsbParametro;

  nuexisteparametro number;

Begin
  ---------------------------------------------------
  --Parametro CANT_CTA_SALDO_RESTR_RECON
  nuexisteparametro := 0;
  open cuparametroexiste('COD_RETORNO_FORMA_CPTCB');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into LD_PARAMETER
      (PARAMETER_ID,DESCRIPTION,NUMERIC_VALUE,VALUE_CHAIN)
    values
      ('COD_RETORNO_FORMA_CPTCB',
       'CODIGO RETORNO PARA BLOQUEAR CREACION DE PRODUCTO A UN CONTRATO. OSF-577',
       6,
       NULL);
    commit;
    dbms_output.put_line('Parametro - COD_RETORNO_FORMA_CPTCB creado...');
  else
    dbms_output.put_line('Parametro - COD_RETORNO_FORMA_CPTCB ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
end;
/