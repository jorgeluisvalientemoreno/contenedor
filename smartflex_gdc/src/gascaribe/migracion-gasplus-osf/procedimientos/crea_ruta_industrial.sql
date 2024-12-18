CREATE OR REPLACE PROCEDURE        "CREA_RUTA_INDUSTRIAL" IS

  CURSOR cupremise
  is
  SELECT rownum,c.premise_id
  FROM pr_product a, ab_address b, ab_premise c
  WHERE a.category_id=3
  AND a.address_id = b.address_id
  AND b.estate_number = c.premise_id;

  nuLogError NUMBER;
  nuTotalRegs number := 0;
  nuErrores number := 0;

BEGIN

  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra (248,248,1,'CREA_RUTA_INDUSTRIAL',0,0,'Inicia Proceso','INICIO',nuLogError);

  INSERT INTO OR_route
  VALUES (331, 'RUTA: 331',null,'Y');

  commit;

for r in cupremise loop
    begin
		INSERT INTO or_route_premise VALUES (seq_or_route_premis_196985.nextval,r.premise_id,331,r.rownum);
		commit;

		nuTotalRegs := nuTotalRegs + 1;
	EXCEPTION
        WHEN OTHERS THEN
            PKLOG_MIGRACION.prInsLogMigra (248,248,2,'CREA_RUTA_INDUSTRIAL',0,0,'Error en premise_id: '||r.premise_id||' - '||SQLERRM,to_char(sqlcode),nuLogError);
	end;

END loop;

-- Termina Log
PKLOG_MIGRACION.prInsLogMigra (248,248,3,'CREA_RUTA_INDUSTRIAL',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);


EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra (248,248,2,'CREA_RUTA_INDUSTRIAL',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);

END CREA_RUTA_INDUSTRIAL;
/
