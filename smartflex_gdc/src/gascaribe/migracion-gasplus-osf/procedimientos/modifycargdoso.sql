CREATE OR REPLACE procedure Modifycargdoso(NUMINICIO   number,
                                            numFinal    number,
                                            inudatabase number) as

  cursor cucargosDF is
    SELECT /*+ INDEX (a IX_CARGOS010)*/
     a.ROWID, cargdoso
      FROM cargos a
     WHERE cargdoso LIKE 'DF-%'
       AND NOT EXISTS
     (SELECT /*+ INDEX (diferido PK_DIFERIDO)*/
             'x'
              FROM diferido
             where difecodi = to_number(substr(cargdoso, 4)));

  cursor cucargosDF1 is
    SELECT * FROM migra.CARGOS_DOSO;

  nuLogError  NUMBER;
  nuTotalRegs number := 0;
  nuErrores   number := 0;
  nl          number;
  nuCommit    number := 0;
  vcontLec    NUMBER := 0;
  vcontIns    NUMBER := 0;

begin
  BEGIN
    EXECUTE IMMEDIATE ('create index IX_DIFE_NUSE_CODI on DIFERIDO (DIFENUSE, DIFECODI)');
  
  EXCEPTION
    WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra(8191,
                                    8191,
                                    2,
                                    'MODIFYCARGDOSO',
                                    0,
                                    0,
                                    'Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);
  END;

  BEGIN
  
    EXECUTE IMMEDIATE ('ALTER SYSTEM FLUSH SHARED_POOL');
  
  EXCEPTION
    WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra(8191,
                                    8191,
                                    2,
                                    'MODIFYCARGDOSO',
                                    0,
                                    0,
                                    'Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);
  END;

  BEGIN
  
 
    DELETE FROM MIGRA.CARGOS_DOSO;
  EXCEPTION
    WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra(8191,
                                    8191,
                                    2,
                                    'MODIFYCARGDOSO',
                                    0,
                                    0,
                                    'Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);
  END;

 
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(8191,
                                8191,
                                1,
                                'MODIFYCARGDOSO',
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'P', RAPRFEIN = sysdate
   WHERE raprbase = inudatabase
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 8191;
  commit;

  vcontIns := 1;
  vcontLec := 0;

  for r in cucargosDF loop
  
    insert into migra.cargos_doso (id, cargdoso) values (r.rowid, r.cargdoso);
  
    nuCommit := nuCommit + 1;
  
    if (nuCommit > 5000) then
      nuCommit := 0;
      commit;
    end if;
  end loop;
  COMMIT;

  for r in cucargosDF1 loop
    BEGIN
    update cargos
       set cargdoso = 'DIFPAG-' ||
                      substr(r.cargdoso, instr(r.cargdoso, '-') + 1)
     where rowid = r.id;
    commit;
     EXCEPTION
    WHEN OTHERS THEN
      NULL;
  END;
    nuCommit := nuCommit + 1;
  
    if (nuCommit > 5000) then
      nuCommit := 0;
      commit;
    end if;
  end loop;
  COMMIT;
  -- Termina Log
  PKLOG_MIGRACION.prInsLogMigra(8191,
                                8191,
                                3,
                                'MODIFYCARGDOSO',
                                vcontIns,
                                nuErrores,
                                'TERMINO PROCESO #regs: ' || vcontIns,
                                'FIN',
                                nuLogError);

  BEGIN
    EXECUTE IMMEDIATE ('DROP INDEX IX_DIFE_NUSE_CODI');
  EXCEPTION
    WHEN OTHERS THEN
      NULL;
    
  END;
  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'T', RAPRFEFI = sysdate
   WHERE raprbase = inudatabase
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 8191;
  commit;

EXCEPTION
  WHEN OTHERS THEN
    PKLOG_MIGRACION.prInsLogMigra(8191,
                                  8191,
                                  2,
                                  'MODIFYCARGDOSO',
                                  0,
                                  0,
                                  'Error: ' || sqlerrm,
                                  to_char(sqlcode),
                                  nuLogError);
  
end; 
/
