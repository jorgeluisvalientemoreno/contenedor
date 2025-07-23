DECLARE
 nuConta NUMBER;

BEGIN
  SELECT COUNT(*) INTO nuConta
  FROM dba_tab_columns
  WHERE table_name = 'TMP_PRODUCTO_PROCSUB'
  AND column_name = 'MARCA_SUBSIDIO'; 

  IF nuConta = 0 THEN
    EXECUTE immediate 'alter table tmp_producto_procsub add marca_subsidio varchar2(1)';
    EXECUTE immediate 'alter table tmp_producto_procsub add valor_ajuste_rang number(15)';
    EXECUTE immediate 'alter table tmp_producto_procsub add unidades_rang number(15)';
    EXECUTE immediate 'comment on column tmp_producto_procsub.marca_subsidio IS ''INDICA SI EL PRODUCTO TUVO SUBSIDIO''';
    EXECUTE immediate 'comment on column tmp_producto_procsub.valor_ajuste_rang IS ''VALOR DE AJUSTE CON UNIDADES DE RANGLIQU''';
    EXECUTE immediate 'comment on column tmp_producto_procsub.unidades_rang IS ''UNIDADES DE RANGLIQU''';
  END IF;
END;
/