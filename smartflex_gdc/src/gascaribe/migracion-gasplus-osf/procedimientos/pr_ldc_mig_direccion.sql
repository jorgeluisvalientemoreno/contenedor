CREATE OR REPLACE PROCEDURE      PR_LDC_MIG_DIRECCION(inubasedato number)
is
  /*******************************************************************
-- PROCEDIMIENTO :    LDC_MIG_DIRECCION_C
 FECHA             :    24/09/2012
 AUTOR             :
 DESCRIPCION     :    Migra la informacion de predios a LDC_MIC_CLIENTES
                  de la bd Cali
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
    CURSOR cupredio /* cursor donde estan los predios asociados a servicios suscritos de gas */
       IS
      SELECT /*+ index (LDC_TEMP_SERVSUSC INDEX3_LDC_TEMP_SERVSUSC)*/
             H.preddepa,
             H.predloca,
             H.preddire,
             H.PREDDEPA||'-'||H.PREDLOCA||'-'||H.PREDZOCA||'-'||H.PREDSECA||'-'||H.PREDMACA||'-'||H.PREDNUPR||'-'||H.PREDNUME||'-'||H.PREDCONS predcodi,
             H.predtag,
             H.PREDCALA,
             H.PREDMULT,
      replace(replace(replace(replace(
       CASE
         WHEN ((SELECT count(divisino) from ldc_temp_diccvias_SGE WHERE diviloca =h.predloca AND dividepa =h.preddepa AND divinume = to_char(H.prednuvi)||to_char(H.predluvi) AND  divitivi= DECODE( to_char(H.predtvin), 'CL','C','KR','K','AV','A','DG','D','TV','T',h.predtvin) AND BASEDATO=inubasedato) =1 ) then
                (select   replace(replace(replace( replace(replace(replace(substr(LTRIM(divisino),1, instr(LTRIM(divisino),' ')-1),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CRA','KR'),'CR','KR'),'SECTOR','SECTOR_')||' '||
                  replace(replace(replace(replace(replace(decode(REGEXP_SUBSTR(substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1),'^[A-Z]')
                 ,null,replace(substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1),' ','')
                 ,substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1)),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CRA','KR'),'CR','KR') DIVISINO
                 FROM ldc_temp_diccvias_SGE
                WHERE diviloca =  h.predloca
                AND  dividepa= h.preddepa
                AND  divitivi= DECODE( to_char(H.predtvin), 'CL','C','KR','K','AV','A','DG','D','TV','T',h.predtvin)
                AND divinume = to_char(H.prednuvi)||to_char(H.predluvi)
                AND BASEDATO=inubasedato)

         ELSE
                decode (H.predtvin,'P','PAJ',h.predtvin)||' '||H.prednuvi||decode(isnumber(H.predluvi),1,' '||H.predluvi,H.predluvi)
       END ||decode(H.predldvi,null,null,'B',' BIS',
             decode(isnumber(H.predluvi),1,decode(isnumber(H.predldvi),1,' '||H.predldvi,H.predldvi),H.predldvi))
             ||decode(H.predlzvi,null,null,'N',' NORTE','S',' SUR','O',' OESTE','E',' ESTE','W',' OESTE',
             decode(isnumber(H.predldvi),1,decode(isnumber(H.predlzvi),1,' '||H.predlzvi,H.predlzvi),H.predlzvi))||' '||
        CASE
         WHEN ((SELECT count(divisino) from ldc_temp_diccvias_SGE WHERE diviloca =h.predloca AND dividepa =h.preddepa AND divinume = to_char(H.prednuvc)||to_char(H.predluvc) AND  divitivi= DECODE( to_char(H.predtvcr), 'CL','C','KR','K','AV','A','DG','D','TV','T',h.predtvcr) AND BASEDATO=inubasedato)  =1  ) then
                (select    replace(replace(replace(replace(replace(replace(substr(LTRIM(divisino),1, instr(LTRIM(divisino),' ')-1),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CRA','KR'),'CR','KR'),'SECTOR','SECTOR_')||' '||
                 replace(replace(replace(replace(replace( decode(REGEXP_SUBSTR(substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1),'^[A-Z]')
                 ,null,replace(substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1),' ','')
                 ,substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1)),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CRA','KR'),'CR','KR') DIVISINO
                  FROM ldc_temp_diccvias_sge
                WHERE diviloca =h.predloca
                AND dividepa =h.preddepa
                AND  divitivi= DECODE( to_char(H.predtvcr), 'CL','C','KR','K','AV','A','DG','D','TV','T',H.predtvcr)
                AND divinume = to_char(H.prednuvc)||to_char(H.predluvc)
                AND BASEDATO=inubasedato)

         ELSE
                decode (h.predtvcr,'P','PAJ',h.predtvcr)||' '||h.prednuvc
             ||decode(isnumber(h.predluvc),1,' '||h.predluvc,predluvc)
         END
             ||decode(H.predldvc,null,null,'B',' BIS',decode(isnumber(H.predluvc),1,decode(isnumber(H.predldvc),1,' '||H.predldvc,H.predldvc),H.predldvc))
             ||decode(H.predlzvc,null,null,'N',' NORTE','S',' SUR','O',' OESTE','E',' ESTE','W',' OESTE',decode(isnumber(H.predldvc),1,decode(isnumber(H.predlzvc),1,' '||H.predlzvc,H.predlzvc),H.predlzvc))
             ||decode(H.prednuca,null,NULL,' - ')
             ||REPLACE(H.prednuca
             ||H.predlcas
             ||decode(H.predtilu,null,null,' '||decode(a.CODIHOMO, null, H.predtilu,a.CODIHOMO))
             ||decode(H.prednulu,null,null,' '||H.prednulu)
             ||decode(H.predtild,null,null,' '||decode(b.CODIHOMO, null, H.predtild,b.CODIHOMO))
             ||decode(H.prednuld,null,null,' '|| H.prednuld)
             ||decode(H.predtilt,null,null,' '||decode(c.CODIHOMO, null, H.predtilt,c.CODIHOMO))
             ||DECODE(H.PREDNULT,NULL,NULL,' '||H.PREDNULT),'-','')|| case when (H.predmult <>-1) then (select ' '||multnomb from ldc_mig_multifam where multcodi=H.predmult AND basedato=inubasedato) end,'  ',' '),'   ',' '),'    ',' '),'     ',' ')  direccion,
       decode(h.PREDSTBC,1,'N','Y') tipo_predio,
             J.COLOHOMO,
       null BARRHOMO,
             --J.BARRHOMO,
             H.PREDBARR,
             'CALI' basedato,
             NULL homologado,
             H.PREDTVIN,
             H.PREDNUVI,
             H.PREDLUVI,
             H.PREDLDVI,
             H.PREDLZVI,
             H.PREDTVCR,
             H.PREDNUVC,
             H.PREDLUVC,
             H.PREDLDVC,
             H.PREDLZVC,
             H.PREDNUCA,
             H.PREDLCAS,
             H.PREDTILU,
             H.PREDNULU,
             H.PREDTILD,
             H.PREDNULD,
             H.PREDTILT,
             H.PREDNULT,
             decode(H.predtilu,null,null,' '||decode(a.CODIHOMO, null, H.predtilu,a.CODIHOMO))||decode(H.prednulu,null,null,' '||H.prednulu)
             ||decode(H.predtild,null,null,' '||decode(b.CODIHOMO, null, H.predtild,b.CODIHOMO))||decode(H.prednuld,null,null,' '||
             H.prednuld)||decode(H.predtilt,null,null,' '||decode(c.CODIHOMO, null, H.predtilt,c.CODIHOMO))||
             decode(H.prednult,null,null,' '||H.prednult) COMPLEMENTO, null PREDSUSC, H.PREDIIPR
        FROM LDC_TEMP_PREDIO_SGE H, ldc_mig_LOCALIDAD J, ldc_mig_tipoluga a, ldc_mig_tipoluga b, ldc_mig_tipoluga c
       where h.basedato = inubasedato
         and h.PREDDEPA = j.CODIDEPA
         and H.PREDLOCA = J.CODILOCA
         and h.PREDTILU = a.CODITILU (+)
         and H.PREDTILD = B.CODITILU (+)
         and H.PREDTILT = C.CODITILU (+)
         and predcodi
in (select sesupred
from ldc_temp_servsusc_sge where sesuserv=1 and sesueste in (SELECT distinct estado_tecnico FROM ldc_estados_serv_homo) and basedato=inubasedato )
and prednuca is not null;

     /* predios potenciales - no estan asociados a ningun servicio suscrito */
         CURSOR cuprediop /* cursor donde estan los predios asociados a servicios suscritos de gas */
       IS
      SELECT              H.preddepa,
             H.predloca,
             H.preddire,
             H.PREDDEPA||'-'||H.PREDLOCA||'-'||H.PREDZOCA||'-'||H.PREDSECA||'-'||H.PREDMACA||'-'||H.PREDNUPR||'-'||H.PREDNUME||'-'||H.PREDCONS predcodi,
             H.predtag,
             H.PREDCALA,
             H.PREDMULT,
       replace(replace(replace(replace(
       CASE
         WHEN ((SELECT count(divisino) from ldc_temp_diccvias_sge WHERE diviloca =h.predloca AND dividepa =h.preddepa AND divinume = to_char(H.prednuvi)||to_char(H.predluvi) AND  divitivi= DECODE( to_char(H.predtvin), 'CL','C','KR','K','AV','A','DG','D','TV','T',h.predtvin) AND BASEDATO=inubasedato) =1 ) then
                (select    replace(replace(replace(replace(replace(replace(substr(LTRIM(divisino),1, instr(LTRIM(divisino),' ')-1),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CRA','KR'),'CR','KR'),'SECTOR','SECTOR_')||' '||
                 replace(replace(replace(replace(replace( decode(REGEXP_SUBSTR(substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1),'^[A-Z]')
                 ,null,replace(substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1),' ','')
                 ,substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1)),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CRA','KR'),'CR','KR') DIVISINO
                 FROM ldc_temp_diccvias_sge
                WHERE diviloca =  h.predloca
                AND dividepa= h.preddepa
                AND  divitivi= DECODE( to_char(H.predtvin), 'CL','C','KR','K','AV','A','DG','D','TV','T',h.predtvin)
                AND divinume = to_char(H.prednuvi)||to_char(H.predluvi)
                AND BASEDATO=inubasedato)

         ELSE
                decode (H.predtvin,'P','PAJ',h.predtvin)||' '||H.prednuvi||decode(isnumber(H.predluvi),1,' '||H.predluvi,H.predluvi)
       END ||decode(H.predldvi,null,null,'B',' BIS',
             decode(isnumber(H.predluvi),1,decode(isnumber(H.predldvi),1,' '||H.predldvi,H.predldvi),H.predldvi))
             ||decode(H.predlzvi,null,null,'N',' NORTE','S',' SUR','O',' OESTE','E',' ESTE','W',' OESTE',
             decode(isnumber(H.predldvi),1,decode(isnumber(H.predlzvi),1,' '||H.predlzvi,H.predlzvi),H.predlzvi))||' '||
        CASE
          WHEN ((SELECT count(divisino) from ldc_temp_diccvias_sge WHERE diviloca =h.predloca AND dividepa =h.preddepa AND divinume = to_char(H.prednuvc)||to_char(h.predluvc) AND  divitivi= DECODE( to_char(H.predtvcr), 'CL','C','KR','K','AV','A','DG','D','TV','T',h.predtvcr) AND BASEDATO=inubasedato)  =1  ) then
                (select    replace(replace(replace(replace(replace(replace(substr(LTRIM(divisino),1, instr(LTRIM(divisino),' ')-1),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CRA','KR'),'CR','KR'),'SECTOR','SECTOR_')||' '||
                  replace(replace(replace(replace(replace(decode(REGEXP_SUBSTR(substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1),'^[A-Z]')
                 ,null,replace(substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1),' ','')
                 ,substr(LTRIM(divisino),instr(LTRIM(divisino),' ')+1)),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CRA','KR'),'CR','KR') DIVISINO
                 FROM ldc_temp_diccvias_sge
                WHERE diviloca =h.predloca
                AND  dividepa =h.preddepa
                AND  divitivi= DECODE( to_char(H.predtvcr), 'CL','C','KR','K','AV','A','DG','D','TV','T',H.predtvcr)
                AND divinume = to_char(H.prednuvc)||to_char(h.predluvc)
                AND BASEDATO=inubasedato)

         ELSE
                decode (h.predtvcr,'P','PAJ',h.predtvcr)||' '||h.prednuvc||decode(isnumber(h.predluvc),1,' '||h.predluvc,predluvc)
         END
             
             ||decode(H.predldvc,null,null,'B',' BIS',decode(isnumber(H.predluvc),1,decode(isnumber(H.predldvc),1,' '||H.predldvc,
             H.predldvc),H.predldvc))||decode(H.predlzvc,null,null,'N',' NORTE','S',' SUR','O',' OESTE','E',' ESTE','W',' OESTE',
             decode(isnumber(H.predldvc),1,decode(isnumber(H.predlzvc),1,H.predlzvc,H.predlzvc),H.predlzvc))||
             decode(H.prednuca,null,NULL,' - ')
             ||REPLACE(H.prednuca
             ||H.predlcas
             ||decode(H.predtilu,null,null,' '||decode(a.CODIHOMO, null, H.predtilu,a.CODIHOMO))
             ||decode(H.prednulu,null,null,' '||H.prednulu)
             ||decode(H.predtild,null,null,' '||decode(b.CODIHOMO, null, H.predtild,b.CODIHOMO))
             ||decode(H.prednuld,null,null,' '|| H.prednuld)
             ||decode(H.predtilt,null,null,' '||decode(c.CODIHOMO, null, H.predtilt,c.CODIHOMO))
             ||DECODE(H.PREDNULT,NULL,NULL,' '||H.PREDNULT),'-','') || case when (H.predmult <>-1) then (select ' '||multnomb from ldc_mig_multifam where multcodi=H.predmult AND basedato=inubasedato) end,'  ',' '),'   ',' '),'    ',' '),'     ',' ')  direccion,
       decode(h.PREDSTBC,1,'N','Y') tipo_predio,
             J.COLOHOMO,
       null BARRHOMO,
             --J.BARRHOMO,
             H.PREDBARR,
             'CALI' basedato,
             NULL homologado,
             H.PREDTVIN,
             H.PREDNUVI,
             H.PREDLUVI,
             H.PREDLDVI,
             H.PREDLZVI,
             H.PREDTVCR,
             H.PREDNUVC,
             H.PREDLUVC,
             H.PREDLDVC,
             H.PREDLZVC,
             H.PREDNUCA,
             H.PREDLCAS,
             H.PREDTILU,
             H.PREDNULU,
             H.PREDTILD,
             H.PREDNULD,
             H.PREDTILT,
             H.PREDNULT,
             decode(H.predtilu,null,null,' '||decode(a.CODIHOMO, null, H.predtilu,a.CODIHOMO))||decode(H.prednulu,null,null,' '||H.prednulu)
             ||decode(H.predtild,null,null,' '||decode(b.CODIHOMO, null, H.predtild,b.CODIHOMO))||decode(H.prednuld,null,null,' '||
             H.prednuld)||decode(H.predtilt,null,null,' '||decode(c.CODIHOMO, null, H.predtilt,c.CODIHOMO))||
             decode(H.prednult,null,null,' '||H.prednult) COMPLEMENTO, null PREDSUSC, H.PREDIIPR
        FROM LDC_TEMP_PREDIO_SGE H, ldc_mig_LOCALIDAD J, ldc_mig_tipoluga a, ldc_mig_tipoluga b, ldc_mig_tipoluga c
       where h.basedato = inubasedato
         and h.PREDDEPA = j.CODIDEPA
         and H.PREDLOCA = J.CODILOCA
         and h.PREDTILU = a.CODITILU (+)
         and H.PREDTILD = B.CODITILU (+)
         and H.PREDTILT = C.CODITILU (+)
         and predcodi
not in (select sesupred
from ldc_temp_servsusc_SGE where sesuserv=1 and sesueste in (SELECT distinct estado_tecnico FROM ldc_estados_serv_homo) and basedato=inubasedato )
and prednuca is not null;


    CURSOR cupredioNull /* cursor donde estan los predios asociados a servicios suscritos de gas */
       IS
      SELECT /*+ index (LDC_TEMP_SERVSUSC INDEX3_LDC_TEMP_SERVSUSC)*/
             H.preddepa,
             H.predloca,
             H.preddire,
             H.PREDDEPA||'-'||H.PREDLOCA||'-'||H.PREDZOCA||'-'||H.PREDSECA||'-'||H.PREDMACA||'-'||H.PREDNUPR||'-'||H.PREDNUME||'-'||H.PREDCONS predcodi,
             H.predtag,
             H.PREDCALA,
             H.PREDMULT,
             replace(replace(replace(replace(preddire,'  ',' '),'   ',' '),'    ',' '),'     ',' ') direccion,
       decode(h.PREDSTBC,1,'N','Y') tipo_predio,
             J.COLOHOMO,
       null BARRHOMO,
             --J.BARRHOMO,
             H.PREDBARR,
             'CALI' basedato,
             NULL homologado,
             H.PREDTVIN,
             H.PREDNUVI,
             H.PREDLUVI,
             H.PREDLDVI,
             H.PREDLZVI,
             H.PREDTVCR,
             H.PREDNUVC,
             H.PREDLUVC,
             H.PREDLDVC,
             H.PREDLZVC,
             H.PREDNUCA,
             H.PREDLCAS,
             H.PREDTILU,
             H.PREDNULU,
             H.PREDTILD,
             H.PREDNULD,
             H.PREDTILT,
             H.PREDNULT,
             decode(H.predtilu,null,null,' '||decode(a.CODIHOMO, null, H.predtilu,a.CODIHOMO))||decode(H.prednulu,null,null,' '||H.prednulu)
             ||decode(H.predtild,null,null,' '||decode(b.CODIHOMO, null, H.predtild,b.CODIHOMO))||decode(H.prednuld,null,null,' '||
             H.prednuld)||decode(H.predtilt,null,null,' '||decode(c.CODIHOMO, null, H.predtilt,c.CODIHOMO))||
             decode(H.prednult,null,null,' '||H.prednult) COMPLEMENTO, null PREDSUSC, H.PREDIIPR
        FROM LDC_TEMP_PREDIO_SGE H, ldc_mig_LOCALIDAD J, ldc_mig_tipoluga a, ldc_mig_tipoluga b, ldc_mig_tipoluga c
       where h.basedato = inubasedato
         and h.PREDDEPA = j.CODIDEPA
         and H.PREDLOCA = J.CODILOCA
         and h.PREDTILU = a.CODITILU (+)
         and H.PREDTILD = B.CODITILU (+)
         and H.PREDTILT = C.CODITILU (+)
         and predcodi
in (select sesupred
from ldc_temp_servsusc_sge where sesuserv=1 and sesueste in (SELECT distinct estado_tecnico FROM ldc_estados_serv_homo) and basedato=inubasedato )
and prednuca is null;


/* predios potenciales - no estan asociados a ningun servicio suscrito */
         CURSOR cuprediopnull /* cursor donde estan los predios asociados a servicios suscritos de gas */
       IS
      SELECT              H.preddepa,
             H.predloca,
             H.preddire,
             H.PREDDEPA||'-'||H.PREDLOCA||'-'||H.PREDZOCA||'-'||H.PREDSECA||'-'||H.PREDMACA||'-'||H.PREDNUPR||'-'||H.PREDNUME||'-'||H.PREDCONS predcodi,
             H.predtag,
             H.PREDCALA,
             H.PREDMULT,
             replace(replace(replace(replace(preddire,'  ',' '),'   ',' '),'    ',' '),'     ',' ') direccion,
       decode(h.PREDSTBC,1,'N','Y') tipo_predio,
             J.COLOHOMO,
       null BARRHOMO,
             --J.BARRHOMO,
             H.PREDBARR,
             'CALI' basedato,
             NULL homologado,
             H.PREDTVIN,
             H.PREDNUVI,
             H.PREDLUVI,
             H.PREDLDVI,
             H.PREDLZVI,
             H.PREDTVCR,
             H.PREDNUVC,
             H.PREDLUVC,
             H.PREDLDVC,
             H.PREDLZVC,
             H.PREDNUCA,
             H.PREDLCAS,
             H.PREDTILU,
             H.PREDNULU,
             H.PREDTILD,
             H.PREDNULD,
             H.PREDTILT,
             H.PREDNULT,
             decode(H.predtilu,null,null,' '||decode(a.CODIHOMO, null, H.predtilu,a.CODIHOMO))||decode(H.prednulu,null,null,' '||H.prednulu)
             ||decode(H.predtild,null,null,' '||decode(b.CODIHOMO, null, H.predtild,b.CODIHOMO))||decode(H.prednuld,null,null,' '||
             H.prednuld)||decode(H.predtilt,null,null,' '||decode(c.CODIHOMO, null, H.predtilt,c.CODIHOMO))||
             decode(H.prednult,null,null,' '||H.prednult) COMPLEMENTO, null PREDSUSC, H.PREDIIPR
        FROM LDC_TEMP_PREDIO_SGE H, ldc_mig_LOCALIDAD J, ldc_mig_tipoluga a, ldc_mig_tipoluga b, ldc_mig_tipoluga c
       where h.basedato = inubasedato
         and h.PREDDEPA = j.CODIDEPA
         and H.PREDLOCA = J.CODILOCA
         and h.PREDTILU = a.CODITILU (+)
         and H.PREDTILD = B.CODITILU (+)
         and H.PREDTILT = C.CODITILU (+)
         and predcodi
not in (select sesupred
from ldc_temp_servsusc_SGE where sesuserv=1 and sesueste in (SELECT distinct estado_tecnico FROM ldc_estados_serv_homo) and basedato=inubasedato )
and prednuca is null;


      cursor cuSegmento (nuVia  number, nuCruce number, nuLoca number)
          is
      SELECT /*+ index(ab_segments IDX_AB_SEGMENTS_04)*/  *
      FROM ab_segments
      WHERE geograp_location_id = nuLoca
      AND   WAY_ID = NUVIA
      AND   cross_way_id = nuCruce;
       TYPE cur_typ IS REF CURSOR;
       c_cursor     CUR_TYP;
       c_cursor1    CUR_TYP;
       RG_VIAS      ldc_mig_vias%ROWTYPE;
       RG_CRUCE     ldc_mig_vias%ROWTYPE;
       rg_Segmento  AB_SEGMENTS%rowtype;
       v_query      VARCHAR2(2000);
       v_query1     VARCHAR2(2000);
       nuPREDDEPA   ldc_mig_vias.PREDDEPA%type;
       nuPREDLOCA   ldc_mig_vias.PREDLOCA%type;
       nuPREDTVIN   ldc_mig_vias.PREDTVIN%type;
       nuPREDNUVI   ldc_mig_vias.PREDNUVI%type;
       nuPREDLUVI   ldc_mig_vias.PREDLUVI%type;
       nuPREDLDVI   ldc_mig_vias.PREDLDVI%type;
       nuPREDLZVI   ldc_mig_vias.PREDLZVI%type;
       vfecha_ini             DATE;
       vfecha_fin             DATE;
       vprograma              VARCHAR2 (100);
       vcont                  NUMBER := 0;
       vcontLec               NUMBER := 0;
       vcontIns               NUMBER := 0;
       verror                 VARCHAR2 (4000);
      SBDOCUMENTO            varchar2(30) := null;
      NUBARRIO                number(6) := null;
      SBDIRECCION             varchar2(200) := null;
      sbcasa                  varchar2(20) := null;
    -- DECLARACION DE TIPOS.
   --
      TYPE tipo_cu_datos IS TABLE OF cupredio%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
     tbl_datos      tipo_cu_datos := tipo_cu_datos ();
     CURSOR CUbARRIO(nuDepa number, nuLoca number, nuBarr number)
        is
     select BARRHOMO
      from LDC_MIG_BARRIO
     where CODIDEPA = nuDepa
       and CODILOCA = NULOCA
       AND CODIBARR = nubarr;
    cursor cuViaHomo (nuDepa number, nuLoca number,
                      sbTiVi varchar2, nuVia number,
                      sbLUVI varchar2, sbLDVI varchar2,
                      sbLZVI varchar2)
          is
        select *
          from ldc_mig_vias
         where PREDDEPA = nuDepa
           and PREDLOCA = nuLoca
           and PREDTVIN = sbTiVi
           and PREDNUVI = nuVia
           and     database = inubasedato
           and nvl(PREDLUVI,'%') = nvl(sbLUVI,'%')
           and nvl(PREDLDVI,'%') = nvl(sbLDVI,'%')
           and nvl(PREDLZVI,'%') = nvl(sbLZVI,'%');
      --- Control de Errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
BEGIN
    vprograma := 'LDC_MIG_DIRECCION';
--    vprograma := 'PREDIO';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (146,146,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    -- Extraer Datos y cargarlos
    --nuContador := 2; --Se inicia en 2 porque el c¿digo 1 es un registro comodin
    OPEN cuPredio;
    LOOP
        -- Borrar tablas     tbl_datos.
        --
        tbl_datos.delete;
        FETCH cuPredio
        BULK COLLECT INTO tbl_datos
        LIMIT 1000;
        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            vcontLec := vcontLec + 1;
            sbDocumento := tbl_datos (nuindice).predcodi;
            SBDIRECCION := null;
            sbcasa := null;

            open CUVIAHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                    TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI);
            FETCH CUVIAHOMO INTO RG_VIAS;
            close CUVIAHOMO;

            open CUVIAHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVCR , TBL_DATOS (NUINDICE).PREDNUVC,
                                    TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
            FETCH CUVIAHOMO into rg_cruce;
            close CUVIAHOMO;

                open cuSegmento (RG_VIAS.CONSHOMO, rg_cruce.CONSHOMO,tbl_datos (nuindice).COLOHOMO);
                fetch cuSegmento  into rg_Segmento;
                close cuSegmento;

                open CUBARRIO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDBARR);
                FETCH CUBARRIO into NUBARRIO;
                close CUBARRIO;

                sbdireccion := TBL_DATOS (NUINDICE).DIRECCION;

                BEGIN
                     insert into LDC_MIG_DIRECCION (CODIDEPA, CODILOCA, PREDDIRE, PREDCODI, PREDTAG, PREDCALA, DIREPARS, TIPOPRED, LOCAHOMO,
                                                 BARRHOMO, PREDBARR, BASEDATO, PREDHOMO, PREDTVIN, PREDNUVI, PREDLUVI, PREDLDVI, PREDLZVI,
                                                 PREDTVCR, PREDNUVC, PREDLUVC, PREDLDVC, PREDLZVC, PREDNUCA, PREDLCAS, PREDTILU, PREDNULU,
                                                 PREDTILD, PREDNULD, PREDTILT, PREDNULT, VIAPHOMO, VIACHOMO, TIVIHOMO, TICRHOMO, COMPDIRE,
                                                 SEGMENTO, PREDSUSC, DATABASE, PARTICION,PREDMULT,PREDIIPR)
                     VALUES (tbl_datos (nuindice).preddepa, tbl_datos (nuindice).predloca,  tbl_datos (nuindice).preddire,
                                        tbl_datos (nuindice).predcodi, tbl_datos (nuindice).predtag,  tbl_datos (nuindice).predcala,
                                        sbdireccion, TBL_DATOS (NUINDICE).TIPO_PREDIO, TBL_DATOS (NUINDICE).COLOHOMO,
                                        nuBarrio, tbl_datos (nuindice).predbarr, tbl_datos (nuindice).basedato,
                                        tbl_datos (nuindice).homologado, tbl_datos (nuindice).PREDTVIN,tbl_datos (nuindice).PREDNUVI,
                                        tbl_datos (nuindice).PREDLUVI, tbl_datos (nuindice).PREDLDVI, tbl_datos (nuindice).PREDLZVI,
                                        tbl_datos (nuindice).PREDTVCR, tbl_datos (nuindice).PREDNUVC, tbl_datos (nuindice).PREDLUVC,
                                        tbl_datos (nuindice).PREDLDVC, tbl_datos (nuindice).PREDLZVC, tbl_datos (nuindice).PREDNUCA,
                                        tbl_datos (nuindice).PREDLCAS, tbl_datos (nuindice).PREDTILU, tbl_datos (nuindice).PREDNULU,
                                        tbl_datos (nuindice).PREDTILD, tbl_datos (nuindice).PREDNULD, tbl_datos (nuindice).PREDTILT,
                                        TBL_DATOS (NUINDICE).PREDNULT, RG_VIAS.CONSHOMO, RG_CRUCE.CONSHOMO, RG_VIAS.TIVIHOMO, RG_CRUCE.TIVIHOMO,
                                        tbl_datos (nuindice).COMPLEMENTO, rg_Segmento.SEGMENTS_ID, tbl_datos (nuindice).PREDSUSC, inubasedato,1,TBL_DATOS(NUINDICE).PREDMULT,TBL_DATOS(NUINDICE).PREDIIPR);
                                        vcontIns := vcontIns + 1;
                                        COMMIT;
                  EXCEPTION
                   WHEN OTHERS THEN
                     BEGIN
                       NUERRORES := NUERRORES + 1;
                       PKLOG_MIGRACION.prInsLogMigra ( 146,146,2,vprograma||vcontIns,0,0,'Predio : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                     END;
                  end;


        EXCEPTION
           WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                 PKLOG_MIGRACION.prInsLogMigra ( 146,146,2,vprograma||vcontIns,0,0,'Predio : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
        end;
      END LOOP;
        commit;

      EXIT WHEN cupredio%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cupredio%ISOPEN)
   THEN
      --{
      CLOSE cupredio;
   --}
   END IF;



   OPEN cuPrediop;
    LOOP
        -- Borrar tablas     tbl_datos.
        --
        tbl_datos.delete;
        FETCH cuPrediop
        BULK COLLECT INTO tbl_datos
        LIMIT 1000;
        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            vcontLec := vcontLec + 1;
            sbDocumento := tbl_datos (nuindice).predcodi;
            SBDIRECCION := null;
            sbcasa := null;
            open CUVIAHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                    TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI);
            FETCH CUVIAHOMO INTO RG_VIAS;
            close CUVIAHOMO;


            open CUVIAHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVCR , TBL_DATOS (NUINDICE).PREDNUVC,
                                    TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
            FETCH CUVIAHOMO into rg_cruce;
            close CUVIAHOMO;

            
                  open cuSegmento (RG_VIAS.CONSHOMO, rg_cruce.CONSHOMO,tbl_datos (nuindice).COLOHOMO);
                  fetch cuSegmento  into rg_Segmento;
                  close cuSegmento;

                  open CUBARRIO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDBARR);
                  FETCH CUBARRIO into NUBARRIO;
                  close CUBARRIO;

                 sbdireccion := TBL_DATOS (NUINDICE).DIRECCION;

                 BEGIN
                       insert into LDC_MIG_DIRECCION (CODIDEPA, CODILOCA, PREDDIRE, PREDCODI, PREDTAG, PREDCALA, DIREPARS, TIPOPRED, LOCAHOMO,
                                                 BARRHOMO, PREDBARR, BASEDATO, PREDHOMO, PREDTVIN, PREDNUVI, PREDLUVI, PREDLDVI, PREDLZVI,
                                                 PREDTVCR, PREDNUVC, PREDLUVC, PREDLDVC, PREDLZVC, PREDNUCA, PREDLCAS, PREDTILU, PREDNULU,
                                                 PREDTILD, PREDNULD, PREDTILT, PREDNULT, VIAPHOMO, VIACHOMO, TIVIHOMO, TICRHOMO, COMPDIRE,
                                                 SEGMENTO, PREDSUSC, DATABASE, PARTICION, PREDMULT, PREDIIPR)
                       VALUES (tbl_datos (nuindice).preddepa, tbl_datos (nuindice).predloca,  tbl_datos (nuindice).preddire,
                               tbl_datos (nuindice).predcodi, tbl_datos (nuindice).predtag,  tbl_datos (nuindice).predcala,
                               sbdireccion, TBL_DATOS (NUINDICE).TIPO_PREDIO, TBL_DATOS (NUINDICE).COLOHOMO,
                               nuBarrio, tbl_datos (nuindice).predbarr, tbl_datos (nuindice).basedato,
                               tbl_datos (nuindice).homologado, tbl_datos (nuindice).PREDTVIN,tbl_datos (nuindice).PREDNUVI,
                               tbl_datos (nuindice).PREDLUVI, tbl_datos (nuindice).PREDLDVI, tbl_datos (nuindice).PREDLZVI,
                               tbl_datos (nuindice).PREDTVCR, tbl_datos (nuindice).PREDNUVC, tbl_datos (nuindice).PREDLUVC,
                               tbl_datos (nuindice).PREDLDVC, tbl_datos (nuindice).PREDLZVC, tbl_datos (nuindice).PREDNUCA,
                               tbl_datos (nuindice).PREDLCAS, tbl_datos (nuindice).PREDTILU, tbl_datos (nuindice).PREDNULU,
                               tbl_datos (nuindice).PREDTILD, tbl_datos (nuindice).PREDNULD, tbl_datos (nuindice).PREDTILT,
                               TBL_DATOS (NUINDICE).PREDNULT, RG_VIAS.CONSHOMO, RG_CRUCE.CONSHOMO, RG_VIAS.TIVIHOMO, RG_CRUCE.TIVIHOMO,
                               tbl_datos (nuindice).COMPLEMENTO, rg_Segmento.SEGMENTS_ID, tbl_datos (nuindice).PREDSUSC, inubasedato,1,TBL_DATOS(NUINDICE).PREDMULT,TBL_DATOS(NUINDICE).PREDIIPR);
                                 vcontIns := vcontIns + 1;
                      COMMIT;
                 EXCEPTION
                    WHEN OTHERS THEN
                      BEGIN
                        NUERRORES := NUERRORES + 1;
                        PKLOG_MIGRACION.prInsLogMigra ( 146,146,2,vprograma||vcontIns,0,0,'Predio : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                        END;
                  end;
            

        EXCEPTION
           WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                 PKLOG_MIGRACION.prInsLogMigra ( 146,146,2,vprograma||vcontIns,0,0,'Predio : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
        end;
      END LOOP;

        commit;

      EXIT WHEN cuprediop%NOTFOUND;

   END LOOP;
    -- Cierra CURSOR.
   IF (cuprediop%ISOPEN)
   THEN
      --{
      CLOSE cuprediop;
   --}
   END IF;


 OPEN cuPredionull;
    LOOP
        -- Borrar tablas     tbl_datos.
        --
        tbl_datos.delete;
        FETCH cuPredionull
        BULK COLLECT INTO tbl_datos
        LIMIT 1000;
        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            vcontLec := vcontLec + 1;
            sbDocumento := tbl_datos (nuindice).predcodi;
            SBDIRECCION := null;
            sbcasa := null;

            open CUVIAHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                    TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI);
            FETCH CUVIAHOMO INTO RG_VIAS;
            close CUVIAHOMO;

            open CUVIAHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVCR , TBL_DATOS (NUINDICE).PREDNUVC,
                                    TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
            FETCH CUVIAHOMO into rg_cruce;
            close CUVIAHOMO;

                open cuSegmento (RG_VIAS.CONSHOMO, rg_cruce.CONSHOMO,tbl_datos (nuindice).COLOHOMO);
                fetch cuSegmento  into rg_Segmento;
                close cuSegmento;

                open CUBARRIO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDBARR);
                FETCH CUBARRIO into NUBARRIO;
                close CUBARRIO;

                sbdireccion := TBL_DATOS (NUINDICE).DIRECCION;

                BEGIN
                     insert into LDC_MIG_DIRECCION (CODIDEPA, CODILOCA, PREDDIRE, PREDCODI, PREDTAG, PREDCALA, DIREPARS, TIPOPRED, LOCAHOMO,
                                                 BARRHOMO, PREDBARR, BASEDATO, PREDHOMO, PREDTVIN, PREDNUVI, PREDLUVI, PREDLDVI, PREDLZVI,
                                                 PREDTVCR, PREDNUVC, PREDLUVC, PREDLDVC, PREDLZVC, PREDNUCA, PREDLCAS, PREDTILU, PREDNULU,
                                                 PREDTILD, PREDNULD, PREDTILT, PREDNULT, VIAPHOMO, VIACHOMO, TIVIHOMO, TICRHOMO, COMPDIRE,
                                                 SEGMENTO, PREDSUSC, DATABASE, PARTICION,PREDMULT,PREDIIPR)
                     VALUES (tbl_datos (nuindice).preddepa, tbl_datos (nuindice).predloca,  tbl_datos (nuindice).preddire,
                                        tbl_datos (nuindice).predcodi, tbl_datos (nuindice).predtag,  tbl_datos (nuindice).predcala,
                                        sbdireccion, TBL_DATOS (NUINDICE).TIPO_PREDIO, TBL_DATOS (NUINDICE).COLOHOMO,
                                        nuBarrio, tbl_datos (nuindice).predbarr, tbl_datos (nuindice).basedato,
                                        tbl_datos (nuindice).homologado, tbl_datos (nuindice).PREDTVIN,tbl_datos (nuindice).PREDNUVI,
                                        tbl_datos (nuindice).PREDLUVI, tbl_datos (nuindice).PREDLDVI, tbl_datos (nuindice).PREDLZVI,
                                        tbl_datos (nuindice).PREDTVCR, tbl_datos (nuindice).PREDNUVC, tbl_datos (nuindice).PREDLUVC,
                                        tbl_datos (nuindice).PREDLDVC, tbl_datos (nuindice).PREDLZVC, tbl_datos (nuindice).PREDNUCA,
                                        tbl_datos (nuindice).PREDLCAS, tbl_datos (nuindice).PREDTILU, tbl_datos (nuindice).PREDNULU,
                                        tbl_datos (nuindice).PREDTILD, tbl_datos (nuindice).PREDNULD, tbl_datos (nuindice).PREDTILT,
                                        TBL_DATOS (NUINDICE).PREDNULT, RG_VIAS.CONSHOMO, RG_CRUCE.CONSHOMO, RG_VIAS.TIVIHOMO, RG_CRUCE.TIVIHOMO,
                                        tbl_datos (nuindice).COMPLEMENTO, rg_Segmento.SEGMENTS_ID, tbl_datos (nuindice).PREDSUSC, inubasedato,1,TBL_DATOS(NUINDICE).PREDMULT,TBL_DATOS(NUINDICE).PREDIIPR);
                                        vcontIns := vcontIns + 1;
                                        COMMIT;
                  EXCEPTION
                   WHEN OTHERS THEN
                     BEGIN
                       NUERRORES := NUERRORES + 1;
                       PKLOG_MIGRACION.prInsLogMigra ( 146,146,2,vprograma||vcontIns,0,0,'Predio : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                     END;
                  end;


        EXCEPTION
           WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                 PKLOG_MIGRACION.prInsLogMigra ( 146,146,2,vprograma||vcontIns,0,0,'Predio : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
        end;
      END LOOP;
        commit;

      EXIT WHEN cuPredionull%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuPredionull%ISOPEN)
   THEN
      --{
      CLOSE cuPredionull;
   --}
   END IF;



   OPEN cuPrediopnull;
    LOOP
        -- Borrar tablas     tbl_datos.
        --
        tbl_datos.delete;
        FETCH cuPrediopnull
        BULK COLLECT INTO tbl_datos
        LIMIT 1000;
        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            vcontLec := vcontLec + 1;
            sbDocumento := tbl_datos (nuindice).predcodi;
            SBDIRECCION := null;
            sbcasa := null;
            open CUVIAHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVIN , TBL_DATOS (NUINDICE).PREDNUVI,
                                    TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI);
            FETCH CUVIAHOMO INTO RG_VIAS;
            close CUVIAHOMO;


            open CUVIAHOMO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDTVCR , TBL_DATOS (NUINDICE).PREDNUVC,
                                    TBL_DATOS (NUINDICE).PREDLUVC, TBL_DATOS (NUINDICE).PREDLDVC, TBL_DATOS (NUINDICE).PREDLZVC);
            FETCH CUVIAHOMO into rg_cruce;
            close CUVIAHOMO;

       
                  open cuSegmento (RG_VIAS.CONSHOMO, rg_cruce.CONSHOMO,tbl_datos (nuindice).COLOHOMO);
                  fetch cuSegmento  into rg_Segmento;
                  close cuSegmento;

                  open CUBARRIO(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, TBL_DATOS (NUINDICE).PREDBARR);
                  FETCH CUBARRIO into NUBARRIO;
                  close CUBARRIO;

                 sbdireccion := TBL_DATOS (NUINDICE).DIRECCION;

                 BEGIN
                       insert into LDC_MIG_DIRECCION (CODIDEPA, CODILOCA, PREDDIRE, PREDCODI, PREDTAG, PREDCALA, DIREPARS, TIPOPRED, LOCAHOMO,
                                                 BARRHOMO, PREDBARR, BASEDATO, PREDHOMO, PREDTVIN, PREDNUVI, PREDLUVI, PREDLDVI, PREDLZVI,
                                                 PREDTVCR, PREDNUVC, PREDLUVC, PREDLDVC, PREDLZVC, PREDNUCA, PREDLCAS, PREDTILU, PREDNULU,
                                                 PREDTILD, PREDNULD, PREDTILT, PREDNULT, VIAPHOMO, VIACHOMO, TIVIHOMO, TICRHOMO, COMPDIRE,
                                                 SEGMENTO, PREDSUSC, DATABASE, PARTICION, PREDMULT, PREDIIPR)
                       VALUES (tbl_datos (nuindice).preddepa, tbl_datos (nuindice).predloca,  tbl_datos (nuindice).preddire,
                               tbl_datos (nuindice).predcodi, tbl_datos (nuindice).predtag,  tbl_datos (nuindice).predcala,
                               sbdireccion, TBL_DATOS (NUINDICE).TIPO_PREDIO, TBL_DATOS (NUINDICE).COLOHOMO,
                               nuBarrio, tbl_datos (nuindice).predbarr, tbl_datos (nuindice).basedato,
                               tbl_datos (nuindice).homologado, tbl_datos (nuindice).PREDTVIN,tbl_datos (nuindice).PREDNUVI,
                               tbl_datos (nuindice).PREDLUVI, tbl_datos (nuindice).PREDLDVI, tbl_datos (nuindice).PREDLZVI,
                               tbl_datos (nuindice).PREDTVCR, tbl_datos (nuindice).PREDNUVC, tbl_datos (nuindice).PREDLUVC,
                               tbl_datos (nuindice).PREDLDVC, tbl_datos (nuindice).PREDLZVC, tbl_datos (nuindice).PREDNUCA,
                               tbl_datos (nuindice).PREDLCAS, tbl_datos (nuindice).PREDTILU, tbl_datos (nuindice).PREDNULU,
                               tbl_datos (nuindice).PREDTILD, tbl_datos (nuindice).PREDNULD, tbl_datos (nuindice).PREDTILT,
                               TBL_DATOS (NUINDICE).PREDNULT, RG_VIAS.CONSHOMO, RG_CRUCE.CONSHOMO, RG_VIAS.TIVIHOMO, RG_CRUCE.TIVIHOMO,
                               tbl_datos (nuindice).COMPLEMENTO, rg_Segmento.SEGMENTS_ID, tbl_datos (nuindice).PREDSUSC, inubasedato,1,TBL_DATOS(NUINDICE).PREDMULT,TBL_DATOS(NUINDICE).PREDIIPR);
                                 vcontIns := vcontIns + 1;
                      COMMIT;
                 EXCEPTION
                    WHEN OTHERS THEN
                      BEGIN
                        NUERRORES := NUERRORES + 1;
                        PKLOG_MIGRACION.prInsLogMigra ( 146,146,2,vprograma||vcontIns,0,0,'Predio : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                        END;
                  end;
       
        EXCEPTION
           WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                 PKLOG_MIGRACION.prInsLogMigra ( 146,146,2,vprograma||vcontIns,0,0,'Predio : '||sbDocumento||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
        end;
      END LOOP;

        commit;

      EXIT WHEN cuPrediopnull%NOTFOUND;

   END LOOP;
    -- Cierra CURSOR.
   IF (cuPrediopnull%ISOPEN)
   THEN
      --{
      CLOSE cuPrediopnull;
   --}
   END IF;

   -- Termina Log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 146,146,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);

  END PR_LDC_MIG_DIRECCION; 
/
