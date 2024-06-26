SELECT (SELECT Max(decode(b.is_write,'Y',1,0)) FROM mo_packages a, ge_reception_type b
WHERE a.package_id in(SELECT PACKAGE_id FROM mo_packages_asso WHERE package_id_asso = 198021638)
AND a.RECEPTION_TYPE_ID = b.RECEPTION_TYPE_ID) FLAG_VALIDATE
FROM dual;
SELECT decode((SELECT a.ADDRESS_ID FROM mo_packages a WHERE a.package_id in(198021638)),null,0,1) DIRECCION FROM dual;
SELECT LD_BORTAINTERACCION.fnuValEnvioRtaElect(198021638) TIPO_RTA
FROM DUAL;
SELECT  b.*
          FROM mo_packages a, ge_reception_type b
         WHERE a.package_id in
               (SELECT PACKAGE_id
                  FROM mo_packages_asso
                 WHERE package_id_asso = 198021638)
           AND a.RECEPTION_TYPE_ID = b.RECEPTION_TYPE_ID;
-----------------
SELECT (SELECT Max(decode(b.is_write,'Y',1,0)) FROM mo_packages a, ge_reception_type b
WHERE a.package_id in(SELECT PACKAGE_id FROM mo_packages_asso WHERE package_id_asso = 189729507)
AND a.RECEPTION_TYPE_ID = b.RECEPTION_TYPE_ID) FLAG_VALIDATE
FROM dual;
SELECT decode((SELECT a.ADDRESS_ID FROM mo_packages a WHERE a.package_id in(189729507)),null,0,1) DIRECCION FROM dual;
SELECT LD_BORTAINTERACCION.fnuValEnvioRtaElect(189729507) TIPO_RTA
FROM DUAL;
SELECT  b.*
          FROM mo_packages a, ge_reception_type b
         WHERE a.package_id in
               (SELECT PACKAGE_id
                  FROM mo_packages_asso
                 WHERE package_id_asso = 189729507)
           AND a.RECEPTION_TYPE_ID = b.RECEPTION_TYPE_ID;
