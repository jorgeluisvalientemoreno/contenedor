CREATE OR REPLACE PROCEDURE PR_CONT_REINT_ROLLOUT(nuInicio number,
                                                  nuFinal  number,
                                                  nuBD     number) AS
  /*******************************************************************
  PROGRAMA     : PR_CONT_REINT_ROLLOUT
  FECHA        : 17/09/2014
  AUTOR        : OLSoftware
  DESCRIPCION  : Migra la informacion de los valores pendientes por las entidades de recaudo
  HISTORIA DE MODIFICACIONES
  AUTOR     FECHA  DESCRIPCION
  
  *******************************************************************/

  CURSOR cuBancos IS
  /*    SELECT B.BANCHOMO BANCO, A.FECHA FECHA, SUM(A.VALOR) VALOR
          FROM MIGRA.LDC_TEMP_CONTREIN_SGE A, LDC_MIG_BANCO B
         WHERE A.CODIBANC = B.CODIBANC
           AND A.BASEDATO = B.BASEDATO
           AND A.BASEDATO = nuBD
         GROUP BY B.BANCHOMO, A.FECHA, A.BASEDATO;*/
  
    SELECT B.BANCHOMO BANCO,
           A.FECHA FECHA,
           SUM(A.VALOR) VALOR,
           MAX(documen) documen
      FROM MIGRA.LDC_TEMP_CONTREIN_SGE A, LDC_MIG_BANCO B
     WHERE A.CODIBANC = B.CODIBANC
       AND A.BASEDATO = B.BASEDATO
       AND A.BASEDATO = 1
     GROUP BY B.BANCHOMO, A.FECHA, A.BASEDATO;

  nuConciliaCodi NUMBER;
  nuLogError     NUMBER;
  nuTotalRegs    number := 0;
  nuErrores      number := 0;
  vntd           number;
  verror         VARCHAR2(4000);
  NUTRA          number;
  NUDOCU         number;

BEGIN

  ----los valores negativos son sobrantes gp y se estan migrando como faltantes

  ----los valores positivos son faltantes gp y no se estan migrando
  PKLOG_MIGRACION.prInsLogMigra(510,
                                510,
                                1,
                                'PR_CONT_REINT_ROLLOUT',
                                nuTotalRegs,
                                nuErrores,
                                'INICIA PROCESO #regs: ' || nuTotalRegs,
                                'FIN',
                                nuLogError);

  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRFEIN = SYSDATE, RAPRTERM = 'P'
   where RAPRCODI = 510
     AND RAPRBASE = nuBD
     AND RAPRRAIN = nuInicio
     AND RAPRRAFI = nuFinal;
  COMMIT;

  FOR rgBanco IN cuBancos LOOP
    vntd := null;
    BEGIN
    
      nuConciliaCodi := SQ_CONCILIA_183049.nextval; --
    
      INSERT INTO CONCILIA
        (CONCBANC,
         CONCFEPA,
         CONCNUCU,
         CONCCAPA,
         CONCVATO,
         CONCFERE,
         CONCFLPR,
         CONCPRRE,
         CONCFUNC,
         CONCFECI,
         CONCSIST,
         CONCCIAU,
         CONCCONS)
      VALUES
        (rgBanco.BANCO,
         rgBanco.FECHA,
         0,
         0,
         abs(rgBanco.VALOR),
         rgBanco.FECHA,
         'S',
         0,
         '1096',
         rgBanco.FECHA,
         99,
         'S',
         nuConciliaCodi);
    
      if rgBanco.VALOR > 0 then
        vntd := 1;
         NUDOCU := SQDOCUSORE.NEXTVAL;
        INSERT INTO DOCUSORE
          (DOSRCODI,
           DOSRBANC,
           DOSRTDSR,
           DOSRCONC,
           DOSRNDSR,
           DOSRFEPA,
           DOSRFERE,
           DOSRNUCU,
           DOSRVDSR,
           DOSROBSE,
           DOSRNORE,
           DOSRCUPO,
           DOSRPRAT,
           DOSRFEAT,
           DOSRUSUA,
           DOSRTERM,
           DOSRPROG)
        VALUES
          (NUDOCU,
           rgBanco.BANCO,
           vntd,
           nuConciliaCodi,
           1,
           rgBanco.FECHA,
           rgBanco.FECHA,
           0,
           abs(rgBanco.VALOR),
           'MIGRACION',
           NULL,
           NULL,
           NULL,
           NULL,
           'MIGRA',
           'MIGRA',
           'MIGRA');
      else
        vntd  := 7;
        NUTRA := SQTRANBANC.NEXTVAL;
        insert into tranbanc
          (trbacodi,
           trbabanc,
           trbatitb,
           trbanutr,
           trbacuba,
           trbafetr,
           trbafere,
           trbavatr,
           trbaretr,
           trbanueb,
           trbanoar,
           trbabare)
        values
          (NUTRA,
           rgBanco.BANCO,
           2,
           rgBanco.documen,
           NULL,
           rgBanco.FECHA,
           rgBanco.FECHA,
           abs(rgBanco.VALOR),
           NULL,
           NULL,
           NULL,
           rgBanco.BANCO);
      
        NUDOCU := SQDOCUSORE.NEXTVAL;
        INSERT INTO DOCUSORE
          (DOSRCODI,
           DOSRBANC,
           DOSRTDSR,
           DOSRCONC,
           DOSRNDSR,
           DOSRFEPA,
           DOSRFERE,
           DOSRNUCU,
           DOSRVDSR,
           DOSROBSE,
           DOSRNORE,
           DOSRCUPO,
           DOSRPRAT,
           DOSRFEAT,
           DOSRUSUA,
           DOSRTERM,
           DOSRPROG)
        VALUES
          (NUDOCU,
           rgBanco.BANCO,
           vntd,
           nuConciliaCodi,
           1,
           rgBanco.FECHA,
           rgBanco.FECHA,
           0,
           abs(rgBanco.VALOR),
           'MIGRACION',
           NULL,
           NULL,
           NULL,
           NULL,
           'MIGRA',
           'MIGRA',
           'MIGRA');
      
        insert into trbadosr
          (tbdstrba,
           tbdsdosr,
           tbdsvads,
           tbdscons,
           tbdsfere,
           tbdsfeci,
           tbdsdosa)
        values
          (NUTRA,
           NUDOCU,
           abs(rgBanco.VALOR),
           SQ_TRBADOSR_178683.NEXTVAL,
           rgBanco.FECHA,
           rgBanco.FECHA,
           NUDOCU);
      end if;
      COMMIT;
    EXCEPTION
      WHEN OTHERS THEN
        BEGIN
          verror := 'Error en el banco: ' || rgBanco.BANCO || ' - ' ||
                    SQLERRM;
        
          nuErrores := nuErrores + 1;
          PKLOG_MIGRACION.prInsLogMigra(510,
                                        510,
                                        2,
                                        'PR_CONT_REINT_ROLLOUT',
                                        0,
                                        0,
                                        'Error: ' || verror,
                                        to_char(sqlcode),
                                        nuLogError);
        END;
    END;
  END LOOP; -- Fin for cuBancos

  PKLOG_MIGRACION.prInsLogMigra(510,
                                510,
                                3,
                                'PR_CONT_REINT_ROLLOUT',
                                nuTotalRegs,
                                nuErrores,
                                'TERMINA PROCESO #regs: ' || nuTotalRegs,
                                'FIN',
                                nuLogError);

  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRFEFI = SYSDATE, RAPRTERM = 'T'
   where RAPRCODI = 510
     AND RAPRBASE = nuBD
     AND RAPRRAIN = nuInicio
     AND RAPRRAFI = nuFinal;
  COMMIT;

EXCEPTION
  WHEN OTHERS THEN
  
    PKLOG_MIGRACION.prInsLogMigra(510,
                                  510,
                                  2,
                                  'PR_CONT_REINT_ROLLOUT',
                                  0,
                                  0,
                                  'Error: ' || sqlerrm,
                                  to_char(sqlcode),
                                  nuLogError);
  
END PR_CONT_REINT_ROLLOUT; 
/
