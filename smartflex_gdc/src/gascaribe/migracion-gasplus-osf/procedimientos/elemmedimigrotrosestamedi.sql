CREATE OR REPLACE PROCEDURE ELEMMEDIMIGROtrosEstaMedi(NUMINICIO number,
                                                      numFinal  number,
                                                      pbd       number) AS
  /*******************************************************************
  PROGRAMA            :    ELEMMEDIMIGROtrosEstaMedi
  FECHA            :    55/08/2014
  AUTOR            :    VICTOR HUGO MUNIVE ROCA
  DESCRIPCION        :    Migra la informacion de los medidores no asociados a suscriptores a ELEMMEDI
  HISTORIA DE MODIFICACIONES
  AUTOR       FECHA    DESCRIPCION
  *******************************************************************/
  vfecha_ini      DATE;
  VFECHA_FIN      DATE;
  vprograma       VARCHAR2(100);
  verror          VARCHAR2(4000);
  vcont           NUMBER := 10000;
  vcontELEM       NUMBER:=10000;
  --vcontAtri       NUMBER:=10000;
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
  nuItem          number;

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
     CASE
        WHEN A.MEDIITEM IS NULL THEN 10004070--4001229
        ELSE A.MEDIITEM
     END ITEMS_ID,
     UPPER(A.MEDINUSE) SERIE,
     'N' ESTADO_TECNICO,
     e.esmehomo ID_ITEMS_ESTADO_INV,
     0 COSTO,
     0 SUBSIDIO,
     'E' PROPIEDAD,
     nvl(A.MEDIFECR, sysdate) FECHA_INGRESO,
     NULL FECHA_SALIDA,
     NULL FECHA_REACON,
     NULL FECHA_BAJA,
     a.MEDIEGEM FECHA_GARANTIA,
     c.cuadhomo OPERATING_UNIT_ID,
     null NUMERO_SERVICIO,
     null Subscriber_Id,
     null CONTRATO,
     null sesunuse,
     MR.MARCDESC MARCA
      From Ldc_Temp_Medidor_sge  A,
           Ldc_Temp_Rememarc_sge B,
           ldc_temp_marca_sge    MR,
           ldc_mig_estamedi      e,
           ldc_mig_cuadcont      c
     WHERE A.MEDINUSE <> '-----------'
       AND a.MEDIMARC = b.RMMAMARC
       AND a.MEDIMARC = MR.MARCCODI
       AND b.rmmamarc = mr.marccodi
       AND e.codiesme = a.mediesme
       AND mr.basedato = pbd
       And A.Medirefe = B.Rmmacodi
       AND B.BASEDATO = pbd
       AND A.BASEDATO = pbd
       AND a.basedato = b.basedato
       AND a.basedato = mr.basedato
       AND a.basedato = c.basedato
       AND c.cuadcodi = a.medicuad
       AND NOT EXISTS (select 1 from ldc_temp_servsusc_sge where sesumedi = a.medinuse)
       AND NOT EXISTS (select 1 from ge_items_seriado g where g.items_id = 10004070/*4001229*/ and g.serie = a.medinuse)
       AND NOT EXISTS (select 1 from ge_items_seriado g where g.items_id = A.MEDIITEM and g.serie = a.medinuse);

  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuElemmedi%ROWTYPE;
  --  TYPE tipo_cu_datos1 IS TABLE OF cuElemmedirep%ROWTYPE;
  sbValue VARCHAR2(100);
  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos tipo_cu_datos := tipo_cu_datos();
  -- tbl_datos1         tipo_cu_datos1 := tipo_cu_datos1();
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
   where raprcodi = 1601
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
  VPROGRAMA  := 'ELEMMEDIMIGROtrosEstaMedi';
  vfecha_ini := SYSDATE;
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.prInsLogMigra(1601,
                                1601,
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
           Tbl_Datos                       (Nuindice).Items_Id,
           Vcont,
           Tbl_Datos                       (Nuindice).Elmetope);
           
           --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
        Insert Into Ge_Items_Tipo_At_Val
          (Id_Items_Tipo_At_Val,
           Id_Items_Tipo_Atr,
           Items_Id,
           Id_Items_Seriado,
           Valor)
        Values
          (Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL,
           1000031,
           Tbl_Datos(Nuindice).Items_Id,
           Vcont,
           1);
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
           tbl_datos                       (nuindice).ITEMS_ID,
           VCONT,
           tbl_datos                       (nuindice).marca);
        sbValue := fsbGetModelo(tbl_datos(nuindice).ELMECODI);
        --vcontAtri := Open.SEQ_GE_ITEMS_TIPO_AT_VAL.NEXTVAL;
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

           ------------------------------------------------ actualiza balance de item por unidad operativa
  /*      nuItem := tbl_datos(nuindice).ITEMS_ID;


          -- Si ya eixiste la relacion entre el Item y la UO, se actualiza el saldo, el costo y el cupo
          IF (DAOR_ope_uni_item_bala.fblexist(nuItem,
                                              tbl_datos(nuindice)
                                              .OPERATING_UNIT_ID)) THEN

            UPDATE or_ope_uni_item_bala
               SET balance     = balance + 1, --EIXBEXIS,
                --   TOTAL_COSTS = TOTAL_COSTS + TBL_DATOS(NUINDICE).EIXBVLOR,
                  quota       = quota + 1
             WHERE operating_unit_id = tbl_datos(nuindice).OPERATING_UNIT_ID
               AND items_id = nuItem;
          ELSE
            INSERT INTO OR_OPE_UNI_ITEM_BALA
              (ITEMS_ID,
               OPERATING_UNIT_ID,
               QUOTA,
               BALANCE,
               TOTAL_COSTS,
               OCCACIONAL_QUOTA,
               TRANSIT_IN,
               TRANSIT_OUT)
            VALUES
              (nuItem,
               tbl_datos(nuindice).OPERATING_UNIT_ID,
               0,
               0,
               0,
               0,
               0,
               0);

               UPDATE or_ope_uni_item_bala
               SET balance     =  1 ,--EIXBEXIS,
                --   TOTAL_COSTS = TOTAL_COSTS + TBL_DATOS(NUINDICE).EIXBVLOR,
                  quota       = 1
             WHERE operating_unit_id = tbl_datos(nuindice).OPERATING_UNIT_ID
               AND items_id = nuItem;
          END IF;*/

        ---------------------------------------------

        sbValue := NULL;
        COMMIT;
      EXCEPTION
        WHEN OTHERS THEN
          BEGIN
            NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra(1601,
                                          1601,
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

  --- Termina log
  PKLOG_MIGRACION.PRINSLOGMIGRA(1601,
                                1601,
                                3,
                                VPROGRAMA,
                                NUTOTALREGS,
                                NUERRORES,
                                'TERMINO PROCESO #regs: ' || VCONTINS,
                                'FIN',
                                NULOGERROR);
  update migr_rango_procesos
     set raprfefi = sysdate, raprterm = 'T'
   where raprcodi = 1601
     and raprbase = pbd
     and raprrain = numinicio
     and raprrafi = NUMFINAL;
  commit;
EXCEPTION
  WHEN OTHERS THEN
    BEGIN
      NULL;
      NUERRORES := NUERRORES + 1;
      PKLOG_MIGRACION.prInsLogMigra(1601,
                                    1601,
                                    2,
                                    vprograma || vcontIns,
                                    0,
                                    0,
                                    'Medidor : ' || sbMedidor ||
                                    ' - Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);
    END;
END ELEMMEDIMIGROtrosEstaMedi; 
/
