CREATE OR REPLACE PROCEDURE      CREA_NUEVA_RUTA_INDUSTRIAL
AS

CURSOR CUSERVSUSC
IS
SELECT distinct estate_number, sesucicl
FROM servsusc,pr_product A,ab_address B
WHERE  sesucate =3
AND SESUNUSE=A.PRODUCT_ID
AND A.ADDRESS_ID=B.ADDRESS_ID;

 nuLogError NUMBER;
  nuTotalRegs number := 0;
  nuErrores number := 0;

NUSEQUENCE NUMBER;
nrownum  number;
begin

 -- Inserta registro de inicio en el log
 PKLOG_MIGRACION.prInsLogMigra (3620,3620,1,'CREA_NUEVA_RUTA_INDUSTRIAL',0,0,'Inicia Proceso','INICIO',nuLogError);

INSERT INTO OR_route VALUES (10001,'RUTA:1-Ciclos municipios',NULL,'Y');
INSERT INTO OR_route VALUES (10002,'RUTA:2-Ciclo indal Cali',NULL,'Y');
INSERT INTO OR_route VALUES (10003,'RUTA:3-Ciclo indal Yumbo',NULL,'Y');
INSERT INTO OR_route VALUES (10004,'RUTA:4-Ciclo indal cauca-btura',NULL,'Y');
INSERT INTO OR_route VALUES (331,'RUTA:Telemedidos',NULL,'Y');
commit;


nrownum:=1;
    FOR R IN CUSERVSUSC
    LOOP
        BEGIN
            NUSEQUENCE:= SEQ_OR_ROUTE_PREMIS_196985.nextval;

            INSERT INTO OR_route_PREMISE VALUES (NUSEQUENCE,r.estate_number,decode(r.sesucicl,113,10001,30,10002,303,10003,56,10004,331,331),nrownum);
            commit;
            nrownum:=nrownum+1;
        EXCEPTION
        WHEN OTHERS THEN
            PKLOG_MIGRACION.prInsLogMigra (3620,3620,2,'CREA_NUEVA_RUTA_INDUSTRIAL',0,0,'Error en premise_id: '||r.estate_number||' - '||SQLERRM,to_char(sqlcode),nuLogError);
        end;
    END LOOP;

-- Termina Log
PKLOG_MIGRACION.prInsLogMigra (3620,3620,3,'CREA_NUEVA_RUTA_INDUSTRIAL',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);


EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra (3620,3620,2,'CREA_NUEVA_RUTA_INDUSTRIAL',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);


END CREA_NUEVA_RUTA_INDUSTRIAL;
/
