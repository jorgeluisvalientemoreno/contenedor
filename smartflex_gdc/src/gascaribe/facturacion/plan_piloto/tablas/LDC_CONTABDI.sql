DECLARE
 nuTab1 number := 0;
BEGIN

 SELECT COUNT(*) INTO nuTab1
 FROM DBA_TABLES
 WHERE TABLE_NAME = 'LDC_CONTABDI';

 if nuTab1 = 0 then
	execute IMMEDIATE 'create table ldc_contabdi (contrato number(15)  not null)';
	execute IMMEDIATE 'alter table ldc_contabdi add constraint pk_ldc_contabdi primary key(contrato)';
	execute IMMEDIATE 'alter table ldc_contabdi add constraint kk_contabdi_susc foreign key(contrato) references suscripc(susccodi)';
	execute IMMEDIATE 'comment on column ldc_contabdi.contrato is ''contrato''';
	execute IMMEDIATE 'comment on table ldc_contabdi is ''contratos para abono de diferido''';
	
	EXECUTE immediate 'grant select, insert, delete, update on ldc_contabdi to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on ldc_contabdi to RSELOPEN';
	execute immediate 'grant select on ldc_contabdi to reportes';
	
  end if;
end;
/