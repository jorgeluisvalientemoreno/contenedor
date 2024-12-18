declare

  cursor cuparametroexiste(IsbParametro LDC_PARAREPE.PARECODI %type) is
    select count(1)
      from LDC_PARAREPE lp
     where lp.PARECODI = IsbParametro;

  nuexisteparametro number;

Begin
  ---------------------------------------------------
  --Parametro CANT_CTA_SALDO_RESTR_RECON
  nuexisteparametro := 0;
  open cuparametroexiste('CANT_CTA_SALDO_RESTR_RECON');
  fetch cuparametroexiste
    into nuexisteparametro;
  if nuexisteparametro = 0 then
    insert into LDC_PARAREPE
      (PARECODI,PARADESC,PAREVANU,PARAVAST)
    values
      ('CANT_CTA_SALDO_RESTR_RECON',
       'CANTIDAD DE CUENTA CON SALDO PARA RESTRINGIR RECONEXION OSF-479',
       3,
       NULL);
    commit;
    dbms_output.put_line('Parametro para RP - CANT_CTA_SALDO_RESTR_RECON creado...');
  else
    dbms_output.put_line('Parametro para RP - CANT_CTA_SALDO_RESTR_RECON ya existe...');
  end if;
  close cuparametroexiste;
  ---------------------------------------------------
end;
/
