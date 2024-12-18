DECLARE
 nuTab1 number := 0;
BEGIN

 SELECT COUNT(*) INTO nuTab1
 FROM DBA_TABLES
 WHERE TABLE_NAME = 'FACTURAS_TEM';

 if nuTab1 = 0 then
	execute IMMEDIATE 'create table facturas_tem (codigo number, periodo number)';
	
	execute IMMEDIATE 'COMMENT ON COLUMN facturas_tem.codigo IS ''CODIGO DE LA FACTURA''';
	execute IMMEDIATE 'COMMENT ON COLUMN facturas_tem.periodo IS ''PERIODO DE FACTURACION''';
	execute IMMEDIATE 'COMMENT ON TABLE facturas_tem IS ''FACTURAS TEMPORALES A IMPRIMIR''';


  end if;
end;
/
begin
  pkg_utilidades.prAplicarPermisos('FACTURAS_TEM', 'OPEN');
end;
/


