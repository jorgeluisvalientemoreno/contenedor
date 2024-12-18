DECLARE
 nmsecuencia NUMBER(4);
 nmconta     NUMBER(4);
BEGIN
 BEGIN 
  INSERT INTO ldc_tipcaus_impapar(codigo,descripcion,activo) VALUES(0,'Gestion por proceso Interno','Y');
 EXCEPTION
  WHEN OTHERS THEN
   NULL;
 END;
 ---
 BEGIN 
  INSERT INTO ldc_tipcaus_impapar(codigo,descripcion,activo) VALUES(1,'Separacion de factura','Y');
 EXCEPTION
  WHEN OTHERS THEN
   NULL;
 END;  
 --
 BEGIN 
  INSERT INTO ldc_tipcaus_impapar(codigo,descripcion,activo) VALUES(2,'Abono a factura de productos','Y');
 EXCEPTION
  WHEN OTHERS THEN
   NULL;
 END;  
 COMMIT;
 INSERT INTO ldc_causalabonofnb(codigo,descripcion) VALUES(87,'POR PROCEDIMIENTO INTERNO'); 
 INSERT INTO ldc_causalabonofnb(codigo,descripcion) VALUES(88,'POR DAÑO DEL KIOSKO');
 COMMIT;
 INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(1,0,87,'Y');
 INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(2,0,88,'Y');
 COMMIT;
 INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(3,1,2,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(4,1,3,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(5,1,8,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(6,1,1,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(7,1,9,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(8,1,66,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(9,1,7,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(10,1,86,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(11,1,5,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(12,1,46,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(13,1,4,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(14,1,48,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(15,1,6,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(16,2,2,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(17,2,3,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(18,2,1,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(19,2,9,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(20,2,66,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(21,2,7,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(22,2,5,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(23,2,46,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(24,2,4,'Y');
INSERT INTO ldc_tipcau_caus_imppar(codigo,cod_tipo_causal,causal,activo) VALUES(25,2,6,'Y');
COMMIT;
EXECUTE IMMEDIATE 'DROP SEQUENCE seq_ldc_causalabonofnb';
EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_ldc_causalabonofnb START WITH 90 MAXVALUE 9999';
EXECUTE IMMEDIATE 'DROP SEQUENCE seq_ldc_tipcau_caus_imppar';
EXECUTE IMMEDIATE 'CREATE SEQUENCE seq_ldc_tipcau_caus_imppar START WITH 26 MAXVALUE 9999';
END;
/