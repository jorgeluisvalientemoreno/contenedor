CREATE OR REPLACE PROCEDURE     PR_AB_SEGMENTS(inuBASEDATO NUMBER) AS
 /* ******************************************************************
 PROGRAMA        :    PR_AB_SEGMENTS_V
 FECHA            :    27/09/2012
 AUTOR            :
 DESCRIPCION    :    Realiza el proceso para crear los segmentos de las manzanas
                    migradas a AB_BLOCKS a partir del campo Cara-Lado de los
                    predios de las bases de Datos GasPlus y GPNV.

 HISTORIA DE MODIFICACIONES
 AUTOR           FECHA     DESCRIPCION

 *******************************************************************/
    vfecha_ini          DATE;
    vfecha_fin          DATE;
    vprograma           VARCHAR2 (100);
    verror              VARCHAR2 (2000);
    vcontLec            NUMBER := 0;
    vcontIns            NUMBER := 0;
    nuErrorCode         NUMBER := NULL;
    nuContador          number := 0;
    sbErrorMessage      VARCHAR2 (2000) := NULL;
    blError             boolean := false;
    sbSegmento          varchar2(100) := null;
    rtViaInHomo         ldc_mig_vias%rowtype;
    rtViaCrHomo         ldc_mig_vias%rowtype;
    rtBarrio            ldc_mig_barrio%rowtype;
    rtSecOpe            or_operating_sector%rowtype;
    RTSEGMENT           AB_SEGMENTS%ROWTYPE;
    RTINDIVIDUALIMPAR   migra.LDC_TEMP_PREDIO_SGE%ROWTYPE;
    rtIndividualPar     migra.LDC_TEMP_PREDIO_SGE%rowtype;
    NUCATEGORIA         AB_SEGMENTS.CATEGORY_%TYPE;
    NUSUBCATEPAR        AB_SEGMENTS.SUBCATEGORY_%TYPE;
    nuCategoriaPar      ab_segments.category_%type;
    nuSubCate           ab_segments.subcategory_%type;
    nuInicial           number := 0;
    nuFinal             number := 0;
    nuContaPar          number := 0;
    nuContaImpar        number := 0;
    sbParidad           ab_segments.parity%type;
    nuSectorOpimpar          ab_segments.operating_sector_id%type;
    nuSectorOppar          ab_segments.operating_sector_id%type;
    rtsucahomoIMPAR          ldc_mig_subcateg%rowtype;
    rtsucahomoPAR          ldc_mig_subcateg%rowtype;
    nucicloIMPAR         number := 0;
    NUCICLHOMOIMPAR      number := 0;
    NUCICLHOMOPAR        number := 0;
    NUVALOR              NUMBER := 0;
    nucicloPar           number := 0;
    NUVALORPAr           number := 0;
    nuinicialPAr         number := 2;
    NUINICIALIMPAR       number := 1;
    NUmFINALPAR          number := 2;
    NUMFINALIMPAR        number := 1;
    NURUTAIMPAR          VARCHAR2(15);
    NURUTApar            VARCHAR2(15);
    SBLADO               VARCHAR2(4);
    NUBARRIOIMPAR        NUMBER := 0;
    nuBarrioPAr          number := 0;

      -- CURSOR segmentos en OSF
        cursor cuSegments (nuViaIn number, nuViaCr number,
                       nuIdGeo number, sbPAridad varchar)
          is
        select /*+ INDEX(AB_SEGMENTS OPT_IX_AB_SEGM_WAY_CROSS)*/ segments_id
          from ab_segments
         where WAY_ID = nuViaIn
           and CROSS_WAY_ID = nuViaCr
           and GEOGRAP_LOCATION_ID = nuIdGeo
           and PARITY = sbParidad ;

        nusegmentidpar number;
        nusegmentidimpar number;

    -- Cursor con los datos de origen
       -- Cursor con los datos de origen
        cursor CUPREDIO
        is
        SELECT DISTINCT A.PREDDEPA, A.PREDLOCA,
              A.PREDTVIN, A.PREDNUVI, A.PREDLUVI, A.PREDLDVI, A.PREDLZVI,
              a.PREDTVCR, a.PREDNUVC, a.PREDLUVC, a.PREDLDVC, a.PREDLZVC
         FROM migra.LDC_TEMP_PREDIO_SGE A
         WHERE A.BASEDATO = inuBASEDATO;

      cursor cuSectorImpar (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
        IS
      select predseop
      from migra.LDC_TEMP_PREDIO_SGE
      where basedato = inuBASEDATO
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
        and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           AND MOD(NVL(PREDNUCA,0),2) <> 0
           group by predseop
         order by count(*) desc;

     cursor cuSectorPar (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
        IS
      select predseop
      from migra.LDC_TEMP_PREDIO_SGE
      where basedato = inuBASEDATO
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
        and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           AND MOD(NVL(PREDNUCA,0),2) = 0
           group by predseop
         order by count(*) desc;

    -- CURSOR con barrios en el origen para el segmento impar
      cursor cuBarrioImpar (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
        IS
      select predbarr
      from migra.LDC_TEMP_PREDIO_SGE
      where basedato = inuBASEDATO
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
        and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           AND MOD(NVL(PREDNUCA,0),2) <> 0
           group by PREDBARR
         order by count(*) desc;

   -- CURSOR con barrios en el origen para el segmento impar
      cursor cuBarrioPar (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
        IS
      select predbarr
      from migra.LDC_TEMP_PREDIO_SGE
      where basedato = inuBASEDATO
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
        and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           AND NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and MOD(NVL(PREDNUCA,0),2) = 0
           GROUP BY PREDBARR
         order by count(*) desc;

    -- Datos adicionales del segmento
    cursor cuIndividualIMPAR (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
        is
    select *
      from migra.LDC_TEMP_PREDIO_SGE
     where basedato = inuBASEDATO
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
        and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and MOD(NVL(PREDNUCA,0),2) <> 0;

    -- Datos adicionales del segmento PAR
    cursor cuIndividualPAR (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
        is
    select *
      from MIGRA.LDC_TEMP_PREDIO_SGE
     where basedato = inuBASEDATO
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
        and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and MOD(NVL(PREDNUCA,0),2) = 0;

    -- Barrio homologado en OSF
     cursor cuBarrHomo (nuDepa number, nuLoca number, nuBarrio number)
        is
       select BARRHOMO
       from LDC_MIG_BARRIO
       where CODIDEPA = NUDEPA
        and CODILOCA = NuLOCA
        and CODIBARR = nuBarrio;

     --Cursor de Vias Homologadas
     cursor cuViaHomo (nuDepa number, nuLoca number,
                      sbTiVi varchar2, nuVia number,
                      sbLUVI varchar2, sbLDVI varchar2,
                      sbLZVI varchar2)
          is
        select *
          from ldc_mig_vias
         where PREDDEPA = nuDepa
           and PREDLOCA = nuLoca
           and rtrim(ltrim(PREDTVIN))= sbTiVi
           and PREDNUVI = nuVia
           and database = inubasedato
           and nvl(rtrim(ltrim(PREDLUVI)),'%') = nvl(sbLUVI,'%')
           and nvl(rtrim(ltrim(PREDLDVI)),'%') = nvl(sbLDVI,'%')
           and nvl(rtrim(ltrim(PREDLZVI)),'%') = nvl(sbLZVI,'%');


   --Cursor de Manzanas
    cursor cuManzana (nuDepa number, nuLoca number,
                      nuZoca number, nuSeca number,
                      nuMaca number)
          is
        select *
          from AB_BLOCK A, LDC_MIG_MANZCATA B
         where A.BLOCK_ID = B.MANZHOMO
           and B.CODIDEPA = nuDepa
           and B.CODILOCA = nuLoca
           and B.CODIZOCA = nuZoca
           and B.CODISECA = nuSeca
           and B.CODIMACA = nuMaca;

    rtManzanaPAR           cuManzana%rowtype;
    rtManzanaIMPAR           cuManzana%rowtype;

-- Cursor de SubCategoria para el segmento.
    cursor cuSubCateIMPAR (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
          is
        select predcate, predsuca, count(*) cantidad
          from MIGRA.LDC_TEMP_PREDIO_SGE
          where BASEDATO = inuBASEDATO
            and PREDDEPA = NUDEPA
           and PREDLOCA = NULOCA
           and PREDTVIN = SBTIPO
           and PREDNUVI = NUNUME
           and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           AND PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and MOD(NVL(PREDNUCA,0),2) <> 0
           AND exists (select 1 from ldc_mig_subcateg where codicate=predcate and codisuca=predsuca)
         group by predcate, predsuca
         order by count(*) desc;
-- CURSOR para la homologación de la categoria

    cursor cuSucaHomo (nuCate number, nuSuca number)
        is
    select *
     from LDC_MIG_SUBCATEG
    WHERE CODICATE = nuCate
      AND CODISUCA = nuSuca;

-- Cursor para validar que el Sector Operativo est� registrado.
        cursor cuSecOpe (Nudepa   Number,
                   nuLoca   number,
                     nuSecOpe number)
          is
        select CODIHOMO
          from LDC_MIG_SECTOPER
         where codidepa = nudepa
           and codiloca = nuloca
           and codisect = nuSecOpe;

   -- Cursor para definir el tipo de numeracion que lleva el segmento.
    cursor cuNumera (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
    is
    select nvl(prednuca,0) prednuca
         from migra.LDC_TEMP_PREDIO_SGE
               --predio@qgpnv
         where  BASEDATO = inuBASEDATO
         AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
      and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           and nvl(PREDLZVC,'%') = nvl(SBZONA1,'%');

-- Ciclo PAR
      cursor cuCicloPar (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
          IS
        select PREDCICL --, count(predsruca)
          from  migra.LDC_TEMP_PREDIO_SGE a, migra.ldc_temp_servsusc_sge b
      where a.basedato = inuBASEDATO
       AND a.basedato=b.basedato
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
      and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and predcate < 3
           AND predcodi =sesupred
           and prednuca is not null
           and MOD(NVL(PREDNUCA,0),2) = 0
         GROUP BY PREDCICL
         order by count(*) desc;

-- CICLO IMPAR

        cursor cuCicloIMPAR (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
          is
        select PREDCICL --, count(predsuca)
          from  migra.LDC_TEMP_PREDIO_SGE a, migra.ldc_temp_servsusc_sge b
      where a.basedato = inuBASEDATO
       AND a.basedato=b.basedato
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
      and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and predcate < 3
           AND predcodi =sesupred
           and prednuca is not null
           and MOD(NVL(PREDNUCA,0),2) <> 0
         group by predcicl
         order by count(*) desc;

-- Homologación de ciclos
        cursor cuCiclo_homo (nuciclo number)
        is
        select CICLHOMO
        from ldc_mig_ciclo
        where codicicl = nuciclo
        and database = inubasedato;

--  Ruta Impar
    cursor cuRutaIMPAR (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2, nuCiclo NUMBER)
          IS
        select (SUBSTR(PREDRUTL,1,3))--, count(predsuca)
          from   migra.LDC_TEMP_PREDIO_SGE
      where basedato = inuBASEDATO
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
      and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and MOD(NVL(PREDNUCA,0),2) <> 0
           AND PREDCICL = nuCiclo
         GROUP BY (SUBSTR(PREDRUTL,1,3))
         order by count(*) desc;

--  Ruta PAR
    cursor cuRutaPAR (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2, nuCiclo NUMBER)
          IS
        select (SUBSTR(PREDRUTL,1,3))--, count(predsuca)
          from  migra.LDC_TEMP_PREDIO_SGE
      where basedato = inuBASEDATO
       AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
      and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and MOD(NVL(PREDNUCA,0),2) = 0
           AND PREDCICL = nuCiclo
         GROUP BY (SUBSTR(PREDRUTL,1,3))
         order by count(*) desc;


  -- CURSOR LADO SEGMENTO
   cursor cuLado (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
          is
        select nvl(predcala,'A') predcala
          from migra.LDC_TEMP_PREDIO_SGE
               --predio@qgpnv
         where basedato = inuBASEDATO
         AND PREDDEPA = NUDEPA
       and PREDLOCA = NULOCA
       and PREDTVIN = SBTIPO
       and PREDNUVI = NUNUME
        and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           and nvl(PREDLZVC,'%') = nvl(SBZONA1,'%')
      group by PREDCALA
         order by count(*) desc;

-- CURSOR subcategoria par
    cursor cuSubCatePar (NUDEPA number, NULOCA number, SBTIPO varchar2, NUNUME number, SBL1 varchar2, SBL2 varchar2, SBZONA varchar2,
                     SBTIPO1 varchar2, NUNUME1 number, SBL11 varchar2, SBL21 varchar2, SBZONA1 varchar2)
          is
        select predcate, predsuca, count(*) cantidad
          from Migra.LDC_TEMP_PREDIO_SGE
          where BASEDATO = inuBASEDATO
            and PREDDEPA = NUDEPA
           and PREDLOCA = NULOCA
           and PREDTVIN = SBTIPO
           and PREDNUVI = NUNUME
           and nvl(PREDLUVI,'%') = nvl(SBL1,'%')
           and nvl(PREDLDVI,'%') = nvl(SBL2,'%')
           and nvl(PREDLZVI,'%') = nvl(SBZONA,'%')
           and PREDTVCR = SBTIPO1
           and PREDNUVC = NUNUME1
           and nvl(PREDLUVC,'%') = nvl(SBL11,'%')
           and NVL(PREDLDVC,'%') = NVL(SBL21,'%')
           AND NVL(PREDLZVC,'%') = NVL(SBZONA1,'%')
           and MOD(NVL(PREDNUCA,0),2) = 0
           AND exists (select 1 from ldc_mig_subcateg where codicate=predcate and codisuca=predsuca)
         group by predcate, predsuca
         order by count(*) desc;

TYPE TIPO_CU_DATOS IS TABLE OF CUPREDIO%ROWTYPE;
  -- DECLARACION DE TABLAS TIPOS.
tbl_datos      tipo_cu_datos := tipo_cu_datos ();

-- tipo registro
         RTBARRIOPAR CUBARRIOPAR%ROWTYPE;
         rtBarrioImpar cuBarrioImpar%rowtype;

         RTSECTORPAR cusectorPar%ROWTYPE;
         rtSECTORIMPAR cuSectorImpar%rowtype;
  --- Control de Errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

BEGIN
    vprograma := 'AB_SEGMENTS_V';
    vfecha_ini := SYSDATE;

    PKLOG_MIGRACION.prInsLogMigra (145,145,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);

 -- Extraer Datos y cargarlos
    blError := False;
    nuErrorCode := NULL;
    sbErrorMessage := null;
    --nuContador := 2; --Se inicia en 2 porque el c�digo 1 es un registro comodin

    OPEN cuPredio;
    LOOP
        -- Borrar tablas     tbl_datos.
        tbl_datos.delete;

        -- se carga de 1000 registros en 1000 registros
        FETCH cuPredio
        BULK COLLECT INTO tbl_datos
        LIMIT 1000;
        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

        -- se comienzan a recorrer los registros
        FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
          BEGIN

               --Se inicializan Variables
                blError := False;
                nuErrorCode := NULL;
                SBERRORMESSAGE := null;
                nuSegmentidpar:= null;
                nuSegmentidimpar:= null;
                SBSEGMENTO:=null;
                rtBarrioimPAR:=null;
                rtSectorimpAR:= null;
                NUBARRIOIMPAR:= null;
                RTINDIVIDUALIMPAR:=null;
                nuCategoria:=null;
                nuSubCate:=Null;
                nuValor:=Null;
                rtsuCaHomoIMPAR:=Null;
                rtManzanaIMPAR:=Null;
                nuSectorOpimpar:=Null;
                nuCicloIMPAR:=Null;
                nuciclHomoIMPAR:=Null;
                nuRutaIMPAR:=Null;
                rtViaInHomo:=Null;
                rtViaCrHomo:=Null;
                NUMFINALPAR:=0;
                NUMFINALimPAR:=0;
                sbLAdo:=Null;
                nuSegmentidimpar:=Null;
                rtBarrioPAR:=Null;
                rtSectorPAR:=NUll;
                NUBARRIOPAR:=Null;
                NUCATEGORIAPAR:=Null;
                NUSUBCATEPAR:=NUll;
                NUVALORPAR:=Null;
                RTSUCAHOMOPAR:=NULL;
                RTINDIVIDUALPAR:=NUll;
                rtManzanaPAR:=Null;
                nuSectorOpPAR:=Null;
                nuCicloPAR:=Null;
                nuciclHomoPAR:=NUll;
                nuRutapar:=Null;
                nuSegmentidpar:=NUll;

                -- se guarda el dato de la cuadra de donde pueden salir dos segmentos
                SBSEGMENTO := TBL_DATOS (NUINDICE).PREDDEPA||'-'||TBL_DATOS (NUINDICE).PREDLOCA||'-'||TBL_DATOS (NUINDICE).PREDTVIN||'-'||
                              TBL_DATOS (NUINDICE).PREDNUVI||'-'||TBL_DATOS (NUINDICE).PREDLUVI||'-'||TBL_DATOS (NUINDICE).PREDLDVI||'-'||
                              TBL_DATOS (NUINDICE).PREDLZVI||'-'||TBL_DATOS (NUINDICE).PREDTVCR||'-'||TBL_DATOS (NUINDICE).PREDNUVC||'-'||
                              TBL_DATOS (NUINDICE).PREDLUVC||'-'||TBL_DATOS (NUINDICE).PREDLDVC||'-'||TBL_DATOS (NUINDICE).PREDLZVC;


-- INICIA RECOLECCIÿN DE DATOS SEGMENTO IMPAR

               -- CURSOR BARRIO IMPAR
                open CUBARRIOIMPAR(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                    TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR,
                                    TBL_DATOS (NUINDICE).PREDNUVC, TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                FETCH CUBARRIOIMPAR INTO rtBarrioimPAR;
                close CUBARRIOIMPAR;

                open cuSectorImpar(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                    TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR,
                                    TBL_DATOS (NUINDICE).PREDNUVC, TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                FETCH cuSectorImpar INTO rtSectorimPAR;
                close cuSectorImpar;

                -- CURSOR que obtiene el barrio en smartflex IMPAR
                OPEN CUBARRHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA,rtBarrioImpar.PREDBARR );
                FETCH CUBARRHOMO INTO NUBARRIOIMPAR;
                CLOSE CUBARRHOMO;

               -- CURSOR que obtiene datos adicionales para crear la manzana y el sector operativo
                open CUIndividualIMPAR (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                        TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR,
                                        TBL_DATOS (NUINDICE).PREDNUVC, TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                FETCH CUIndividualIMPAR INTO RTINDIVIDUALIMPAR;
                close CUIndividualIMPAR;


                -- CURSOR de Subcategoria.
                open CUSUBCATEIMPAR(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN ,
                                TBL_DATOS (NUINDICE).PREDNUVI, tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi,
                                TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR, TBL_DATOS (NUINDICE).PREDNUVC,
                                TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                fetch CUSUBCATEIMPAR into nuCategoria, nuSubCate, nuValor;
                if CUSUBCATEIMPAR%notfound then
                    NUERRORCODE := 6;
                END if;
                CLOSE CUSUBCATEIMPAR;

                -- CURSOR de  Subcategoria Homologada IMPAR
                OPEN cusuCaHomo(nuCategoria, nuSubCate);
                fetch cusuCaHomo into rtsuCaHomoIMPAR;
                close cusuCaHomo;


                -- CURSOR de manzanas impar
                open cuManzana (tbl_datos (nuindice).preddepa, tbl_datos (nuindice).predloca, RTINDIVIDUALIMPAR.predzoca,
                                RTINDIVIDUALIMPAR.PREDSECA, RTINDIVIDUALIMPAR.PREDMACA);
                fetch cuManzana into rtManzanaIMPAR;
                if cuManzana%notfound then
                    nuErrorCode := 3;
                END if;
                CLOSE CUMANZANA;

                -- CURSOR que obtiene Sector operativo IMPAR
                -- Se valida que el sector operativo del segmento exista.
                open cuSecOpe(tbl_datos (nuindice).preddepa,tbl_datos (nuindice).predloca,rtSectorIMPAR.predseop);
                fetch cuSecOpe into nuSectorOpimpar;
                if cuSecOpe%notfound then
                   nuErrorCode := 7;
                END if;
                close cuSecOpe;

                   --  blError := TRUE;

                -- CURSOR de ciclo IMPAR
                open cuCicloIMPAR(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN ,
                                      TBL_DATOS (NUINDICE).PREDNUVI, tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi,
                                      TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR, TBL_DATOS (NUINDICE).PREDNUVC,
                                      TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                fetch cuCicloIMPAR into nuCicloIMPAR;
                close cuCicloIMPAR;

                -- CURSOR de ciclo Homologado
                open cuciclo_homo(nuCicloIMPAR);
                fetch cuciclo_homo into nuciclHomoIMPAR;
                close cuciclo_homo;

                 -- CURSOR de ruta IMPAR
                open cuRutaIMPAR(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN ,
                                 TBL_DATOS (NUINDICE).PREDNUVI, tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi,
                                 TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR, TBL_DATOS (NUINDICE).PREDNUVC,
                                 TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC,
                                 nuCicloImpar);
                fetch cuRutaIMPAR into nuRutaIMPAR;
                close cuRutaIMPAR;

                if NUCICLHOMOIMPAR=-1 then
                    NURUTAIMPAR :=-1;
                else
                    if inubasedato= 5 then
                    NURUTAIMPAR := NUCICLHOMOIMPAR||NURUTAIMPAR;
                    else
                    NURUTAIMPAR := NUCICLHOMOIMPAR||nuSectorOpimpar;
                    END if;
                end if;


-- DATOS DE PARES e IMPARES

                -- CURSOR Via Principal Homologada
                open cuViaHomo (tbl_datos (nuindice).preddepa, tbl_datos (nuindice).predloca, tbl_datos (nuindice).PREDTVIN , tbl_datos (nuindice).PREDNUVI,
                                    tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi, tbl_datos (nuindice).predlzvi);
                fetch cuViaHomo into rtViaInHomo;
                CLOSE CUVIAHOMO;

                -- CURSOR de Via De cruce Homologada
                open cuViaHomo (tbl_datos (nuindice).preddepa, tbl_datos (nuindice).predloca, tbl_datos (nuindice).PREDTVCR , tbl_datos (nuindice).PREDNUVC,
                                tbl_datos (nuindice).predluvc, tbl_datos (nuindice).predldvc, tbl_datos (nuindice).predlzvc);
                fetch cuViaHomo into rtViaCrHomo;
                if cuViaHomo%notfound then
                    nuErrorCode := 2;
                END if;
                CLOSE CUVIAHOMO;


                -- CURSOR de Numeración
                for rtNumera in cuNumera (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN ,
                                             TBL_DATOS (NUINDICE).PREDNUVI, tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi,
                                             TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR, TBL_DATOS (NUINDICE).PREDNUVC,
                                             TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC)
                loop
                       -- si es par
                    if MOD(NVL(RTNUMERA.PREDNUCA,0),2) = 0 then
                          if NUMFINALPAR < RTNUMERA.PREDNUCA then
                             NUMFINALPAR := RTNUMERA.PREDNUCA;
                          end if;
                    else
                       -- si es impar
                          if NUMFINALimPAR < RTNUMERA.PREDNUCA then
                             NUMFINALimPAR := RTNUMERA.PREDNUCA;
                          end if;

                       end if;

                End loop;

                if NUMFINALPAR=0 then
                   NUMFINALPAR:=1;
                End if;

                if NUMFINALIMPAR=0 then
                   NUMFINALIMPAR:=1;
                end if;

                              -- CURSOR LADO DEL SEGMENTO PAR
                open cuLado(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN ,
                                      TBL_DATOS (NUINDICE).PREDNUVI, tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi,
                                      TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR, TBL_DATOS (NUINDICE).PREDNUVC,
                                      TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                FETCH cuLado into sbLAdo;
                close cuLado;


--                dbms_output.put_line(NUBARRIOIMPAR||'.'||NUCICLHOMOIMPAR||'.'||rtsuCaHomoIMPAR.CATEHOMO);


-- INSERTA SI HAY DIRECCIONES IMPARES
                open cuSegments (rtViaInHomo.conshomo, rtViaCrHomo.conshomo, rtManzanaIMPAR.locahomo, 'I');
                fetch cuSegments into nuSegmentidimpar;
                close cuSegments;

               -- dbms_output.put_line(nuSegmentidimpar);

                if   nuSegmentidimpar IS null then

                        IF    ((NUBARRIOIMPAR <>0)and (NUCICLHOMOIMPAR <>0) AND (rtsuCaHomoIMPAR.CATEHOMO IS not null)
                                AND (RTVIAINHOMO.CONSHOMO IS not null) AND (RTVIACRHOMO.CONSHOMO IS not null)) then

                                begin
                                        INSERT /*+ APPEND*/
                                        INTO AB_SEGMENTS (SEGMENTS_ID, WAY_ID, CROSS_WAY_ID, GEOGRAP_LOCATION_ID, BLOCK_ID, BLOCK_SIDE, NEIGHBORHOOD_ID, INIT_NUMBER,
                                                            final_number, zip_code_id, parity, entrecalle1, entrecalle2, shape, category_, subcategory_, operating_sector_id,
                                                             ADITIONAL_DATA, SEGMENT_TYPE, CICLCODI, CICOCODI, ROUTE_ID)
                                        values (SEQ_AB_SEGMENTS.NEXTVAL, RTVIAINHOMO.CONSHOMO, RTVIACRHOMO.CONSHOMO, RTMANZANAIMPAR.LOCAHOMO, RTMANZANAIMPAR.BLOCK_ID, SBLADO,
                                                NUBARRIOIMPAR,1, NUMFINALIMPAR, null, 'I', null, null, null,  rtsuCaHomoIMPAR.CATEHOMO,
                                                rtsuCaHomoIMPAR.ESTRHOMO,DECODE(NUSECTOROPIMPAR,null,1,NUSECTOROPIMPAR), null, 'C', NUCICLHOMOIMPAR, NUCICLHOMOIMPAR,
                                                NURUTAIMPAR);
                                        Commit;
                                EXCEPTION
                                WHEN OTHERS THEN
                                    BEGIN

                                            NUERRORES := NUERRORES + 1;
                                            PKLOG_MIGRACION.prInsLogMigra ( 145,145,2,vprograma||vcontIns,0,0,'Segmento : '||sbSegmento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                                    END;
                                end;
                        END if;

                 END if;


-- INICIA RECOLECCIÿN DE DATOS SEGMENTO PAR
                -- Barrio PAR
                open CUBARRIOPAR   (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                    TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR,
                                    TBL_DATOS (NUINDICE).PREDNUVC, TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                fetch CUBARRIOPAR into rtBarrioPAR;
                CLOSE CUBARRIOPAR;


                open CUSectorPar   (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                    TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR,
                                    TBL_DATOS (NUINDICE).PREDNUVC, TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                fetch CUSectorPar into rtSectorPAR;
                CLOSE CUSectorPar;

                -- CURSOR que obtiene el barrio en smartflex PAR
                OPEN CUBARRHOMO   (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA,rtBarrioPAR.PREDBARR );
                FETCH CUBARRHOMO INTO NUBARRIOPAR;
                CLOSE CUBARRHOMO;

                -- CURSOR que obtiene la subcategoria  PAR
                open CUSUBCATEPAR (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN ,
                                   TBL_DATOS (NUINDICE).PREDNUVI, tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi,
                                   TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR, TBL_DATOS (NUINDICE).PREDNUVC,
                                   TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                FETCH CUSUBCATEPAR INTO NUCATEGORIAPAR, NUSUBCATEPAR, NUVALORPAR;
                CLOSE CUSUBCATEPAR;

                -- CURSOR que obtiene la subcategoria  PAR Homologada
                OPEN CUSUCAHOMO (NUCATEGORIAPAR, NUSUBCATEPAR);
                FETCH CUSUCAHOMO INTO RTSUCAHOMOPAR;
                close cusuCaHomo;

                -- CURSOR que obtiene datos adicionales para crear la manzana y el sector operativo
                open cuIndividualPAR (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                        TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR,
                                        TBL_DATOS (NUINDICE).PREDNUVC, TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                FETCH cuIndividualPAR INTO RTINDIVIDUALPAR;
                close cuIndividualPAR;

                -- CURSOR de manzanas par
                open cuManzana (tbl_datos (nuindice).preddepa, tbl_datos (nuindice).predloca, RTINDIVIDUALPAR.predzoca,
                                             RTINDIVIDUALPAR.PREDSECA, RTINDIVIDUALPAR.PREDMACA);
                fetch cuManzana into rtManzanaPAR;
                if cuManzana%notfound then
                    nuErrorCode := 3;
                END if;
                CLOSE CUMANZANA;

                -- CURSOR que obtiene Sector operativo par
                -- Se valida que el sector operativo del segmento exista.
                open cuSecOpe(tbl_datos (nuindice).preddepa,tbl_datos (nuindice).predloca,rtSectorPAR.predseop);
                fetch cuSecOpe into nuSectorOpPAR;
                if cuSecOpe%notfound then
                   nuErrorCode := 7;
                END if;
                close cuSecOpe;


                -- CURSOR de ciclo PAR
                open  cuCicloPAR(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN ,
                                      TBL_DATOS (NUINDICE).PREDNUVI, tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi,
                                      TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR, TBL_DATOS (NUINDICE).PREDNUVC,
                                      TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
                fetch cuCicloPAR into nuCicloPAR;
                close cuCicloPAR;

                -- CURSOR de ciclo Homologado
                open cuciclo_homo(nuCicloPAR);
                fetch cuciclo_homo into nuciclHomoPAR;
                close cuciclo_homo;

                 -- CURSOR de ruta IMPAR
                open cuRutaPAR  (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN ,
                                 TBL_DATOS (NUINDICE).PREDNUVI, tbl_datos (nuindice).predluvi, tbl_datos (nuindice).predldvi,
                                 TBL_DATOS (NUINDICE).PREDLZVI, TBL_DATOS (NUINDICE).PREDTVCR, TBL_DATOS (NUINDICE).PREDNUVC,
                                 TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC,
                                 nuCicloPar);
                fetch cuRutaPAR into nuRutapar;
                close cuRutaPAR;

                if nuciclHomoPAR=-1 then
                    NURUTAPAR :=-1;
                else
                    if inubasedato = 5 then
                        NURUTAPAR := nuciclHomoPAR||NURUTAPAR;
                    else
                        NURUTAPAR := nuciclHomoPAR||nuSectorOpPAR;
                    END if;
                end if;

                open cuSegments (rtViaInHomo.conshomo, rtViaCrHomo.conshomo, rtManzanaPAR.locahomo, 'P');
                fetch cuSegments into nuSegmentidpar;
                close cuSegments;

--                 dbms_output.put_line(NUBARRIOPAR||'.'||NUCICLHOMOPAR||'.'||rtsuCaHomoPAR.CATEHOMO||'.');
  --                               dbms_output.put_line(nuSegmentidpar);
                    IF   nuSegmentidpar IS null then

                -- INserta si hay direcciones PARES
                        IF    ((NUBARRIOPAR <>0)and (NUCICLHOMOPAR <>0) AND (rtsuCaHomoPAR.CATEHOMO IS not null)
                                AND (RTVIAINHOMO.CONSHOMO IS not null) AND (RTVIACRHOMO.CONSHOMO IS not null)) then

                                begin
                                     INSERT /*+ APPEND*/ INTO AB_SEGMENTS (SEGMENTS_ID, WAY_ID, CROSS_WAY_ID, GEOGRAP_LOCATION_ID, BLOCK_ID, BLOCK_SIDE, NEIGHBORHOOD_ID, INIT_NUMBER,
                                                            final_number, zip_code_id, parity, entrecalle1, entrecalle2, shape, category_, subcategory_, operating_sector_id,
                                                             ADITIONAL_DATA, SEGMENT_TYPE, CICLCODI, CICOCODI, ROUTE_ID)
                                         values (SEQ_AB_SEGMENTS.NEXTVAL, RTVIAINHOMO.CONSHOMO, RTVIACRHOMO.CONSHOMO, RTMANZANAPAR.LOCAHOMO, RTMANZANAPAR.BLOCK_ID, SBLADO,
                                                 NUBARRIOPAR,1, NUMFINALPAR, null, 'P', null, null, null,  rtsuCaHomoPAR.CATEHOMO,
                                                rtsuCaHomoPAR.ESTRHOMO,DECODE(NUSECTOROPPAR,null,1,NUSECTOROPPAR), null, 'C', NUCICLHOMOPAR, NUCICLHOMOPAR,
                                                 NURUTAPAR);

                                         Commit;
                                EXCEPTION
                                       WHEN OTHERS THEN
                                          BEGIN

                                             NUERRORES := NUERRORES + 1;
                                             PKLOG_MIGRACION.prInsLogMigra ( 145,145,2,vprograma||vcontIns,0,0,'Segmento : '||sbSegmento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                                          END;
                                end;
                        END if;

                    END if;
           -- se maneja log de excepciones
          EXCEPTION
              WHEN OTHERS THEN
                 BEGIN
                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 145,145,2,vprograma||vcontIns,0,0,'Segmento : '||sbSegmento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                     IF (CUBARRIOIMPAR%ISOPEN) THEN
                          CLOSE CUBARRIOIMPAR;
                     END IF;
                     IF (CUIndividualPAR%ISOPEN) THEN
                          CLOSE CUIndividualPAR;
                     END IF;
                     IF (CUIndividualIMPAR%ISOPEN) THEN
                          CLOSE CUIndividualIMPAR;
                     END IF;
                     IF (CUBARRHOMO%ISOPEN) THEN
                          CLOSE CUBARRHOMO;
                     END IF;
                     if (cuViaHomo%isopen)  then
                        close cuViaHomo;
                     end if;
                     if (cuManzana%isopen)  then
                        close cuManzana;
                     end if;
                     if (cuSubCateIMPAR%isopen)  then
                        close cuSubCateIMPAR;
                     end if;
                     if (CUSUBCATEPAR%isopen)  then
                        close CUSUBCATEPAR;
                     end if;
                     if (cuSecOpe%isopen)  then
                        close cuSecOpe;
                     end if;
                     if (cuCicloIMPAR%isopen)  then
                        close cuCicloIMPAR;
                     end if;
                     if (cuCicloPAR%isopen)  then
                        close cuCicloPAR;
                     end if;
                     if (cuciclo_homo%isopen)  then
                        close cuciclo_homo;
                     end if;
                     if (cuRutaIMPAR%isopen)  then
                        close cuRutaIMPAR;
                     end if;
                     if (cuNumera%isopen) then
                        close cuNumera;
                     END if;
                     if (cusuCaHomo%isopen) then
                        close cusuCaHomo;
                     END if;
                     if (cuLado%isopen) then
                        close cuLado;
                     END if;
                     if (CUBARRIOPAR%isopen) then
                        close CUBARRIOPAR;
                     END if;
                     if (cuRutaPAR%isopen) then
                        close cuRutaPAR;
                     END if;

                  END;
          END;
        END loop;




       EXIT WHEN cupredio%NOTFOUND;
   end loop;

    IF (cupredio%ISOPEN) THEN
        CLOSE cupredio;
    END IF;
    --dbms_output.put_line('NUTOTALREGS: '||NUTOTALREGS);

   PKLOG_MIGRACION.prInsLogMigra (145,145,3,vprograma,0,0,'Temina Proceso','FIN',nuLogError);

EXCEPTION
     WHEN OTHERS THEN
        BEGIN
                IF (cupredio%ISOPEN) THEN
                    CLOSE cupredio;
                END IF;
                NUERRORES := NUERRORES + 1;
                PKLOG_MIGRACION.prInsLogMigra ( 145,145,2,vprograma||vcontIns,0,0,'Segmento : '||sbSegmento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

    END;

  END PR_AB_SEGMENTS; 
/
