CREATE OR REPLACE PROCEDURE ELEMMEDIMIGR(NUMINICIO number,
                                         numFinal  number,
                                         pbd       number) AS
  /*******************************************************************
  PROGRAMA            :    ELEMMEDImigr
  FECHA            :    15/05/2014
  AUTOR            :    VICTOR HUGO MUNIVE ROCA
  DESCRIPCION        :    Migra la informacion de los medidores a ELEMMEDI
  HISTORIA DE MODIFICACIONES
  AUTOR       FECHA    DESCRIPCION
  *******************************************************************/
  vfecha_ini      DATE;
  VFECHA_FIN      DATE;
  vprograma       VARCHAR2(100);
  verror          VARCHAR2(4000);
  vcont           NUMBER := 10000;
  vcontELEM       NUMBER := 10000;
  --vcontAtri       NUMBER := 10000;
  vcontLec        NUMBER := 0;
  vcontIns        NUMBER := 0;
  sbsql           varchar2(800);
  MAXNUMBER       NUMBER;
  sbMedidor       varchar2(50);
  nuComplementoPR number;
  nuComplementoSU number;
  nuComplementoFA number;
  nuComplementoCU number;
  nuComplementoDI number;
  cursor cuElemmediREP is
    SELECT /*+ PARALLEL */
     K.ELEMMEDI ELMECODI,
     1 ELMECLEM,
     9 ELMENUDC,
     1 ELMEUIEM,
     1 ELMEPOSI,
     1 ELMEFACM,
     1 ELMEFACD,
     power(10, 9) - 1 ELMETOPE,
     NULL ELMEEMAC,
    -- 4001229 ITEMS_ID,
     10004070 items_id,
     UPPER(K.ELEMMEDI) SERIE,
     'N' ESTADO_TECNICO,
     5 ID_ITEMS_ESTADO_INV,
     0 COSTO,
     0 SUBSIDIO,
     'C' PROPIEDAD,
     case
       when c.sesufeco is not null then
        c.sesufeco
       else
        case
       when c.sesufein is not null then
        c.sesufein
       else
        sysdate - 60
     end end FECHA_INGRESO,
     NULL FECHA_SALIDA,
     NULL FECHA_REACON,
     NULL FECHA_BAJA,
     SYSDATE + 365 * 3 FECHA_GARANTIA,
     NULL OPERATING_UNIT_ID,
     C.SESUNUSE + nucomplementopr NUMERO_SERVICIO,
     s.suscclie Subscriber_Id,
     S.SUSCCODI CONTRATO,
     C.SESUNUSE + nucomplementopr sesunuse,
     'MEDIDOR FICTICIO (CAMBIO)  MFC' MARCA
      From Ldc_Temp_Servsusc_sge C,
           servsusc              j,
           LDC_MIG_MEDIREPE      K,
           suscripc              s,
           ldc_mig_servicio      g
     WHERE c.sesuserv = g.codiserv
       and g.servhomo = 7014
       And C.Basedato = pbd
       AND C.SESUSUSC >= NUMINICIO
       and C.SESUSUSC < NUMFINAL
       and j.sesunuse = c.sesunuse + nucomplementopr
       and s.susccodi = j.sesususc
       AND K.BASEDATO = pbd
       AND K.NUSE = C.SESUNUSE;
  cursor cuElemmedi is
    SELECT /*+ PARALLEL */
     UPPER(a.MEDINUSE) ELMECODI,
     1 ELMECLEM,
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
   --  4001229 ITEMS_ID,
    10004070 items_id,
     UPPER(A.MEDINUSE) SERIE,
     'N' ESTADO_TECNICO,
     5 ID_ITEMS_ESTADO_INV,
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
     C.SESUNUSE + nucomplementopr NUMERO_SERVICIO,
     s.suscclie Subscriber_Id,
     S.SUSCCODI CONTRATO,
     C.SESUNUSE + nucomplementopr sesunuse,
     MR.MARCDESC MARCA
      From Ldc_Temp_Medidor_sge  A,
           Ldc_Temp_Rememarc_sge B,
           Ldc_Temp_Servsusc_sge C,
           servsusc              j,
           LDC_MIG_ELEMMEDI      K,
           suscripc              s,
           ldc_temp_marca_sge    MR,
           ldc_mig_servicio      g
     WHERE A.MEDINUSE <> '-----------'
       and a.MEDIMARC = b.RMMAMARC
       AND a.MEDIMARC = MR.MARCCODI
       and mr.basedato = pbd
       And A.Medirefe = B.Rmmacodi
       AND B.BASEDATO = pbd
       AND A.MEDINUSE = C.SESUMEDI
       and c.sesuserv = g.codiserv
       and g.servhomo = 7014
       AND A.BASEDATO = pbd
       And C.Basedato = pbd
       AND C.SESUSUSC >= NUMINICIO
       and C.SESUSUSC < NUMFINAL
       and j.sesunuse = c.sesunuse + nucomplementopr
       and s.susccodi = j.sesususc
       AND K.BASEDATO = pbd
       AND K.NUSE = C.SESUNUSE
       AND K.ELEMMEDI = A.MEDINUSE;
  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuElemmedi%ROWTYPE;
  TYPE tipo_cu_datos1 IS TABLE OF cuElemmedirep%ROWTYPE;
  sbValue VARCHAR2(100);
  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos          tipo_cu_datos := tipo_cu_datos();
  tbl_datos1         tipo_cu_datos1 := tipo_cu_datos1();
  sbValueProvisional VARCHAR2(2);
  --- Control de errores
  nuLogError  NUMBER;
  NUTOTALREGS NUMBER := 0;
  NUERRORES   NUMBER := 0;
  FUNCTION fsbGetModelo(isbSerie in VARCHAR2) return VARCHAR2 IS
    sbModelo VARCHAR2(100);
    sbAux    VARCHAR2(100);
  BEGIN
    -- sbAux :=  SUBSTR(isbSerie,INSTR(isbSerie, '-',1,1)+1,LENGTH(isbSerie));
    -- sbModelo := SUBSTR(sbAux,1,INSTR(sbAux, '-',1,1)-1);
    sbmodelo := substr(isbserie, 1, 2);
    RETURN sbModelo;
  EXCEPTION
    WHEN OTHERS THEN
      BEGIN
        RETURN NULL;
      END;
  END fsbGetModelo;
BEGIN
  update migr_rango_procesos
     set raprfein = sysdate, RAPRTERM = 'P'
   where raprcodi = 160
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  --DBMS_OUTPUT.PUT_LINE('SETEE RANGOS');
  commit;
  pkg_constantes.COMPLEMENTO(pbd,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);
  --DBMS_OUTPUT.PUT_LINE('DETERMINE COMPLEMENTOS');
  VPROGRAMA  := 'ELEMMEDImigr';
  vfecha_ini := SYSDATE;
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(160,
                                160,
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
    -- Borrar tablas tbl_datos.
    --
    tbl_datos.delete;
    FETCH cuElemmedi BULK COLLECT
      INTO tbl_datos LIMIT 1000;
    --DBMS_OUTPUT.PUT_LINE('ENTRE A LOOP 1');
    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
    --DBMS_OUTPUT.PUT_LINE('ENTRE A LOOP 1.5');
    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
      --DBMS_OUTPUT.PUT_LINE('ENTRE A LOOP 1.6');
      vcont := vcont + 1;
      BEGIN
        vcontLec  := vcontLec + 1;
        sbMedidor := tbl_datos(nuindice).ELMECODI;
        vcont     := Open.SEQ_GE_ITEMS_SERIADO.NEXTVAL;
        vcontELEM := Open.SQELEMMEDI.NEXTVAL;
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        --DBMS_OUTPUT.PUT_LINE('ENTRE A LOOP 2');
        INSERT INTO ELEMMEDI
          (ELMEIDEM,
           ELMECODI,
           ELMECLEM,
           ELMENUDC,
           ELMEUIEM,
           ELMEPOSI,
           ELMEFACM,
           ELMEFACD,
           ELMETOPE,
           ELMEEMAC)
        VALUES
          (vcontELEM,
           tbl_datos(nuindice).ELMECODI,
           tbl_datos(nuindice).ELMECLEM,
           tbl_datos(nuindice).ELMENUDC,
           tbl_datos(nuindice).ELMEUIEM,
           tbl_datos(nuindice).ELMEPOSI,
           tbl_datos(nuindice).ELMEFACM,
           tbl_datos(nuindice).ELMEFACD,
           tbl_datos(nuindice).ELMETOPE,
           tbl_datos(nuindice).ELMEEMAC);
        --DBMS_OUTPUT.PUT_LINE('INSERTE EN ELEMMEDI');
        insert into ldc_mig_medidor_homo
          (susccodi, medinuse, basedato, medihomo, sesunuse, fechcone)
        values
          (tbl_datos(nuindice).CONTRATO,
           tbl_datos(nuindice).elmecodi,
           pbd,
           vcontELEM,
           tbl_datos(nuindice).SESUNUSE,
           tbl_datos(nuindice).FECHA_INGRESO);
        INSERT INTO GE_ITEMS_SERIADO
          (ID_ITEMS_SERIADO,
           ITEMS_ID,
           SERIE,
           ESTADO_TECNICO,
           ID_ITEMS_ESTADO_INV,
           COSTO,
           SUBSIDIO,
           PROPIEDAD,
           FECHA_INGRESO,
           FECHA_SALIDA,
           FECHA_REACON,
           FECHA_BAJA,
           FECHA_GARANTIA,
           OPERATING_UNIT_ID,
           NUMERO_SERVICIO,
           SUBSCRIBER_ID)
        VALUES
          (vcont,
           tbl_datos(nuindice).ITEMS_ID,
           tbl_datos(nuindice).SERIE,
           tbl_datos(nuindice).ESTADO_TECNICO,
           tbl_datos(nuindice).ID_ITEMS_ESTADO_INV,
           tbl_datos(nuindice).COSTO,
           tbl_datos(nuindice).SUBSIDIO,
           tbl_datos(nuindice).PROPIEDAD,
           tbl_datos(nuindice).FECHA_INGRESO,
           tbl_datos(nuindice).FECHA_SALIDA,
           tbl_datos(nuindice).FECHA_REACON,
           tbl_datos(nuindice).FECHA_BAJA,
           tbl_datos(nuindice).FECHA_GARANTIA,
           tbl_datos(nuindice).OPERATING_UNIT_ID,
           tbl_datos(nuindice).NUMERO_SERVICIO,
           tbl_datos(nuindice).SUBSCRIBER_ID);
      
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL,
           1000037,
           Tbl_Datos(Nuindice).Items_Id,
           Vcont,
           Tbl_Datos(Nuindice).Elmetope);
      
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL, 1000031, Tbl_Datos(Nuindice).Items_Id, Vcont, 1);
      
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        -- Se inserta la marca
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL,
           1000028,
           tbl_datos(nuindice).ITEMS_ID,
           VCONT,
           tbl_datos(nuindice).marca);
		   
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        sbValue   := fsbGetModelo(tbl_datos(nuindice).ELMECODI);
        -- Se inserta el modelo
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL,
           1000029,
           tbl_datos(nuindice).ITEMS_ID,
           vcont,
           'MEDIDOR');
        sbValue := NULL;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra(160,
                                          160,
                                          2,
                                          vprograma || vcontIns,
                                          0,
                                          0,
                                          'Medidor : ' || sbMedidor ||
                                          ' - Error: ' || sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);
          END;
      END;
    END LOOP;
    EXIT WHEN cuELEMMEDI%NOTFOUND;
  end loop;
  -- Cierra CURSOR.
  IF (cuELEMMEDI%ISOPEN) THEN
    CLOSE cuELEMMEDI;
  END IF;
  OPEN cuElemmediREP;
  LOOP
    --
    -- Borrar tablas tbl_datos.
    --
    tbl_datos1.delete;
    FETCH cuElemmediREP BULK COLLECT
      INTO tbl_datos1 LIMIT 1000;
    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
    FOR nuindice IN 1 .. tbl_datos1.COUNT LOOP
      vcont := vcont + 1;
      BEGIN
        vcontLec  := vcontLec + 1;
        sbMedidor := tbl_datos1(nuindice).ELMECODI;
        vcont     := Open.SEQ_GE_ITEMS_SERIADO.NEXTVAL;
        vcontELEM := Open.SQELEMMEDI.NEXTVAL;
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        INSERT INTO ELEMMEDI
          (ELMEIDEM,
           ELMECODI,
           ELMECLEM,
           ELMENUDC,
           ELMEUIEM,
           ELMEPOSI,
           ELMEFACM,
           ELMEFACD,
           ELMETOPE,
           ELMEEMAC)
        VALUES
          (vcontELEM,
           tbl_datos1(nuindice).ELMECODI,
           tbl_datos1(nuindice).ELMECLEM,
           tbl_datos1(nuindice).ELMENUDC,
           tbl_datos1(nuindice).ELMEUIEM,
           tbl_datos1(nuindice).ELMEPOSI,
           tbl_datos1(nuindice).ELMEFACM,
           tbl_datos1(nuindice).ELMEFACD,
           tbl_datos1(nuindice).ELMETOPE,
           tbl_datos1(nuindice).ELMEEMAC);
        insert into ldc_mig_medidor_homo
          (susccodi, medinuse, basedato, medihomo, sesunuse, fechcone)
        values
          (tbl_datos1(nuindice).CONTRATO,
           tbl_datos1(nuindice).elmecodi,
           pbd,
           vcontELEM,
           tbl_datos1(nuindice).SESUNUSE,
           tbl_datos1(nuindice).FECHA_INGRESO);
        INSERT INTO GE_ITEMS_SERIADO
          (ID_ITEMS_SERIADO,
           ITEMS_ID,
           SERIE,
           ESTADO_TECNICO,
           ID_ITEMS_ESTADO_INV,
           COSTO,
           SUBSIDIO,
           PROPIEDAD,
           FECHA_INGRESO,
           FECHA_SALIDA,
           FECHA_REACON,
           FECHA_BAJA,
           FECHA_GARANTIA,
           OPERATING_UNIT_ID,
           NUMERO_SERVICIO,
           SUBSCRIBER_ID)
        VALUES
          (vcont,
           tbl_datos1(nuindice).ITEMS_ID,
           tbl_datos1(nuindice).SERIE,
           tbl_datos1(nuindice).ESTADO_TECNICO,
           tbl_datos1(nuindice).ID_ITEMS_ESTADO_INV,
           tbl_datos1(nuindice).COSTO,
           tbl_datos1(nuindice).SUBSIDIO,
           tbl_datos1(nuindice).PROPIEDAD,
           tbl_datos1(nuindice).FECHA_INGRESO,
           tbl_datos1(nuindice).FECHA_SALIDA,
           tbl_datos1(nuindice).FECHA_REACON,
           tbl_datos1(nuindice).FECHA_BAJA,
           tbl_datos1(nuindice).FECHA_GARANTIA,
           tbl_datos1(nuindice).OPERATING_UNIT_ID,
           tbl_datos1(nuindice).NUMERO_SERVICIO,
           tbl_datos1(nuindice).SUBSCRIBER_ID);
      
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL,
           1000037,
           Tbl_Datos1(Nuindice).Items_Id,
           Vcont,
           Tbl_Datos1(Nuindice).Elmetope);
      
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL, 1000031, Tbl_Datos1(Nuindice).Items_Id, Vcont, 1);
      
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        -- Se inserta la marca
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL,
           1000028,
           tbl_datos1(nuindice).ITEMS_ID,
           VCONT,
           tbl_datos1(nuindice).marca);
      
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        sbValue   := fsbGetModelo(tbl_datos1(nuindice).ELMECODI);
        -- Se inserta el modelo
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL,
           1000029,
           tbl_datos1(nuindice).ITEMS_ID,
           vcont,
           'MEDIDOR');
        sbValue := NULL;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra(160,
                                          160,
                                          2,
                                          vprograma || vcontIns,
                                          0,
                                          0,
                                          'Medidor : ' || sbMedidor ||
                                          ' - Error: ' || sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);
          END;
      END;
    END LOOP;
    COMMIT;
    EXIT WHEN cuElemmediREP%NOTFOUND;
  END LOOP;
  -- Cierra CURSOR.
  IF (cuElemmediREP%ISOPEN) THEN
    --{
    CLOSE cuElemmediREP;
    --}
  END IF;
  COMMIT;
  --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA(160,
                                160,
                                3,
                                VPROGRAMA,
                                NUTOTALREGS,
                                NUERRORES,
                                'TERMINO PROCESO #regs: ' || VCONTINS,
                                'FIN',
                                NULOGERROR);
  update migr_rango_procesos
     set raprfefi = sysdate, raprterm = 'T'
   where raprcodi = 160
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  commit;
EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      NULL;
      NUERRORES := NUERRORES + 1;
      PKLOG_MIGRACION.prInsLogMigra(160,
                                    160,
                                    2,
                                    vprograma || vcontIns,
                                    0,
                                    0,
                                    'Medidor : ' || sbMedidor ||
                                    ' - Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);
    END;
END ELEMMEDImigr; 
/
