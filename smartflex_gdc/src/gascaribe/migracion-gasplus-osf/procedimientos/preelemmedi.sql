CREATE OR REPLACE PROCEDURE      "PREELEMMEDI"(NUMINICIO number,
                                               numFinal  number,
                                               pbd       NUMBER) AS
  /*******************************************************************
  PROGRAMA     : preELEMMEDI
  FECHA    : 14/05/2014
  AUTOR    : VICTOR MUNIVE
  DESCRIPCION  : Determina que usuarios de gas estan aptos para migrar segun el medidor que tengan.
  HISTORIA DE MODIFICACIONES
  AUTOR     FECHA    DESCRIPCION
  *******************************************************************/
  nuComplementoPR number;
  nuComplementoSU number;
  nuComplementoFA number;
  nuComplementoCU number;
  nuComplementoDI number;
  vfecha_ini      DATE;
  VFECHA_FIN      DATE;
  vprograma       VARCHAR2(100);
  verror          VARCHAR2(4000);
  vcont           NUMBER;
  vcontLec        NUMBER := 0;
  vcontIns        NUMBER := 0;
  sbMedidor       varchar2(50);
  cursor cumedirepe is
    select * from ldc_mig_medirepe;

  cursor curaya is
    select * from ldc_mig_elemmedi where elemmedi like '%------%';

  cursor cuElemmedi is
    SELECT /*+ parallel */
     a.MEDINUSE ELMECODI, -- falta homologacion de la marca
     1 ELMECLEM, -- Cambio de acuerdo reunion OPEN 10-12-2012 antes era nulo
     b.RMMANDME ELMENUDC,
     1 ELMEUIEM,
     case
       when a.MEDITIEN = 'D' then
        1
       when a.MEDITIEN = 'I' then
        2
       else
        1
     end ELMEPOSI,
     1 ELMEFACM,
     1 ELMEFACD,
     power(10, b.RMMANDME) - 1 ELMETOPE,
     NULL ELMEEMAC,
     4001229 ITEMS_ID,
     A.MEDINUSE SERIE,
     'N' ESTADO_TECNICO,
     0 COSTO,
     0 SUBSIDIO,
     'C' PROPIEDAD,
     case
       when c.sesufeco is not null then
        c.sesufeco
       else
        sysdate
     end FECHA_INGRESO,
     NULL FECHA_SALIDA,
     NULL FECHA_REACON,
     NULL FECHA_BAJA,
     a.MEDIEGEM FECHA_GARANTIA,
     NULL OPERATING_UNIT_ID,
     C.SESUNUSE SESUNUSE
      From Ldc_Temp_Medidor_sge  A,
           Ldc_Temp_Rememarc_sge B,
           Ldc_Temp_Servsusc_sge C,
           ldc_Mig_servicio      g
     WHERE (a.medinuse is not null)
       and a.MEDIMARC = b.RMMAMARC
       And A.Medirefe = B.Rmmacodi
       AND B.BASEDATO = pbd
       AND A.MEDINUSE = C.SESUMEDI
       and c.sesuserv = g.codiserv
       and g.SERVHOMO = 7014
       AND A.BASEDATO = pbd
       And C.Basedato = pbd
       AND C.SESUSUSC >= NUMINICIO
       and C.SESUSUSC < NUMFINAL
       and c.sesueste in
           (SELECT distinct estado_tecnico FROM ldc_estados_serv_homo);

  CURSOR NULOS IS
    SELECT SESUNUSE, BASEDATO
      FROM LDC_TEMP_SERVSUSC_SGE
     WHERE SESUMEDI IS NULL
       AND SESUSERV = 1
       AND BASEDATO = PBD;
  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuElemmedi%ROWTYPE;
  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos tipo_cu_datos := tipo_cu_datos();
  --- Control de errores
  nuLogError  NUMBER;
  NUTOTALREGS NUMBER := 0;
  NUERRORES   NUMBER := 0;
  mrep        number;
  nusesueste  number := 0;
BEGIN
  update migr_rango_procesos
     set raprfein = sysdate, RAPRTERM = 'P'
   where raprcodi = 300
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  COMMIT;
  pkg_constantes.COMPLEMENTO(pbd,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);
  VPROGRAMA  := 'preELEMMEDI';
  vfecha_ini := SYSDATE;
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(300,
                                300,
                                1,
                                vprograma,
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);
  -- Extraer los datos
  OPEN cuElemmedi;
  LOOP
    --
    -- Borrar tablas     tbl_datos.
    --
    tbl_datos.delete;
    FETCH cuElemmedi BULK COLLECT
      INTO tbl_datos LIMIT 1000;
    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
      vcont := vcont + 1;
      BEGIN
        vcontLec  := vcontLec + 1;
        sbMedidor := tbl_datos(nuindice).ELMECODI;
        insert into LDC_MIG_ELEMMEDI
          (nuse, basedato, elemmedi)
        values
          (tbl_datos(nuindice).sesunuse, pbd, tbl_datos(nuindice).ELMECODI);
        COMMIT;
      EXCEPTION
        WHEN dup_val_on_index THEN
          BEGIN
            NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra(300,
                                          300,
                                          2,
                                          vprograma || vcontIns,
                                          0,
                                          0,
                                          'Usuario ' ||
                                          to_char(tbl_datos(nuindice)
                                                  .sesunuse) ||
                                          ' de base dato ' || TO_CHAR(PBD) ||
                                          ', no migra por tener medidor # ' ||
                                          sbMedidor ||
                                          ' Repetido - Error: ' || sqlerrm,
                                          'MEDIDOR REPETIDO',
                                          nuLogError);
            mrep := SEQ_MEDIREPE.nextval;
          
            nusesueste := 0;
            select sesueste
              into nusesueste
              from ldc_temp_servsusc_sge
             where sesunuse = tbl_datos(nuindice).sesunuse
               and basedato = pbd;
          
            if PBD in (1, 2, 3) then
            
              if nusesueste NOT IN (10, 21) then
                insert into ldc_mig_medirepe
                  (NUSE, BASEDATO, ELEMMEDI, MEDIDOR)
                values
                  (tbl_datos(nuindice).sesunuse,
                   pbd,
                   'MREP-' || TO_CHAR(MREP),
                   tbl_datos(nuindice).ELMECODI);
              end if;
            
            else
            
              if nusesueste NOT IN (10) then
                insert into ldc_mig_medirepe
                  (NUSE, BASEDATO, ELEMMEDI, MEDIDOR)
                values
                  (tbl_datos(nuindice).sesunuse,
                   pbd,
                   'MREP-' || TO_CHAR(MREP),
                   tbl_datos(nuindice).ELMECODI);
              end if;
            end if;
          
            COMMIT;
          END;
        WHEN OTHERS THEN
          BEGIN
            NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra(300,
                                          300,
                                          2,
                                          vprograma || vcontIns,
                                          0,
                                          0,
                                          'Usuario ' ||
                                          to_char(tbl_datos(nuindice)
                                                  .sesunuse) ||
                                          ' de base dato Cali, no migra con medidor # ' ||
                                          sbMedidor || '  - Error: ' ||
                                          sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);
          END;
      END;
    END LOOP;
    COMMIT;
    EXIT WHEN cuElemmedi%NOTFOUND;
  END LOOP;
  -- Cierra CURSOR.
  IF (cuElemmedi%ISOPEN) THEN
    --{
    CLOSE cuElemmedi;
    --}
  END IF;

  FOR N IN NULOS LOOP
    mrep := SEQ_MEDIREPE.nextval;
    INSERT INTO LDC_MIG_MEDIREPE
      (NUSE, BASEDATO, ELEMMEDI, MEDIDOR)
    VALUES
      (N.SESUNUSE, PBD, 'MNUL-' || TO_CHAR(MREP), NULL);
  END LOOP;
  COMMIT;

  for n in CURAYA LOOP
    mrep := SEQ_MEDIREPE.nextval;
    INSERT INTO LDC_MIG_MEDIREPE
      (NUSE, BASEDATO, ELEMMEDI, MEDIDOR)
    VALUES
      (N.NUSE, PBD, 'MREP-' || TO_CHAR(MREP), NULL);
    delete from LDC_MIG_elemmedi
     where nuse = n.NUSE
       and basedato = PBD;
  
  END LOOP;
  COMMIT;

  for r in cumedirepe loop
    update ldc_temp_lectura_sge
       set lectmedi = r.elemmedi
     where lectnuse = r.nuse
       and lectmedi = r.medidor
       and basedato = r.basedato;
  
    update ldc_temp_consumo_sge
       set consmedi = r.elemmedi
     where consnuse = r.nuse
       and consmedi = r.medidor
       and basedato = r.basedato;
    commit;
  end loop;

  -- agregar 
  if pbd in (2,3) then
    modifycargpecotemp(pbd);
  end if;

  update migr_rango_procesos
     set raprfefi = sysdate, raprterm = 'T'
   where raprcodi = 300
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA(300,
                                300,
                                3,
                                VPROGRAMA,
                                NUTOTALREGS,
                                NUERRORES,
                                'TERMINO PROCESO #regs: ' || VCONTINS,
                                'FIN',
                                NULOGERROR);
EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      NUERRORES := NUERRORES + 1;
      PKLOG_MIGRACION.prInsLogMigra(300,
                                    300,
                                    2,
                                    vprograma || vcontIns,
                                    0,
                                    0,
                                    'Medidor : ' || sbMedidor ||
                                    ' - Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);
    END;
END preELEMMEDI; 
/
