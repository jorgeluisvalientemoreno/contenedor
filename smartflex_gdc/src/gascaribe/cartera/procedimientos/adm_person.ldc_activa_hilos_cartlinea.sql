CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_ACTIVA_HILOS_CARTLINEA IS
 nuconta NUMBER(4);
BEGIN
 SELECT COUNT(1) INTO nuconta
  FROM open.ldc_osf_estaproc ep
 WHERE ep.proceso IN('LDC_PROCCARTLINEA_H1',
                     'LDC_PROCCARTLINEA_H2',
                     'LDC_PROCCARTLINEA_H3',
                     'LDC_PROCCARTLINEA_H4',
                     'LDC_PROCCARTLINEA_H5',
                     'LDC_PROCCARTLINEA_H6',
                     'LDC_PROCCARTLINEA_H7',
                     'LDC_PROCCARTLINEA_H8',
                     'LDC_PROCCARTLINEA_H9',
                     'LDC_PROCCARTLINEA_H10',
                     'LDC_PROCCARTLINEA_H11',
                     'LDC_PROCCARTLINEA_H12')
   AND ep.fecha_inicial_ejec IS NOT NULL
   AND ep.fecha_final_ejec IS NULL;
   IF nuconta = 0 THEN
    UPDATE ld_parameter x
       SET x.numeric_value = 0
     WHERE x.parameter_id IN(
                          'EJECUTA_CARTLINEA_1'
                         ,'EJECUTA_CARTLINEA_2'
                         ,'EJECUTA_CARTLINEA_3'
                         ,'EJECUTA_CARTLINEA_4'
                         ,'EJECUTA_CARTLINEA_5'
                         ,'EJECUTA_CARTLINEA_6'
                         ,'EJECUTA_CARTLINEA_7'
                         ,'EJECUTA_CARTLINEA_8'
                         ,'EJECUTA_CARTLINEA_9'
                         ,'EJECUTA_CARTLINEA_10'
                         ,'EJECUTA_CARTLINEA_11'
                         ,'EJECUTA_CARTLINEA_12'
                         );
    COMMIT;
   END IF;
EXCEPTION
 WHEN OTHERS THEN
  NULL;
END;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ACTIVA_HILOS_CARTLINEA', 'ADM_PERSON');
END;
/
