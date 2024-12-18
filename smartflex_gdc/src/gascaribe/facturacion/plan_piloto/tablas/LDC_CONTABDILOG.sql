DECLARE
 nuTab1 number := 0;
BEGIN

 SELECT COUNT(*) INTO nuTab1
 FROM DBA_TABLES
 WHERE TABLE_NAME = 'LDC_CONTABDILOG';

 if nuTab1 = 0 then
	execute IMMEDIATE 'create table ldc_contabdilog (contact number(15),
                              contold number(15),
                              fecha   date,
                              usuario varchar2(40),
                              terminal  varchar2(100),
                              operacion varchar2(1))';
	execute IMMEDIATE 'comment on column ldc_contabdilog.contact is ''contrato actual''';
	execute IMMEDIATE 'comment on column ldc_contabdilog.contold is ''contrato anterior''';
	execute IMMEDIATE 'comment on column ldc_contabdilog.fecha is ''fecha de registro''';
	execute IMMEDIATE 'comment on column ldc_contabdilog.usuario is ''usuario''';
	execute IMMEDIATE 'comment on column ldc_contabdilog.terminal is ''terminal''';
	execute IMMEDIATE 'comment on column ldc_contabdilog.operacion is ''operacion I- insertar, U - modificar, D- eliminar''';
	execute IMMEDIATE 'comment on table ldc_contabdilog is ''log de contratos para abono de diferido''';
	
	EXECUTE immediate 'grant select, insert, delete, update on ldc_contabdilog to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on ldc_contabdilog to RSELOPEN';
	execute immediate 'grant select on ldc_contabdilog to reportes';
	
  end if;
end;
/