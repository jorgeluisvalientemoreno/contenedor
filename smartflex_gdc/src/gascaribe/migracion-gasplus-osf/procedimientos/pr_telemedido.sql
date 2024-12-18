CREATE OR REPLACE PROCEDURE     PR_TELEMEDIDO(NUMINICIO number, numFinal number ,inubasedato number) AS
/*
   PROCEDIMIENTO : PR_TELEMEDIDO
   DESCRIPCION   : Cambia los ciclos de facturacion y consumo a los usuarios de Telemedidos.
   FECHA         : 
   AUTOR         :
   
  HISTORIA DE MODIFICACIONES
  
  FECHA       AUTOR    DESCRIPCION
  06/08/2013  XCF      Se Modifica para que tome la base de datos de los suscriptores.
  
  
*/
nuLogError NUMBER;
nuTotalRegs number := 0;
nuErrores number := 0;

CURSOR cuTelemedido
IS
SELECT *
FROM
telemedido;

CURSOR cuTelemedidoefigas
is
SELECT sesunuse
FROM
servsusc
WHERE sesucicl in (1790,6390,6690);


nuComplementoPR   number;
nuComplementoSU   number;
nuComplementoFA   number;
nuComplementoCU   number;
nuComplementoDI  number;

BEGIN

  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra (247,247,1,'PR_TELEMEDIDO',0,0,'Inicia Proceso','INICIO',nuLogError);
  UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=247;




  for r in   cuTelemedido
  loop

    pkg_constantes.Complemento(r.basedato,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
    
    UPDATE SUSCRIPC
     SET SUSCCICL = r.ciclo
     WHERE susccodi= r.susccodi+nuComplementoSU;

      UPDATE SERVSUSC
      SET SESUMECV = 2,
          SESUCICO =r.ciclo,
          SESUCICL =r.ciclo
      WHERE SESUSUSC = r.susccodi+nuComplementoSU
      and sesuserv=7014;

   UPDATE ELEMMEDI
      SET ELMECLEM = 2
    WHERE ELMEIDEM IN (SELECT EMSSELME
                         FROM ELMESESU
                        WHERE EMSSSESU IN  (select sesunuse
                                            FROM  servsusc
                                             WHERE sesususc = r.susccodi+nuComplementoSU )
                         and emssfere > sysdate);
  
  END loop;
  

  if inubasedato=5 then
      for r in  cuTelemedidoefigas
      loop
         UPDATE SERVSUSC
          SET SESUMECV = 2
          WHERE sesunuse= r.sesunuse;
          commit;
        
         UPDATE ELEMMEDI
          SET ELMECLEM = 2
          WHERE ELMEIDEM IN (SELECT EMSSELME
                             FROM ELMESESU
                             WHERE EMSSSESU =r.sesunuse
                             and emssfere > sysdate);
  
      END loop;
   END if;



  COMMIT;
  
-- Termina Log
PKLOG_MIGRACION.prInsLogMigra ( 247,247,3,'PR_TELEMEDIDO',nuTotalRegs,nuErrores,'TERMINO PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);
UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=247;

EXCEPTION
   WHEN OTHERS
   THEN
      PKLOG_MIGRACION.prInsLogMigra (247,247,2,'PR_TELEMEDIDO',0,0,'Error: '||sqlerrm,to_char(sqlcode),nuLogError);  
END PR_TELEMEDIDO; 
/
