CREATE OR REPLACE PROCEDURE      PR_AB_WAY_BY_LOCATION(inubasedato number)
IS
 /* ******************************************************************
 PROCEDIMIENTO :    PR_AB_WAY_BY_LOCATION
 FECHA             :    27/09/2012
 AUTOR             :
 DESCRIPCION     :    Migra la informacion de las vias de los predios
                  de las bases de datos GasPlus y GPNV.

 HISTORIA DE MODIFICACIONES
 AUTOR           FECHA     DESCRIPCION

 *******************************************************************/

vfecha_ini          DATE;
vfecha_fin          DATE;
vprograma           VARCHAR2 (100);
verror              VARCHAR2 (2000);
vcontLec            NUMBER := 0;
vcontIns            NUMBER := 0;
sbDireccion         varchar(100);
NUERRORCODE         NUMBER := NULL;
nuContador          number := 0;
SBERRORMESSAGE      VARCHAR2 (2000) := NULL;
blError             boolean := false;
sbsector            varchar2(10) := null;
sbLetras            varchar2(12) := null;
rtVia               AB_WAY_BY_LOCATION%ROWTYPE;
nuSinonimo          number := 0;
nuNumero            number := Null;
vcont               number := 0;
nuPredio            number := 0;
SBREGPROC          varchar2(100); --20120703: 03-07-2012: carlosvl: Variable para captura el registro con error
SBTOKEN            varchar2(10) := null;
NUTIPO             number(5) := null;
NUTIPOVIA          number(15) := null;
NULOCAHOMO         number(7) := null;
nuDepaHomo         number(7) := null;
nucount            number(7) :=null;

    -- Cursor con los datos de origen

  CURSOR cupredio
   is
  SELECT distinct a.preddepa, a.predloca, A.PREDTVIN, A.PREDNUVI, A.PREDLUVI, A.PREDLDVI, A.PREDLZVI
  from migra.LDC_TEMP_PREDIO_SGE a
  WHERE a.basedato = inubasedato ;

  CURSOR cupredio1
   is
  SELECT distinct a.preddepa, a.predloca, A.PREDTVCR, A.PREDNUVC, A.PREDLUVC, A.PREDLDVC, A.PREDLZVC
  from migra.LDC_TEMP_PREDIO_SGE a
  WHERE a.basedato=inubasedato;

---  Cursor de tipos de Via
  CURSOR CUTIPOVIA (NUVIA varchar2)
  is
  select TIVIHOMO, TOKEN
  from LDC_MIG_TIPOVIA
  where CODITIVI = NUVIA;


--- Cursor de Localidades
  cursor CULOCALIDAD (nuDepa number, nuLoca number)
  is
  select COLOHOMO, DEPAHOMO
  from LDC_MIG_LOCALIDAD
  where CODIDEPA = NUDEPA
  and CODILOCA = nuLoca;


  CURSOR cuDiccvias (nudividepa number, nudiviloca number, sbdivitivi varchar2,nudivinume varchar)
  IS
   SELECT
   replace(substr( LTRIM(divisino),1,instr( LTRIM(divisino),' ')-1),'CALLE','CL') Via,
   substr( LTRIM(divisino),1, instr( LTRIM(divisino),' ')-1)||' '||
   decode(REGEXP_SUBSTR(substr( LTRIM(divisino),instr( LTRIM(divisino),' ')+1),'^[A-Z]')
          ,null,replace(substr( LTRIM(divisino),instr( LTRIM(divisino),' ')+1),' ','')
          ,substr( LTRIM(divisino),instr( LTRIM(divisino),' ')+1)) DIVISINO
   FROM MIGRA.ldc_temp_diccvias_sge
   WHERE dividepa =  nudividepa
   AND   diviloca =  nudiviloca
   AND   divitivi =  sbdivitivi
   AND   divinume =  to_char(nudivinume)
   AND   basedato=inubasedato
   AND (REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[A-Z] [0-9]')
   OR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[A-Z][A-Z] [0-9]')
   OR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[A-Z][A-Z][A-Z] [0-9]')
   oR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[C][L][L][J][N] ')
   oR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[C][L][L][J][O][N] ')
   oR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[V][I][A] ')
   OR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[C][A][L][L][E] ')
   OR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[S][E][C][T][O][R] ')
   OR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[A][V][E] ')
   OR REGEXP_LIKE(replace( LTRIM(divisino),'  ',' '), '^[C][L] [A-Z]'));

    --- Cursor de vias
   cursor cuVias (nuLoca ab_way_by_location.GEOGRAP_LOCATION_ID%type,
                  nuTipo ab_way_by_location.WAY_TYPE_ID%type,
                  sbdescription ab_way_by_location.DESCRIPTION%type)
   is
   select *
   from ab_way_by_location
   where GEOGRAP_LOCATION_ID = nuloca
       and WAY_TYPE_ID = nuTipo
       AND DESCRIPTION =sbdescription;

    --- DECLARACION DE TIPOS.
   TYPE tipo_cu_datos IS TABLE OF cupredio%ROWTYPE;

   --type TIPO_CU_DATOS1 is table of CUPREDIO1%ROWTYPE;


    -- DECLARACION DE TABLAS TIPOS.
   TBL_DATOS      TIPO_CU_DATOS := TIPO_CU_DATOS ();
   tbl_datos1      TIPO_CU_DATOS := TIPO_CU_DATOS ();

    --- Control de Errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   nuErrores number := 0;
   nuvia varchar2(2000);
   nudivisino varchar2(2000);
   nuvia_    varchar2(2000);


BEGIN
    vprograma := 'AB_WAY_BY_LOCATION';
    vfecha_ini := SYSDATE;

     -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (137,137,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
     -- actualiza registro de inicio en el Migrproceso

     
    -- Extraer Datos y cargarlos
    -- nuContador := 1;
    blError        := False;
    sbdireccion    :=  null;
    sbletras       := null;
    nuErrorCode    := NULL;
    sbErrorMessage := null;

    OPEN cupredio;
    LOOP
        -- Borrar tablas     tbl_datos.
        --
        tbl_datos.delete;

        FETCH cupredio
        BULK COLLECT INTO tbl_datos
        LIMIT 1000;

        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
         --dbms_output.put_line('TEST');

        FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
            BEGIN
                nucount        :=0;
                sbdireccion    := NULL;
                blError        := False;
                nuNumero       := NULL;
                sbletras       := NULL;
                nuErrorCode    := NULL;
                nuSinonimo     := NULL;
                SBERRORMESSAGE := NULL;
                nuPredio       := NULL; --tbl_datos (nuindice).PREDCODI;
                nutipo         := NULL;
                vcontLec       := vcontLec + 1;


                SBREGPROC := ''; -- 20120703: 03-07-2012: carlosvl: Variable para captura el registro con error

                sbRegProc := tbl_datos (nuindice).preddepa ||'-'|| tbl_datos (nuindice).predloca ||'-'||tbl_datos (nuindice).PREDTVIN||'-'||tbl_datos (nuindice).PREDNUVI||'-'||TBL_DATOS (NUINDICE).PREDLUVI||'-'||TBL_DATOS (NUINDICE).PREDLDVI||'-'||TBL_DATOS (NUINDICE).PREDLZVI;-- -- 20120703: 03-07-2012: carlosvl: Variable para captura el registro con error
                --dbms_output.put_line(sbRegProc);
                -- Sinonimo : 0419 | 66-170-M-19--- - Error: ORA-02291: restricción de integridad (OPEN.FK_AB_WATY_AB_WBLO) violada - clave principal no encontrada


                SELECT count(divisino)into nucount
                from ldc_temp_diccvias_sge
                WHERE diviloca =TBL_DATOS (NUINDICE).PREDLOCA
                AND dividepa =TBL_DATOS (NUINDICE).PREDDEPA
                AND divinume = to_char(TBL_DATOS (NUINDICE).PREDNUVI||nvl(TBL_DATOS (NUINDICE).PREDLUVI,'')||nvl(TBL_DATOS (NUINDICE).PREDLDVI,'')||nvl(TBL_DATOS (NUINDICE).PREDLZVI,''))
                AND  divitivi= DECODE( to_char(TBL_DATOS (NUINDICE).PREDTVIN), 'CL','C','KR','K','AV','A','DG','D','TV','T',TBL_DATOS (NUINDICE).PREDTVIN)
                AND BASEDATO=inubasedato;

                -- DIRECCIONES QUE TIENEN SINONIMOS EN GAS PLUS

                 if (nucount =1) then --Direcciones de otras localidades.
                      -- Determina localidad y departamento
                      open CULOCALIDAD(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA) ;
                      FETCH CULOCALIDAD into NULOCAHOMO, NUDEPAHOMO;
                      close CULOCALIDAD;

                      -- Homologa la vía para buscar en el diccionario
                      nuvia_:= case to_char(tbl_datos (nuindice).PREDTVIN)
                               when 'CL' then 'C'
                               when 'KR' then 'K'
                               when 'AV' then 'A'
                               WHEn 'TV' then 'T'
                               WHEN 'DG' then 'D'
                               else tbl_datos (nuindice).PREDTVIN
                               END;
                      nudivisino:= null;

                      -- Consulta la via en el diccionario
                      open cudiccvias (TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA, nuvia_, TBL_DATOS (NUINDICE).PREDNUVI||nvl(TBL_DATOS (NUINDICE).PREDLUVI,'')||nvl(TBL_DATOS (NUINDICE).PREDLDVI,'')||nvl(TBL_DATOS (NUINDICE).PREDLZVI,''));
                      fetch   cudiccvias INTO nuvia,nudivisino;
                      close cudiccvias;


                     -- homologa el tipo de via de acuerdo a la via del diccionario
                     nutipo := CASE to_char(trim(nuvia))
                              WHEN 'KR'  THEN  '5'
                              WHEN 'CL'  THEN  '2'
                              WHEN 'DG' THEN  '3'
                              WHEN 'TR'  THEN  '9'
                              WHEN 'AV'  THEN  '1'
                              WHEN 'CLLJN' THEN '101'
                              WHEN 'VIA' THEN '11'
                              WHEN 'KM' THEN '6'
                              WHEN 'PASAJE'  THEN '102'
                              WHEN 'SECTOR'  then '8'
                              ELSE '0'
                              END;
                     -- remueve el doble espacio
                     nudivisino:=replace(replace(replace(replace(replace(replace(replace(replace(replace(nudivisino,'  ',' '),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CL.','CL'),'PASAJE','PAJ'),'CRA','KR'),'CR','KR'),'SECTOR','SECTOR_');
                     rtVia:=null;
                     -- Si en encontró sinonimo y encontro via
                     -- PUNTO DE QUIEBRE
                     if nudivisino IS not null AND nutipo <>0  then

                        -- Valida si existe la via en ab_way_by_location
                        AB_Boparser.FixSpaces(nudivisino);
                        open cuVias ( nuLocahomo, nuTipo,nudivisino);
                        fetch cuVias into rtVia;
                        if cuVias%notfound then
                            close CUVIAS;


                            NUCONTADOR := SEQ_AB_WAY_BY_LOCATION.NEXTVAL;
                            INSERT INTO AB_WAY_BY_LOCATION (WAY_BY_LOCATION_ID, WAY_TYPE_ID, GEOGRAP_LOCATION_ID, DESCRIPTION,
                                                                        WAY_NUMBER, LETTERS_WAY, HAS_PREVIOUS_VALUE)
                            VALUES (nuContador,nutipo, nuLocaHomo,nudivisino,null, null,null);

                            INSERT INTO LDC_MIG_VIAS (PREDDEPA, PREDLOCA, PREDTVIN, PREDNUVI, PREDLUVI, PREDLDVI, PREDLZVI, PREDDIRE,
                                                                  DEPAHOMO, LOCAHOMO, CONSHOMO, TIVIHOMO, NUVIHOMO, LEVIHOMO, DIREHOMO, IND_SINONIMO, BASEDATO, DATABASE)
                            VALUES (tbl_datos (nuindice).PREDDEPA, tbl_datos (nuindice).PREDLOCA, tbl_datos (nuindice).PREDTVIN, tbl_datos (nuindice).PREDNUVI,
                                                     TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI, null,
                                                    nuDEPAHOMO, nuLocaHomo, nuContador, nutipo, null, null, nudivisino, 'N', '',inubasedato);
                            COMMIT;


                        else
                            close cuvias;
                        END if;
                      END if;


                 else

                        --dbms_output.put_line('ELSE');

                        open CUTIPOVIA(TBL_DATOS (NUINDICE).PREDTVIN);
                        FETCH CUTIPOVIA into NUTIPO, SBTOKEN;
                        close CUTIPOVIA;

                        open CULOCALIDAD(TBL_DATOS (NUINDICE).PREDDEPA, TBL_DATOS (NUINDICE).PREDLOCA) ;
                        FETCH CULOCALIDAD into NULOCAHOMO, NUDEPAHOMO;
                        close CULOCALIDAD;

                        SBDIRECCION := sbTOKEN||' '||TBL_DATOS (NUINDICE).PREDNUVI;
                        nunumero := tbl_datos (nuindice).PREDNUVI;

                       -- Valida la letra uno LETRA UNO VIA INICIAL
                        if tbl_datos (nuindice).PREDLUVI is not null then
                            if isnumber(tbl_datos (nuindice).PREDLUVI) = 1 then
                                sbdireccion := sbdireccion||' '||tbl_datos (nuindice).PREDLUVI;
                                sbletras := tbl_datos (nuindice).PREDLUVI;
                            else
                                sbdireccion := sbdireccion||tbl_datos (nuindice).PREDLUVI;
                                sbletras := tbl_datos (nuindice).PREDLUVI;
                            end if;--if isnumber(tbl_datos (nuindice).PREDLUVI) = 1 then
                        end if;--if tbl_datos (nuindice).PREDLUVI is not null then

                        -- Valida la letra dos -- LETRA DOS VIA INICIAL
                        if tbl_datos (nuindice).PREDLDVI is not null then
                            if isnumber(tbl_datos (nuindice).PREDLDVI) = 1 and isnumber(tbl_datos (nuindice).PREDLUVI) = 1 then
                                sbdireccion := sbdireccion||' '||tbl_datos (nuindice).PREDLDVI;
                                sbletras := sbletras||' '||tbl_datos (nuindice).PREDLDVI;
                            else
                                if TBL_DATOS (NUINDICE).PREDLDVI = 'B' then
                                    SBDIRECCION := SBDIRECCION||' BIS';
                                    sbletras := sbletras||' BIS';
                                else
                                         if tbl_datos (nuindice).PREDLUVI is null and isnumber(tbl_datos (nuindice).PREDLDVI) = 1  then
                                            sbdireccion := sbdireccion||' '||tbl_datos (nuindice).PREDLDVI;
                                            SBLETRAS := SBLETRAS||' '||TBL_DATOS (NUINDICE).PREDLDVI;
                                         else
                                            sbdireccion := sbdireccion||tbl_datos (nuindice).PREDLDVI;
                                            sbletras := sbletras||tbl_datos (nuindice).PREDLDVI;
                                         end if;--if tbl_datos (nuindice).PREDLUVI is null then
                                end if;--if tbl_datos (nuindice).PREDLDVI = 'B' then
                            end if;--if isnumber(tbl_datos (nuindice).PREDLDVI) = 1 and isnumber(tbl_datos (nuindice).PREDLUVI) = 1 then ...
                        end if;--if tbl_datos (nuindice).PREDLDVI is not null then


                        -- Valida LETRA ZONA VIA INICIAL
                        sbsector := null;
                        if tbl_datos (nuindice).PREDLZVI is not null then
                            sbsector := CASE to_char(tbl_datos (nuindice).PREDLZVI)
                                            WHEN 'N' THEN ' NORTE'
                                            WHEN 'S' THEN ' SUR'
                                            WHEN 'O' THEN ' OESTE'
                                            WHEN 'W' THEN ' W'
                                            WHEN 'E' THEN ' ESTE'
                                            ELSE 'I'
                                            END;

                            IF sbsector <> 'I' THEN
                                sbdireccion := sbdireccion||sbsector;
                                IF SBLETRAS IS NULL THEN
                                    SBLETRAS := LTRIM(SBSECTOR);
                                ELSE
                                    sbletras := sbletras||sbsector;
                                END IF;--IF SBLETRAS IS NULL THEN
                            ELSE
                                blError := TRUE;
                                nuErrorCode := 2;
                            END IF;--IF sbsector <> 'I' THEN
                        END IF;--if tbl_datos (nuindice).PREDLZVI is not null then

                        sbdireccion := replace(sbdireccion,'  ',' ');
                        rtVia:=null;
                        if blerror = false then
                            --- Insertar en AB_WAY_BY_LOCATION
                                AB_Boparser.FixSpaces(SBDIRECCION);
                                open cuVias ( nuLocahomo, nuTipo,sbdireccion);
                                fetch cuVias into rtVia;
                                if cuVias%notfound then
                                    close CUVIAS;
                                    nuContador := SEQ_AB_WAY_BY_LOCATION.NEXTVAL;

                                    SBREGPROC := '0419 | ' || SBREGPROC; -- 20120703: 03-07-2012: carlosvl: Variable para captura el registro con error
                                    BEGIN

                                        INSERT INTO AB_WAY_BY_LOCATION (WAY_BY_LOCATION_ID, WAY_TYPE_ID, GEOGRAP_LOCATION_ID, DESCRIPTION,
                                                                        WAY_NUMBER, LETTERS_WAY, HAS_PREVIOUS_VALUE)
                                             VALUES (nuContador,nuTipo, nuLocaHomo, sbdireccion, tbl_datos (nuindice).PREDNUVI, sbletras,null);


                                        INSERT INTO LDC_MIG_VIAS (PREDDEPA, PREDLOCA, PREDTVIN, PREDNUVI, PREDLUVI, PREDLDVI, PREDLZVI, PREDDIRE,
                                                                  DEPAHOMO, LOCAHOMO, CONSHOMO, TIVIHOMO, NUVIHOMO, LEVIHOMO, DIREHOMO, IND_SINONIMO, BASEDATO, DATABASE)
                                             VALUES (tbl_datos (nuindice).PREDDEPA, tbl_datos (nuindice).PREDLOCA, tbl_datos (nuindice).PREDTVIN, tbl_datos (nuindice).PREDNUVI,
                                                     TBL_DATOS (NUINDICE).PREDLUVI, TBL_DATOS (NUINDICE).PREDLDVI, TBL_DATOS (NUINDICE).PREDLZVI, null,
                                                     nuDEPAHOMO, nuLocaHomo, nuContador, nuTipo, nunumero, sbletras, sbdireccion, 'N', 'CALI',inubasedato);
                                        COMMIT;
                                    EXCEPTION
                                     WHEN OTHERS THEN
                                        BEGIN

                                           NUERRORES := NUERRORES + 1;
                                           PKLOG_MIGRACION.prInsLogMigra ( 137,137,2,vprograma||vcontIns,0,0,'Sinonimo : '||sbRegProc||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                                        END;
                                    END;

                                    vcontIns := vcontIns + 1;
                                else
                                    --dbms_output.put_line(rtvia.way_by_location_id);
                                    close cuVias;
                                end if;--if cuVias%notfound then
                       else
                            if NUERRORCODE = 1 then
                                sbErrorMessage := 'Error en PREDLUVI es nulo y PREDLUDI no es nulo. Registro : Registro : '||tbl_datos (nuindice).preddepa ||'-'|| tbl_datos (nuindice).predloca ||'-'||tbl_datos (nuindice).PREDTVIN||'-'||tbl_datos (nuindice).PREDNUVI||'-'||TBL_DATOS (NUINDICE).PREDLUVI||'-'||TBL_DATOS (NUINDICE).PREDLDVI||'-'||TBL_DATOS (NUINDICE).PREDLZVI;
                            else
                            --elsif nuErrorCode = 2 then
                                sbErrorMessage := 'Error en Sector PREDLZVI. Registro : '||tbl_datos (nuindice).preddepa ||'-'|| tbl_datos (nuindice).predloca ||'-'||tbl_datos (nuindice).PREDTVIN||'-'||tbl_datos (nuindice).PREDNUVI||'-'||TBL_DATOS (NUINDICE).PREDLUVI||'-'||TBL_DATOS (NUINDICE).PREDLDVI||'-'||TBL_DATOS (NUINDICE).PREDLZVI;
                            end if;--if nuErrorCode = 1 then

                           NUERRORES := NUERRORES + 1;
                           PKLOG_MIGRACION.prInsLogMigra ( 137,137,2,vprograma||vcontIns,0,0,'Sinonimo : '||sbRegProc||' - Error: '||sbErrorMessage,to_char(NUERRORCODE),nuLogError);

                        end if;

                        --- Insertar la via de cruce
                        blerror        := false;
                        sbdireccion    := null;
                        nuNumero       := null;
                        sbletras       := null;
                        nuErrorCode    := NULL;
                        SBERRORMESSAGE := null;
                        SBTOKEN        := null;
                        nutipo         := null;
                  end if;--if ((tbl_datos (nuindice).PREDNUVI >= 500 and tbl_datos (nuindice).PREDNUVI < 600 and tbl_datos (nuindice).preddepa = 76 and tbl_datos (nuindice).predloca  = 1 --then ...


            EXCEPTION
             WHEN OTHERS THEN
                BEGIN

                   NUERRORES := NUERRORES + 1;
                   PKLOG_MIGRACION.prInsLogMigra ( 137,137,2,vprograma||vcontIns,0,0,'Sinonimo : '||sbRegProc||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                END;
            END;
        END LOOP;--FOR nuindice IN 1 .. tbl_datos.COUNT LOOP



        vfecha_fin := SYSDATE;


        COMMIT;

    EXIT WHEN cupredio%NOTFOUND;

    END LOOP;

    -- Cierra CURSOR.
    IF (cupredio%ISOPEN) THEN
        CLOSE cupredio;
    END IF;

   OPEN cupredio1;
    LOOP
        -- Borrar tablas     tbl_datos.
        --
        tbl_datos1.delete;

        FETCH CUPREDIO1
        BULK COLLECT INTO tbl_datos1
        LIMIT 1000;

        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

        FOR nuindice IN 1 .. tbl_datos1.COUNT LOOP
            BEGIN
                nucount        :=0;
                sbdireccion    := NULL;
                blError        := False;
                nuNumero       := NULL;
                sbletras       := NULL;
                nuErrorCode    := NULL;
                nuSinonimo     := NULL;
                SBERRORMESSAGE := NULL;
                nuPredio       := NULL; --tbl_datos1 (nuindice).PREDCODI;
                nutipo         := NULL;
                vcontLec       := vcontLec + 1;


                SBREGPROC := ''; -- 20120703: 03-07-2012: carlosvl: Variable para captura el registro con error

                sbRegProc := tbl_datos1 (nuindice).preddepa ||'-'|| tbl_datos1 (nuindice).predloca ||'-'||tbl_datos1 (nuindice).PREDTVIN||'-'||tbl_datos1 (nuindice).PREDNUVI||'-'||tbl_datos1 (NUINDICE).PREDLUVI||'-'||tbl_datos1 (NUINDICE).PREDLDVI||'-'||tbl_datos1 (NUINDICE).PREDLZVI;-- -- 20120703: 03-07-2012: carlosvl: Variable para captura el registro con error
                --dbms_output.put_line(sbRegProc);
                -- Sinonimo : 0419 | 66-170-M-19--- - Error: ORA-02291: restricción de integridad (OPEN.FK_AB_WATY_AB_WBLO) violada - clave principal no encontrada


                SELECT count(divisino)into nucount
                from ldc_temp_diccvias_sge
                WHERE diviloca =tbl_datos1 (NUINDICE).PREDLOCA
                AND dividepa =tbl_datos1 (NUINDICE).PREDDEPA
                AND divinume = to_char(tbl_datos1 (NUINDICE).PREDNUVI||nvl(tbl_datos1 (NUINDICE).PREDLUVI,'')||nvl(tbl_datos1 (NUINDICE).PREDLDVI,'')||nvl(tbl_datos1 (NUINDICE).PREDLZVI,''))
                AND  divitivi= DECODE( to_char(tbl_datos1 (NUINDICE).PREDTVIN), 'CL','C','KR','K','AV','A','DG','D','TV','T',tbl_datos1 (NUINDICE).PREDTVIN)
                AND BASEDATO=inubasedato;

                -- DIRECCIONES QUE TIENEN SINONIMOS EN GAS PLUS

                 if (nucount =1) then --Direcciones de otras localidades.
                      -- Determina localidad y departamento
                      open CULOCALIDAD(tbl_datos1 (NUINDICE).PREDDEPA, tbl_datos1 (NUINDICE).PREDLOCA) ;
                      FETCH CULOCALIDAD into NULOCAHOMO, NUDEPAHOMO;
                      close CULOCALIDAD;

                      -- Homologa la vía para buscar en el diccionario
                      nuvia_:= case to_char(tbl_datos1 (nuindice).PREDTVIN)
                               when 'CL' then 'C'
                               when 'KR' then 'K'
                               when 'AV' then 'A'
                               WHEn 'TV' then 'T'
                               WHEN 'DG' then 'D'
                               else tbl_datos1 (nuindice).PREDTVIN
                               END;
                      nudivisino:= null;

                      -- Consulta la via en el diccionario
                      open cudiccvias (tbl_datos1 (NUINDICE).PREDDEPA, tbl_datos1 (NUINDICE).PREDLOCA, nuvia_, tbl_datos1 (NUINDICE).PREDNUVI||nvl(tbl_datos1 (NUINDICE).PREDLUVI,'')||nvl(tbl_datos1 (NUINDICE).PREDLDVI,'')||nvl(tbl_datos1 (NUINDICE).PREDLZVI,''));
                      fetch   cudiccvias INTO nuvia,nudivisino;
                      close cudiccvias;


                     -- homologa el tipo de via de acuerdo a la via del diccionario
                     nutipo := CASE to_char(trim(nuvia))
                              WHEN 'KR'  THEN  '5'
                              WHEN 'CL'  THEN  '2'
                              WHEN 'DG' THEN  '3'
                              WHEN 'TR'  THEN  '9'
                              WHEN 'AV'  THEN  '1'
                              WHEN 'CLLJN' THEN '101'
                              WHEN 'VIA' THEN '11'
                              WHEN 'KM' THEN '6'
                              WHEN 'PASAJE'  THEN '102'
                              WHEN 'SECTOR'  then '8'
                              ELSE '0'
                              END;
                     -- remueve el doble espacio
                     nudivisino:=replace(replace(replace(replace(replace(replace(replace(replace(replace(nudivisino,'  ',' '),'CLLJN','CLLJON'),'VIA','VIA_'),'DIG','DG'),'CL.','CL'),'PASAJE','PAJ'),'CRA','KR'),'CR','KR'),'SECTOR','SECTOR_');
                     rtVia:=null;
                     -- Si en encontró sinonimo y encontro via
                     -- PUNTO DE QUIEBRE
                     if nudivisino IS not null AND nutipo <>0  then

                        -- Valida si existe la via en ab_way_by_location
                        AB_Boparser.FixSpaces(nudivisino);
                        open cuVias ( nuLocahomo, nuTipo,nudivisino);
                        fetch cuVias into rtVia;
                        if cuVias%notfound then
                            close CUVIAS;


                            NUCONTADOR := SEQ_AB_WAY_BY_LOCATION.NEXTVAL;
                            INSERT INTO AB_WAY_BY_LOCATION (WAY_BY_LOCATION_ID, WAY_TYPE_ID, GEOGRAP_LOCATION_ID, DESCRIPTION,
                                                                        WAY_NUMBER, LETTERS_WAY, HAS_PREVIOUS_VALUE)
                            VALUES (nuContador,nutipo, nuLocaHomo,nudivisino,null, null,null);

                            INSERT INTO LDC_MIG_VIAS (PREDDEPA, PREDLOCA, PREDTVIN, PREDNUVI, PREDLUVI, PREDLDVI, PREDLZVI, PREDDIRE,
                                                                  DEPAHOMO, LOCAHOMO, CONSHOMO, TIVIHOMO, NUVIHOMO, LEVIHOMO, DIREHOMO, IND_SINONIMO, BASEDATO, DATABASE)
                            VALUES (tbl_datos1 (nuindice).PREDDEPA, tbl_datos1 (nuindice).PREDLOCA, tbl_datos1 (nuindice).PREDTVIN, tbl_datos1 (nuindice).PREDNUVI,
                                                     tbl_datos1 (NUINDICE).PREDLUVI, tbl_datos1 (NUINDICE).PREDLDVI, tbl_datos1 (NUINDICE).PREDLZVI, null,
                                                    nuDEPAHOMO, nuLocaHomo, nuContador, nutipo, null, null, nudivisino, 'N', '',inubasedato);
                            COMMIT;


                        else
                            close cuvias;
                        END if;
                      END if;


                 else

                        --dbms_output.put_line('ELSE');

                        open CUTIPOVIA(tbl_datos1 (NUINDICE).PREDTVIN);
                        FETCH CUTIPOVIA into NUTIPO, SBTOKEN;
                        close CUTIPOVIA;

                        open CULOCALIDAD(tbl_datos1 (NUINDICE).PREDDEPA, tbl_datos1 (NUINDICE).PREDLOCA) ;
                        FETCH CULOCALIDAD into NULOCAHOMO, NUDEPAHOMO;
                        close CULOCALIDAD;

                        SBDIRECCION := sbTOKEN||' '||tbl_datos1 (NUINDICE).PREDNUVI;
                        nunumero := tbl_datos1 (nuindice).PREDNUVI;

                       -- Valida la letra uno LETRA UNO VIA INICIAL
                        if tbl_datos1 (nuindice).PREDLUVI is not null then
                            if isnumber(tbl_datos1 (nuindice).PREDLUVI) = 1 then
                                sbdireccion := sbdireccion||' '||tbl_datos1 (nuindice).PREDLUVI;
                                sbletras := tbl_datos1 (nuindice).PREDLUVI;
                            else
                                sbdireccion := sbdireccion||tbl_datos1 (nuindice).PREDLUVI;
                                sbletras := tbl_datos1 (nuindice).PREDLUVI;
                            end if;--if isnumber(tbl_datos1 (nuindice).PREDLUVI) = 1 then
                        end if;--if tbl_datos1 (nuindice).PREDLUVI is not null then

                        -- Valida la letra dos -- LETRA DOS VIA INICIAL
                        if tbl_datos1 (nuindice).PREDLDVI is not null then
                            if isnumber(tbl_datos1 (nuindice).PREDLDVI) = 1 and isnumber(tbl_datos1 (nuindice).PREDLUVI) = 1 then
                                sbdireccion := sbdireccion||' '||tbl_datos1 (nuindice).PREDLDVI;
                                sbletras := sbletras||' '||tbl_datos1 (nuindice).PREDLDVI;
                            else
                                if tbl_datos1 (NUINDICE).PREDLDVI = 'B' then
                                    SBDIRECCION := SBDIRECCION||' BIS';
                                    sbletras := sbletras||' BIS';
                                else
                                         if tbl_datos1 (nuindice).PREDLUVI is null and isnumber(tbl_datos1 (nuindice).PREDLDVI) = 1  then
                                            sbdireccion := sbdireccion||' '||tbl_datos1 (nuindice).PREDLDVI;
                                            SBLETRAS := SBLETRAS||' '||tbl_datos1 (NUINDICE).PREDLDVI;
                                         else
                                            sbdireccion := sbdireccion||tbl_datos1 (nuindice).PREDLDVI;
                                            sbletras := sbletras||tbl_datos1 (nuindice).PREDLDVI;
                                         end if;--if tbl_datos1 (nuindice).PREDLUVI is null then
                                end if;--if tbl_datos1 (nuindice).PREDLDVI = 'B' then
                            end if;--if isnumber(tbl_datos1 (nuindice).PREDLDVI) = 1 and isnumber(tbl_datos1 (nuindice).PREDLUVI) = 1 then ...
                        end if;--if tbl_datos1 (nuindice).PREDLDVI is not null then


                        -- Valida LETRA ZONA VIA INICIAL
                        sbsector := null;
                        if tbl_datos1 (nuindice).PREDLZVI is not null then
                            sbsector := CASE to_char(tbl_datos1 (nuindice).PREDLZVI)
                                            WHEN 'N' THEN ' NORTE'
                                            WHEN 'S' THEN ' SUR'
                                            WHEN 'O' THEN ' OESTE'
                                            WHEN 'W' THEN ' W'
                                            WHEN 'E' THEN ' ESTE'
                                            ELSE 'I'
                                            END;

                            IF sbsector <> 'I' THEN
                                sbdireccion := sbdireccion||sbsector;
                                IF SBLETRAS IS NULL THEN
                                    SBLETRAS := LTRIM(SBSECTOR);
                                ELSE
                                    sbletras := sbletras||sbsector;
                                END IF;--IF SBLETRAS IS NULL THEN
                            ELSE
                                blError := TRUE;
                                nuErrorCode := 2;
                            END IF;--IF sbsector <> 'I' THEN
                        END IF;--if tbl_datos1 (nuindice).PREDLZVI is not null then

                        sbdireccion := replace(sbdireccion,'  ',' ');
                        rtVia:=null;
                        if blerror = false then
                            --- Insertar en AB_WAY_BY_LOCATION
                                AB_Boparser.FixSpaces(sbdireccion);
                                open cuVias ( nuLocahomo, nuTipo,sbdireccion);
                                fetch cuVias into rtVia;
                                if cuVias%notfound then
                                    close CUVIAS;
                                    nuContador := SEQ_AB_WAY_BY_LOCATION.NEXTVAL;

                                    SBREGPROC := '0419 | ' || SBREGPROC; -- 20120703: 03-07-2012: carlosvl: Variable para captura el registro con error
                                    BEGIN

                                        INSERT INTO AB_WAY_BY_LOCATION (WAY_BY_LOCATION_ID, WAY_TYPE_ID, GEOGRAP_LOCATION_ID, DESCRIPTION,
                                                                        WAY_NUMBER, LETTERS_WAY, HAS_PREVIOUS_VALUE)
                                             VALUES (nuContador,nuTipo, nuLocaHomo, sbdireccion, tbl_datos1 (nuindice).PREDNUVI, sbletras,null);


                                        INSERT INTO LDC_MIG_VIAS (PREDDEPA, PREDLOCA, PREDTVIN, PREDNUVI, PREDLUVI, PREDLDVI, PREDLZVI, PREDDIRE,
                                                                  DEPAHOMO, LOCAHOMO, CONSHOMO, TIVIHOMO, NUVIHOMO, LEVIHOMO, DIREHOMO, IND_SINONIMO, BASEDATO, DATABASE)
                                             VALUES (tbl_datos1 (nuindice).PREDDEPA, tbl_datos1 (nuindice).PREDLOCA, tbl_datos1 (nuindice).PREDTVIN, tbl_datos1 (nuindice).PREDNUVI,
                                                     tbl_datos1 (NUINDICE).PREDLUVI, tbl_datos1 (NUINDICE).PREDLDVI, tbl_datos1 (NUINDICE).PREDLZVI, null,
                                                     nuDEPAHOMO, nuLocaHomo, nuContador, nuTipo, nunumero, sbletras, sbdireccion, 'N', 'CALI',inubasedato);
                                        COMMIT;
                                    EXCEPTION
                                     WHEN OTHERS THEN
                                        BEGIN

                                           NUERRORES := NUERRORES + 1;
                                           PKLOG_MIGRACION.prInsLogMigra ( 137,137,2,vprograma||vcontIns,0,0,'Sinonimo : '||sbRegProc||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                                        END;
                                    END;

                                    vcontIns := vcontIns + 1;
                                else
                                    --dbms_output.put_line(rtvia.way_by_location_id);
                                    close cuVias;
                                end if;--if cuVias%notfound then
                       else
                            if NUERRORCODE = 1 then
                                sbErrorMessage := 'Error en PREDLUVI es nulo y PREDLUDI no es nulo. Registro : Registro : '||tbl_datos1 (nuindice).preddepa ||'-'|| tbl_datos1 (nuindice).predloca ||'-'||tbl_datos1 (nuindice).PREDTVIN||'-'||tbl_datos1 (nuindice).PREDNUVI||'-'||tbl_datos1 (NUINDICE).PREDLUVI||'-'||tbl_datos1 (NUINDICE).PREDLDVI||'-'||tbl_datos1 (NUINDICE).PREDLZVI;
                            else
                            --elsif nuErrorCode = 2 then
                                sbErrorMessage := 'Error en Sector PREDLZVI. Registro : '||tbl_datos1 (nuindice).preddepa ||'-'|| tbl_datos1 (nuindice).predloca ||'-'||tbl_datos1 (nuindice).PREDTVIN||'-'||tbl_datos1 (nuindice).PREDNUVI||'-'||tbl_datos1 (NUINDICE).PREDLUVI||'-'||tbl_datos1 (NUINDICE).PREDLDVI||'-'||tbl_datos1 (NUINDICE).PREDLZVI;
                            end if;--if nuErrorCode = 1 then

                           NUERRORES := NUERRORES + 1;
                           PKLOG_MIGRACION.prInsLogMigra ( 137,137,2,vprograma||vcontIns,0,0,'Sinonimo : '||sbRegProc||' - Error: '||sbErrorMessage,to_char(NUERRORCODE),nuLogError);

                        end if;

                        --- Insertar la via de cruce
                        blerror        := false;
                        sbdireccion    := null;
                        nuNumero       := null;
                        sbletras       := null;
                        nuErrorCode    := NULL;
                        SBERRORMESSAGE := null;
                        SBTOKEN        := null;
                        nutipo         := null;
                  end if;--if ((tbl_datos1 (nuindice).PREDNUVI >= 500 and tbl_datos1 (nuindice).PREDNUVI < 600 and tbl_datos1 (nuindice).preddepa = 76 and tbl_datos1 (nuindice).predloca  = 1 --then ...


            EXCEPTION
             WHEN OTHERS THEN
                BEGIN

                   NUERRORES := NUERRORES + 1;
                   PKLOG_MIGRACION.prInsLogMigra ( 137,137,2,vprograma||vcontIns,0,0,'Sinonimo : '||sbRegProc||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                END;
            END;
        END LOOP;--FOR nuindice IN 1 .. tbl_datos1.COUNT LOOP

        vfecha_fin := SYSDATE;

        COMMIT;

    EXIT WHEN cupredio1%NOTFOUND;

    END LOOP;

    -- Cierra CURSOR.
    if (CUPREDIO1%ISOPEN) then
        CLOSE cupredio1;
    end if;

 -- Termina Log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 137,137,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);


EXCEPTION
   WHEN OTHERS THEN
      BEGIN

         NUERRORES := NUERRORES + 1;
         PKLOG_MIGRACION.prInsLogMigra ( 137,137,2,vprograma||vcontIns,0,0,'Sinonimo : '||sbRegProc||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

      END;

END PR_AB_WAY_BY_LOCATION; 
/
