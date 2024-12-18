DECLARE
 nuTab1 number := 0;
BEGIN

 SELECT COUNT(*) INTO nuTab1
 FROM DBA_TABLES
 WHERE TABLE_NAME = 'LDC_CONTANVE';

 if nuTab1 = 0 then
	execute IMMEDIATE 'create table ldc_contanve( contpadre number(15),
							   contanul  number(15))';
	execute IMMEDIATE 'alter table ldc_contanve add constraint pk_ldc_contanve primary key (contanul)';
	execute IMMEDIATE 'create index idx_con02contanve on ldc_contanve (contpadre)';
	execute IMMEDIATE 'create index idx_con03contanve on ldc_contanve (contanul, contpadre)';
	execute IMMEDIATE 'comment on column ldc_contanve.contpadre is ''contrato padre''';
	execute IMMEDIATE 'comment on column ldc_contanve.contanul is ''contrato anular venta''';
	execute IMMEDIATE 'comment on table ldc_contanve is ''contrato para anular venta''';
	EXECUTE immediate 'grant select, insert, delete, update on ldc_contanve to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on ldc_contanve to RSELOPEN';
	execute immediate 'grant select on ldc_contanve to reportes';
  end if;

	EXECUTE immediate 'grant select, insert, delete, update on ldc_contanve to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on ldc_contanve to RSELOPEN';
	execute immediate 'grant select on ldc_contanve to reportes';
end;
/


