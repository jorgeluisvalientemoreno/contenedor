
  CREATE OR REPLACE PROCEDURE "OPEN"."ACTUALIZA_PORC_PTRCION" (NUMINICIO   number,
                                                    NUMFINAL    number,
                                                    inubasedato number) IS

  CURSOR CUANILLADOS IS
   select b.operating_sector_id, nvl(a.p / b.p * 100, 0) Porcetj
  from (select /*+ INDEX (B IX_AB_PREMISE077)*/ c.operating_sector_id, count(a.PREMISE_ID) P
          from ab_info_premise a, ab_premise b, ab_segments c
         where a.is_ring = 'Y'
           and a.premise_id = b.premise_id
           and b.segments_id = c.segments_id
         group by operating_sector_id) a,
       (select /*+ INDEX (B IX_AB_PREMISE077)*/ c.operating_sector_id, count(a.PREMISE_ID) P
          from ab_info_premise a, ab_premise b, ab_segments c
         where a.premise_id = b.premise_id
           and b.segments_id = c.segments_id
         group by operating_sector_id) b
 where b.operating_sector_id = a.operating_sector_id(+);

  cursor cupredios(nuoperatingsector number) is
    select estate_number
      from ab_address, ab_segments
     where segment_id = segments_id
       and operating_sector_id = nuoperatingsector;

  cursor cuporcnulo is
    select premise_id from ldc_info_predio where porc_penetracion is null;

  --- Control de Errores
  nuLogError  NUMBER;
  NUTOTALREGS NUMBER := 0;
  NUERRORES   NUMBER := 0;

  vfecha_ini     DATE;
  vfecha_fin     DATE;
  vprograma      VARCHAR2(100);
  verror         VARCHAR2(2000);
  vcontLec       NUMBER := 0;
  vcontIns       NUMBER := 0;
  nuErrorCode    NUMBER := NULL;
  nuContador     number := 0;
  sbErrorMessage VARCHAR2(2000) := NULL;
  blError        boolean := false;
  sb_suscclie    number;

BEGIN
  vprograma := 'ACTUALIZA_PORC_PTRCION';

  PKLOG_MIGRACION.prInsLogMigra(3610,
                                3610,
                                1,
                                vprograma,
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  UPDATE MIGRA.MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'P', RAPRFEIN = sysdate
   WHERE raprbase = inubasedato
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 3610;
  commit;

BEGIN
    EXECUTE IMMEDIATE ('create index IX_AB_PREMISE077 on AB_PREMISE (premise_id, segments_id)');
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;


  for r in CUANILLADOS loop
    BEGIN

      for j in cupredios(r.operating_sector_id) loop
        update ldc_info_predio
           set porc_penetracion = r.PORCETJ
         where premise_id = j.estate_number;
      end loop;

      commit;

    EXCEPTION
      WHEN OTHERS THEN
        BEGIN
          NUERRORES := NUERRORES + 1;
          PKLOG_MIGRACION.prInsLogMigra(3610,
                                        3610,
                                        2,
                                        vprograma || vcontIns,
                                        0,
                                        0,
                                        'Cliente : ' || sb_suscclie ||
                                        ' - Error: ' || sqlerrm,
                                        to_char(sqlcode),
                                        nuLogError);

        END;
    End;
  END LOOP;

  for k in cuporcnulo loop
    update ldc_info_predio
       set porc_penetracion = 100
     where premise_id = k.premise_id;
    commit;
  end loop;
  
   BEGIN
    EXECUTE IMMEDIATE ('DROP INDEX IX_AB_PREMISE077');
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;

  --dbms_output.put_line('NUTOTALREGS: '||NUTOTALREGS);

  PKLOG_MIGRACION.prInsLogMigra(3610,
                                3610,
                                3,
                                vprograma,
                                0,
                                0,
                                'Termina Proceso',
                                'FIN',
                                nuLogError);
  UPDATE MIGRA.MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'T', RAPRFEFI = sysdate
   WHERE raprbase = inubasedato
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 3610;
  commit;

EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      IF (CUANILLADOS%ISOPEN) THEN
        CLOSE CUANILLADOS;
      END IF;
      NUERRORES := NUERRORES + 1;
      PKLOG_MIGRACION.prInsLogMigra(3610,
                                    3610,
                                    2,
                                    vprograma || vcontIns,
                                    0,
                                    0,
                                    'Cliente : ' || sb_suscclie ||
                                    ' - Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);

    END;
END ACTUALIZA_PORC_PTRCION; 
/
