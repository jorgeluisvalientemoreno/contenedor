DECLARE
 nuTab1 number := 0;
BEGIN

 SELECT COUNT(*) INTO nuTab1
 FROM DBA_TABLES
 WHERE TABLE_NAME = 'LDC_BI_PROC_CRITICA_CONSUMO';

 if nuTab1 = 0 then
	execute IMMEDIATE ' create table LDC_BI_PROC_CRITICA_CONSUMO(
					  idperiodoconsumo number(15),
					  idproducto       number(15),
					  idorden          number(15),
					  consumo          number(15),
					  idreglacritica   number(5),
					  reglacritica     varchar2(200),
					  flagprocesado    varchar2(1),
					  msgerror         varchar2(2000))';
	execute IMMEDIATE 'CREATE INDEX idxcon02_PROC_CRITICA_CONSUMO on LDC_BI_PROC_CRITICA_CONSUMO(IDPERIODOCONSUMO, IDORDEN, FLAGPROCESADO)';
	execute IMMEDIATE 'CREATE INDEX idxcon_PROC_CRITICA_CONSUMO on LDC_BI_PROC_CRITICA_CONSUMO(IDPERIODOCONSUMO, FLAGPROCESADO)';

	execute IMMEDIATE 'comment on table LDC_BI_PROC_CRITICA_CONSUMO  is ''Tabla que se alimenta desde el DWH para legalizar masivamente ordenes de critica de consumo''';
	execute IMMEDIATE 'comment on column LDC_BI_PROC_CRITICA_CONSUMO.idperiodoconsumo  is ''Periodo de Consumo''';
	execute IMMEDIATE 'comment on column LDC_BI_PROC_CRITICA_CONSUMO.idproducto  is ''Producto''';
	execute IMMEDIATE 'comment on column LDC_BI_PROC_CRITICA_CONSUMO.idorden  is ''Orden de trabajo de Critica''';
	execute IMMEDIATE 'comment on column LDC_BI_PROC_CRITICA_CONSUMO.idreglacritica  is ''Id Regla por la cual se Calculo consumo en BI''';
	execute IMMEDIATE 'comment on column LDC_BI_PROC_CRITICA_CONSUMO.reglacritica  is ''Descripcion de Regla''';
	execute IMMEDIATE 'comment on column LDC_BI_PROC_CRITICA_CONSUMO.flagprocesado  is ''Registro Procesado con Exito S/N''';
	execute IMMEDIATE 'comment on column LDC_BI_PROC_CRITICA_CONSUMO.msgerror  is ''Mensaje de Error si no es procesado con exito''';
	
	EXECUTE immediate 'grant select, insert, delete, update on LDC_BI_PROC_CRITICA_CONSUMO to SYSTEM_OBJ_PRIVS_ROLE';
	execute immediate 'grant select on LDC_BI_PROC_CRITICA_CONSUMO to RSELOPEN';
	execute immediate 'grant select on LDC_BI_PROC_CRITICA_CONSUMO to reportes';
  end if;
end;
/


