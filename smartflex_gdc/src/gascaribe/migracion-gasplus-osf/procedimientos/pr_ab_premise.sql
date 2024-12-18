CREATE OR REPLACE procedure PR_AB_PREMISE(NUMINICIO   number,
                                           numFinal    number,
                                           inubasedato number) AS

  /* ******************************************************************
  PROGRAMA        :    AB_PREMISE
  FECHA            :    04/03/2013
  AUTOR            :
  DESCRIPCION    :    Realiza el proceso para actualizar los  predios de la base
                 de Datos GasPlus .

  HISTORIA DE MODIFICACIONES
  AUTOR           FECHA     DESCRIPCION

  *******************************************************************/
  ONUADDRESSID      NUMBER;
  OSBADDRESSPARSED  VARCHAR2(4000);
  OSBSUCCESSMESSAGE VARCHAR2(32767);
  ONUERRORCODE      NUMBER;
  OSBERRORMESSAGE   VARCHAR2(2000);
  nuComplementoPR   NUMBER;
  nuComplementoSU   NUMBER;
  nuComplementoFA   NUMBER;
  nuComplementoCU   NUMBER;
  nuComplementoDI   NUMBER;
  vfecha_ini        DATE;
  vfecha_fin        DATE;
  vprograma         VARCHAR2(100);
  vcont             NUMBER := 0;
  vcontLec          NUMBER := 0;
  vcontIns          NUMBER := 0;
  Verror            Varchar2(4000);
  Sbdocumento       Varchar2(30) := Null;
  Nupredio          Ab_Address.Estate_Number%Type;
  Nusegmento        Ab_Address.Segment_Id%Type;
  Nutipopred        Number := 0;
  Nutipohomo        Number(4) := 0;
  Nucategoria       Number(2);
  Nusubcategoria    Number(2);
  Nucatehomo        Number(2);
  Nusucahomo        Number(2);
  nuDocumento       number;
  nuconsecutive     number;
  nublock           number;
  cursor cuPremise Is
    Select t.*
      From Ab_Address t, ldc_mig_direccion
     WHERE address_id = predhomo
       AND database = inubasedato
       AND ADDRESS_ID<>1
      /* AND ADDRESS_ID =  2978284*/;

  cursor cutmpPredio(nuDocumento number) is
    SELECT /*+ INDEX(B LDC_TEMP_PREDIO_PK_SGE)  INDEX(C TEM_SERVSUSC_SGE_PRED_SGE) */
     B.*, c.sesususc, c.sesufcin
      From Ldc_mig_direccion     a,
           LDC_TEMP_predio_SGE   b,
           ldc_temp_servsusc_sge c
     where a.predhomo = nuDocumento
       AND A.PREDCODI = B.PREDCODI
       AND A.DATABASE = B.BASEDATO
       AND B.BASEDATO = c.basedato(+)
       AND b.PREDCODI = c.sesupred(+)
       ORDER BY c.sesuserv;

    cursor cublocks(nudocumento number) is
    select a.manzhomo from ldc_mig_manzcata a,ldc_temp_predio_sge b,ldc_mig_direccion c
    where b.preddepa=a.codidepa
    and   b.predloca=a.codiloca
    and   b.predzoca=a.codizoca
    and   b.predseca=a.codiseca
    and   b.predmaca=a.codimaca
    and   b.predcodi=c.predcodi
    and   c.predhomo=nudocumento;

  Rttmppredio Cutmppredio%Rowtype;

  Cursor Cusegmento(nuSegmento number) Is
    Select * from AB_SEGMENTS WHERE SEGMENTS_ID = nuSegmento;

  cursor cuTipoPred(nuTipopred number) Is
    Select TIPRHOMO From Ldc_Mig_Tipopred where tiprcodi = nuTipopred;

  rtSegmento cusegmento%rowtype;

  cursor cuSubcategoria(Nucategoria number, nuSubcategoria number) Is
    Select Catehomo, Estrhomo
      From Ldc_Mig_Subcateg
     Where Codicate = Nucategoria
       and codisuca = nuSubcategoria;

  -- DECLARACION DE TIPOS.
  --
  TYPE tipo_cu_datos IS TABLE OF cuPremise%ROWTYPE;

  -- DECLARACION DE TABLAS TIPOS.
  --
  tbl_datos tipo_cu_datos := tipo_cu_datos();

  --- Control de errores
  nuLogError  NUMBER;
  NUTOTALREGS NUMBER := 0;
  NUERRORES   NUMBER := 0;
  NUCONECTION NUMBER := 0;
  FUNCTION FNUGETCONNECTION(NUADRID ab_address.address_id%TYPE) RETURN NUMBER IS
    NUADDRESS_ID NUMBER := 0;
  BEGIN
    SELECT 1 INTO NUADDRESS_ID FROM PR_PRODUCT WHERE ADDRESS_ID = NUADRID;
    RETURN(NUADDRESS_ID);
  EXCEPTION
    WHEN OTHERS THEN
      RETURN(0);
  END;
BEGIN
  VPROGRAMA := 'AB_PREMISE';

 /* DBMS_STATS.GATHER_TABLE_STATS('MIGRA',
  'LDC_MIG_DIRECCCION',
  ESTIMATE_PERCENT    => 100,
  CASCADE             => TRUE);
   */
  vfecha_ini := SYSDATE;
  -- Inserta registro de inicio en el log
  PKLOG_MIGRACION.PRINSLOGMIGRA(240,
                                240,
                                1,
                                VPROGRAMA,
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                NULOGERROR);
  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'P', RAPRFEIN = sysdate
   WHERE raprbase = inubasedato
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 240;
  commit;
  pkg_constantes.Complemento(inubasedato,
                             nuComplementoPR,
                             nuComplementoSU,
                             nuComplementoFA,
                             nuComplementoCU,
                             nuComplementoDI);

  -- Cantidad de registros Extraidos e Insertados
  vcontLec := 0;
  vcontIns := 0;

  -- Cargar datos

  OPEN cuPremise;

  LOOP
    --
    -- Borrar tablas     tbl_datos.
    --
    tbl_datos.delete;

    FETCH cuPremise BULK COLLECT
      INTO tbl_datos LIMIT 2000;

    NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
      BEGIN
        Rttmppredio := null;
        Rtsegmento  := null;
        nublock:=null;

        vcontLec := vcontLec + 1;

        Sbdocumento := Tbl_Datos(Nuindice).ADDRESS_ID;
        nuDocumento := Tbl_Datos(Nuindice).ADDRESS_ID;

        nuPredio := Tbl_Datos(Nuindice).ESTATE_NUMBER;

        open cuTmpPredio(nuDocumento);
        Fetch Cutmppredio
          Into Rttmppredio;
        close Cutmppredio;

        nuTipopred := Rttmppredio.PREDTIPR;
        Nusegmento := Tbl_Datos(Nuindice).Segment_Id;

        Open Cutipopred(nuTipopred);
        Fetch Cutipopred
          Into Nutipohomo;
        close cuTipoPred;

        open cuSegmento(Nusegmento);
        Fetch Cusegmento
          Into Rtsegmento;
        Close Cusegmento;

        open cublocks(nuDocumento);
        fetch cublocks into nublock;
        close cublocks;

        Nucategoria    := Rttmppredio.predcate;
        nuSubcategoria := Rttmppredio.predsuca;

        Open Cusubcategoria(Nucategoria, nuSubcategoria);
        Fetch Cusubcategoria
          Into Nucatehomo, Nusucahomo;
        close cuSubcategoria;
        
        Begin
          if inubasedato in (1,2,3) then
            nuconsecutive := to_number(substr(rttmppredio.PREDRUTL,-10,10));
          else
            nuconsecutive := to_number(substr(rttmppredio.predrure, 4));
          end if; 
        Exception
          When Others Then
            nuconsecutive := Null;
        End;

        if (ut_string.fnulength(nuconsecutive) > 10) then
          nuconsecutive := null;
        end if;

        if (ut_string.fnulength(Rttmppredio.PREDAPAR) > 10) then
          Rttmppredio.PREDAPAR := null;
        end if;

        BEGIN

          Update Ab_Premise
             Set Block_Id           = nublock,
                 Block_Side         = Rtsegmento.Block_Side,
                 Premise            = Rttmppredio.Prednupr,
                 Number_Division    = Rttmppredio.Prednume,
                 Premise_Type_Id    = Nutipohomo,
                 SEGMENTS_ID        = nuSegmento,
                 Zip_Code_Id        = Null,
                 Owner              = Rttmppredio.sesususc + nuComplementoSU,
                 House_Amount       = Rttmppredio.Prednuvl,
                 ROOMS_AMOUNT       = Rttmppredio.PREDNUHA,
                 Floors_Amount      = Rttmppredio.PREDNUPI,
                 Oficces_Amount     = Rttmppredio.Prednuof,
                 Blocks_Amount      = Rttmppredio.Prednubl,
                 Apartaments_Amount = Rttmppredio.PREDNUAP,
                 Locals_Amount      = Rttmppredio.Prednulo,
                 Floor_Number       = Rttmppredio.Predpiso,
                 APARTAMENT_NUMBER  = SUBSTR(Rttmppredio.PREDAPAR, 1, 4),
                 Servants_Passage   = 'N',
                 Setback_Building   = 'N',
                 Premise_Status_Id  = null,
                 Category_          = Nucatehomo,
                 SUBCATEGORY_       = NUSUCAHOMO,
                 CONSECUTIVE        = nuconsecutive,
                 Saledate           = Rttmppredio.sesufcin,
                 COOWNERSHIP_RATIO  = null
           Where Premise_Id = Nupredio;

          NUCONECTION := FNUGETCONNECTION(Tbl_Datos(Nuindice).ADDRESS_ID);
          Insert Into Ab_Info_Premise
            (Info_Premise_Id,
             Premise_Id,
             Is_Ring,
             Date_Ring,
             Is_Connection,
             Is_Internal,
             Internal_Type,
             Is_Measurement,
             Number_Points,
             Level_Risk,
             Description_Risk)
          VALUES
            (SEQ_AB_INFO_PREMISE_187754.NEXTVAL,
             NUPREDIO,
             DECODE(RTTMPPREDIO.PREDANIL,
                    'S',
                    'Y',
                    'N',
                    'N',
                    'N' /*RTTMPPREDIO.PREDANIL*/),
             RTTMPPREDIO.PREDFEAN,
             DECODE(RTTMPPREDIO.PREDACOM,
                    'S',
                    'Y',
                    'N',
                    'N',                                        
                    'N' /*RTTMPPREDIO.PREDACOM*/),
             DECODE(RTTMPPREDIO.PREDINTE,
                    'S',
                    'Y',
                    'N',
                    'N',
                    'N' /*RTTMPPREDIO.PREDINTE*/),
             NULL,
             Decode(Rttmppredio.Predtame,
                    'S',
                    'Y',
                    'N',
                    'N',
                    'N' /*Rttmppredio.Predtame*/),
             NUCONECTION,
             Rttmppredio.predries,
             NULL);
          IF Rttmppredio.sesususc IS NOT NULL THEN
            Insert Into Ab_Owner_Premise
              (Owner_Premise_Id, Premise_Id, Subscriber_Id)
            values
              (SEQ_AB_OWNER_PREMISE.NEXTVAL,
               Nupredio,
               pkbcsuscripc.fnugetsubscriberid(Rttmppredio.sesususc +
                                               nuComplementoSU));
          END IF;

          vcontIns := vcontIns + 1;

        EXCEPTION
          WHEN OTHERS THEN
            BEGIN

              NUERRORES := NUERRORES + 1;
              PKLOG_MIGRACION.prInsLogMigra(240,
                                            240,
                                            2,
                                            vprograma || vcontIns,
                                            0,
                                            0,
                                            'Predio : ' || Sbdocumento ||
                                            ' - Error: ' || sqlerrm,
                                            to_char(sqlcode),
                                            nuLogError);

            END;

        END;

      EXCEPTION
        WHEN OTHERS THEN
          BEGIN

            NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra(240,
                                          240,
                                          2,
                                          vprograma || vcontIns,
                                          0,
                                          0,
                                          'Predio : ' || Sbdocumento ||
                                          ' - Error: ' || sqlerrm,
                                          to_char(sqlcode),
                                          nuLogError);

          END;

      END;
    END LOOP;

    COMMIT;

    EXIT WHEN cuPremise%NOTFOUND;

  END LOOP;

  -- Cierra CURSOR.
  IF (cuPremise%ISOPEN) THEN
    --{
    CLOSE cuPremise;
    --}
  END IF;

  COMMIT;

  -- Termina Log
  PKLOG_MIGRACION.PRINSLOGMIGRA(240,
                                240,
                                3,
                                VPROGRAMA,
                                NUTOTALREGS,
                                NUERRORES,
                                'TERMINO PROCESO #regs: ' || VCONTINS,
                                'FIN',
                                NULOGERROR);
  UPDATE MIGR_RANGO_PROCESOS
     SET RAPRTERM = 'T', RAPRFEFI = sysdate
   WHERE raprbase = inubasedato
     AND raprrain = NUMINICIO
     AND raprrafi = NUMFINAL
     AND raprcodi = 240;
  commit;

EXCEPTION
  WHEN OTHERS THEN
    BEGIN

      NUERRORES := NUERRORES + 1;
      PKLOG_MIGRACION.prInsLogMigra(240,
                                    240,
                                    2,
                                    vprograma || vcontIns,
                                    0,
                                    0,
                                    'Predio : ' || Sbdocumento ||
                                    ' - Error: ' || sqlerrm,
                                    to_char(sqlcode),
                                    nuLogError);

    END;

END PR_AB_PREMISE; 
/
