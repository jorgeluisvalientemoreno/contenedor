CREATE OR REPLACE PROCEDURE      "GESUBSCRIBER" (numinicio number,numfinal number,pbd number) AS
  /*******************************************************************
 PROGRAMA        :    Ge_subscriber
 FECHA            :    14/05/2014
 AUTOR            :    VICTOR MUNIVE
 DESCRIPCION    :    Migra la informacion de Suscripc a GE_SUBSCRIBER
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   
   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuErrorCode       NUMBER;
   sbErrorMessage    VARCHAR2 (4000);
   nusubscriber_id   Ge_Subscriber.subscriber_id%TYPE;
   sbNombre          Ge_Subscriber.SUBSCRIBER_NAME%type;
   sbApellido1       Ge_Subscriber.SUBS_LAST_NAME%type;
   sbApellido2       Ge_Subscriber.SUBS_SECOND_LAST_NAME%type;
   nuDocumento       number(20):= 0;
   vfecha_ini             DATE;
   vfecha_fin             DATE;
   vprograma              VARCHAR2 (100);
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   verror                 VARCHAR2 (4000);
   NUNUMERO               NUMBER := 0;
   DTFECHA               DATE;
   nuCliente             number := 0;
   nusubs_id             number := 0;
   sbcategori             number:=0;
   sbsql varchar2(800);
   maxnumber number :=50000;
   cocli                 number;
   -- Cursor con los datos de origen
   cursor cuDatos is
    select distinct C.SESUCATE,a.susccodi susccodi, decode(C.sESUcate,1,1,110) susctiid,
           nvl(a.suscnice,-1) suscnice, a.SUSCFEIN, nvl(a.suscnomb,'NO_TIENE_NOMBRE') suscnomb,a.suscapel suscapel,  a.susctele,
           B.PREDHOMO, B.DIREPARS,a.basedato basedato ,a.suscticl, d.tisuhomo
           from LDC_TEMP_suscripc_SGE A, LDC_MIG_DIRECCION b, ldc_temp_servsusc_SGE c, LDC_MIG_TIPOSUSC d 
       WHERE B.database = a.basedato and 
                 a.basedato=c.basedato and 
                 B.PREDHOMO IS NOT NULL and 
                 c.sesususc = a.susccodi and
                 a.susctisu = d.coditisu
                 and c.sesueste in (SELECT distinct estado_tecnico FROM ldc_estados_serv_homo)
                 and c.sesupred = b.predcodi AND  NOT exists (SELECT 1 FROM LDC_CLIE_SUSC e where e.susccodi=a.SUSCCODI)
                 order by susccodi desc;
   cursor cuDatos1 is
     select distinct C.SESUCATE,a.susccodi susccodi, decode(C.sESUcate,1,1,110) susctiid,
            nvl(a.suscnice,-1) suscnice, a.SUSCFEIN, nvl(a.suscnomb,'NO_TIENE_NOMBRE') suscnomb,a.suscapel suscapel,  a.susctele,
            1 PREDHOMO, 'KR NO EXISTE CL NO EXISTE - 0' DIREPARS,a.basedato basedato ,a.suscticl,d.TISUHOMO
            from LDC_TEMP_suscripc_SGE A,  ldc_temp_servsusc_SGE c, LDC_MIG_TIPOSUSC d 
        WHERE  a.basedato=c.basedato 
                   and c.sesususc = a.susccodi 
                   and a.susctisu = d.coditisu
                   and c.sesueste in (SELECT distinct estado_tecnico FROM ldc_estados_serv_homo)
                   and A.SUSCCODI NOT IN (SELECT SUSCCODI FROM LDC_CLIE_SUSC)
                    order by susccodi desc;
   cursor cuDatos2 is
     select distinct 1 SESUCATE,a.susccodi susccodi, 1 susctiid,
            nvl(a.suscnice,-1) suscnice, a.SUSCFEIN, nvl(a.suscnomb,'NO_TIENE_NOMBRE') suscnomb,a.suscapel suscapel,a.susctele,
            1 PREDHOMO, 'KR NO EXISTE CL NO EXISTE - 0' DIREPARS,a.basedato basedato ,a.suscticl,d.TISUHOMO
            from LDC_TEMP_suscripc_SGE A, LDC_MIG_TIPOSUSC d
        WHERE A.SUSCCODI NOT IN (SELECT SUSCCODI FROM LDC_CLIE_SUSC)
        and a.susctisu = d.coditisu
         order by susccodi desc;
   van number;
   
   cursor Cucategori (nucontrato number) is
   select sesucate
   from migra.ldc_temp_servsusc_SGE
   where sesususc=nucontrato
   order by sesuserv;
   
   -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuDatos%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
  --- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
   FUNCTION existe_cliente(p_identification VARCHAR2,p_sbNombre varchar2,p_sbApellido1 varchar2,p_sbApellido2 varchar2)
   return number is
    CURSOR cucliente IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre
    AND subs_last_name = p_sbApellido1
    AND subs_second_last_name = p_sbApellido2;
    CURSOR cucliente_1 IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre
    AND subs_last_name = p_sbApellido1;
    CURSOR cucliente_2 IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre
    AND subs_last_name = p_sbApellido1;
    nusubscriber_id number;
   BEGIN
    if cucliente%isopen then
        close cucliente;
    END if;
    if cucliente_1%isopen then
        close cucliente_1;
    END if;
    nusubscriber_id := null;
    if ( p_sbNombre IS not null AND p_sbApellido1 IS not null AND p_sbApellido2 IS not null ) then
        open cucliente;
        fetch cucliente INTO nusubscriber_id;
        close cucliente;
    elsif ( p_sbNombre IS not null AND p_sbApellido1 IS not null AND p_sbApellido2 IS null ) then
        open cucliente_1;
        fetch cucliente_1 INTO nusubscriber_id;
        close cucliente_1;
     elsif ( p_sbNombre IS not null AND p_sbApellido1 IS null AND p_sbApellido2 IS null ) then
        open cucliente_2;
        fetch cucliente_2 INTO nusubscriber_id;
        close cucliente_2;
    END if;
    if   nusubscriber_id IS null then
        nusubscriber_id := 0;
    END if;
    return nusubscriber_id;
   END;
   ----------------------------------------------
BEGIN
   update migr_rango_procesos set raprfein=sysdate,RAPRTERM='P' where raprcodi=154 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   commit;
   delete from log_migracion where lomiproc=154;
   commit;
 --  DELETE FROM LDC_CLIE_SUSC;
 --  COMMIT;
   van:=0;
   vprograma := 'GE_SUBSCRIBER';
   vfecha_ini := SYSDATE;
   EXECUTE IMMEDIATE 'CREATE INDEX DL_IX_SUBSCRIBER ON GE_SUBSCRIBER(IDENTIFICATION,SUBSCRIBER_NAME,SUBS_LAST_NAME,SUBS_SECOND_LAST_NAME)';
   -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (154,154,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
   -- Extraer los datos
   OPEN cuDatos;
   LOOP
      --
      -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuDatos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
       NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            sbNombre := NULL;
            nuErrorCode := NULL;
            sbErrorMessage := NULL;
            SBAPELLIDO1 := NULL;
            SBAPELLIDO2 := NULL;
            sbcategori  :=null;
            
            open Cucategori (tbl_datos(nuindice).susccodi);
            fetch Cucategori into  sbcategori;
            close Cucategori;
            
            nusubs_id := existe_cliente(tbl_datos(nuindice).suscnice,tbl_datos (nuindice).suscnomb,tbl_datos (nuindice).suscapel,null);
            if ( nusubs_id = 0) then
               -- Crea el cliente
               nucliente := tbl_datos (nuindice).susccodi;
               select seq_ge_subscriber.nextval into cocli from dual;
                GSI_MIG_RegistraCliente (cocli, --tbl_datos (nuindice).susccodi,
                                tbl_datos (nuindice).susctiid,                -- Tipo de Id ge_identifica_type
                                tbl_datos (nuindice).suscnice,                    -- Identificaci¿n
                                NULL,                                 -- Parent_id
                                tbl_datos (nuindice).suscticl,         -- Subscriber Type   ge_subscriber_type
                                tbl_datos (nuindice).DIREPARS,                      -- Direcci¿n cadena
                                tbl_datos (nuindice).susctele,                              -- Telefono
                                tbl_datos (nuindice).suscnomb,                     -- Nombre del cliente
                                tbl_datos (nuindice).suscapel,                             -- Apellido 1
                                NULL,                                -- Apellido 2
                                NULL, --tbl_datos (nuindice).PERSFENA,               -- Fecha de Nacimiento
                                    SYSDATE,  -- FEcha de la ultima actualizacion
                                NULL, --tbl_datos (nuindice).PERSMAIL,          -- Email
                                NULL, -- 'www.prueba/api.net',                       -- URL
                                NULL,         --'3319999', -- ID del contacto 3090
                                tbl_datos (nuindice).TISUHOMO,    -- Actividad economica ge_economic_activity
                                1, -- ID del segmento de mercado cc_marketing_segment
                                1,                    -- Satus ID   ge_subs_status
                                'Y',                     -- Esta activo, SI=Y NO=N
                                tbl_datos (nuindice).PREDHOMO, -- ID de la dir parseada SELECT address_id, address FROM ab_address
                                1,            -- Tipo de contribuyente fa_tipocont
                                'N',                                  -- DATA_SEND
                                tbl_datos (nuindice).SUSCFEIN,                   -- Fecha de vinculaci¿n
                                    NULL,
                                    null,
                                    'N',
                                nuErrorCode,
                                sbErrorMessage);
         vcontLec := vcontLec + 1;
         vfecha_fin := SYSDATE;
         IF NUERRORCODE IS NULL THEN
                    vcontIns := vcontIns + 1;
                    INSERT INTO ldc_clie_susc VALUES (tbl_datos (nuindice).susccodi,tbl_datos(nuindice).basedato,cocli);
                    van:=van+1;
                    if van=1000 then
                       execute immediate 'analyze table ge_subscriber compute statistics';
            end if;
         else
                    NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra ( 154,154,2,vprograma||vcontIns,tbl_datos (nuindice).susccodi,0,'Cliente : '||tbl_datos (nuindice).susccodi||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
         end if;
            else
               INSERT INTO ldc_clie_susc VALUES (tbl_datos (nuindice).susccodi,tbl_datos (nuindice).basedato,nusubs_id);
            END if;
            COMMIT;
         EXCEPTION
            WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 154,154,2,vprograma||vcontIns,tbl_datos (nuindice).susccodi,0,'Cliente e: '||tbl_datos (nuindice).susccodi||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
         END;
      END LOOP;
      EXIT WHEN cuDatos%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuDatos%ISOPEN)
   THEN
      --{
      CLOSE cuDatos;
   --}
   END IF;
   OPEN cuDatos1;
   LOOP
      --
      -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuDatos1
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
       NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            sbNombre := NULL;
            nuErrorCode := NULL;
            sbErrorMessage := NULL;
            SBAPELLIDO1 := NULL;
            SBAPELLIDO2 := NULL;
      
            nusubs_id := existe_cliente(tbl_datos(nuindice).suscnice,tbl_datos (nuindice).suscnomb,tbl_datos (nuindice).suscapel,null);
           
            sbcategori  :=null;
            
            open Cucategori (tbl_datos(nuindice).susccodi);
            fetch Cucategori into  sbcategori;
            close Cucategori;
      
            if ( nusubs_id = 0) then
               -- Crea el cliente
               nucliente := tbl_datos (nuindice).susccodi;
               select seq_ge_subscriber.nextval into cocli from dual;
                GSI_MIG_RegistraCliente (cocli, --tbl_datos (nuindice).susccodi,
                                tbl_datos (nuindice).susctiid,                -- Tipo de Id ge_identifica_type
                                tbl_datos (nuindice).suscnice,                    -- Identificaci¿n
                                NULL,                                 -- Parent_id
                                tbl_datos (nuindice).suscticl,         -- Subscriber Type   ge_subscriber_type
                                tbl_datos (nuindice).DIREPARS,                      -- Direcci¿n cadena
                                tbl_datos (nuindice).susctele,                              -- Telefono
                                tbl_datos (nuindice).suscnomb,                     -- Nombre del cliente
                                tbl_datos (nuindice).suscapel,                             -- Apellido 1
                                SBAPELLIDO2,                                -- Apellido 2
                                NULL, --tbl_datos (nuindice).PERSFENA,               -- Fecha de Nacimiento
                                    SYSDATE,  -- FEcha de la ultima actualizacion
                                NULL, --tbl_datos (nuindice).PERSMAIL,          -- Email
                                NULL, -- 'www.prueba/api.net',                       -- URL
                                NULL,         --'3319999', -- ID del contacto 3090
                                tbl_datos (nuindice).TISUHOMO,    -- Actividad economica ge_economic_activity
                                1, -- ID del segmento de mercado cc_marketing_segment
                                1,                    -- Satus ID   ge_subs_status
                                'Y',                     -- Esta activo, SI=Y NO=N
                                tbl_datos (nuindice).PREDHOMO, -- ID de la dir parseada SELECT address_id, address FROM ab_address
                                1,            -- Tipo de contribuyente fa_tipocont
                                'N',                                  -- DATA_SEND
                                tbl_datos (nuindice).SUSCFEIN,                   -- Fecha de vinculaci¿n
                                    NULL,
                                    null,
                                    'N',
                                nuErrorCode,
                                sbErrorMessage);
         vcontLec := vcontLec + 1;
         vfecha_fin := SYSDATE;
         IF NUERRORCODE IS NULL THEN
                    vcontIns := vcontIns + 1;
                    INSERT INTO ldc_clie_susc VALUES (tbl_datos (nuindice).susccodi,tbl_datos(nuindice).basedato,cocli);
                    van:=van+1;
                    if van=1000 then
                       execute immediate 'analyze table ge_subscriber compute statistics';
            end if;
         else
                    NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra ( 154,154,2,vprograma||vcontIns,tbl_datos (nuindice).susccodi,0,'Cliente : '||tbl_datos (nuindice).susccodi||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
         end if;
            else
               INSERT INTO ldc_clie_susc VALUES (tbl_datos (nuindice).susccodi,tbl_datos (nuindice).basedato,nusubs_id);
            END if;
            COMMIT;
         EXCEPTION
            WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 154,154,2,vprograma||vcontIns,tbl_datos (nuindice).susccodi,0,'Cliente e: '||tbl_datos (nuindice).susccodi||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
         END;
      END LOOP;
      EXIT WHEN cuDatos1%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuDatos1%ISOPEN)
   THEN
      --{
      CLOSE cuDatos1;
   --}
   END IF;
   -- clientes asociados a suscriptores que no tienen servicios suscritos
   OPEN cuDatos2;
   LOOP
      --
      -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuDatos2
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
       NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR nuindice IN 1 .. tbl_datos.COUNT
      LOOP
         BEGIN
            sbNombre := NULL;
            nuErrorCode := NULL;
            sbErrorMessage := NULL;
            SBAPELLIDO1 := NULL;
            SBAPELLIDO2 := NULL;
            
            sbcategori  :=null;
            
            open Cucategori (tbl_datos(nuindice).susccodi);
            fetch Cucategori into  sbcategori;
            close Cucategori;
            
            nusubs_id := existe_cliente(tbl_datos(nuindice).suscnice,tbl_datos(nuindice).suscnomb,tbl_datos(nuindice).suscapel,null);
            if ( nusubs_id = 0) then
               -- Crea el cliente
               nucliente := tbl_datos (nuindice).susccodi;
               select seq_ge_subscriber.nextval into cocli from dual;
                GSI_MIG_RegistraCliente (cocli, --tbl_datos (nuindice).susccodi,
                                tbl_datos (nuindice).susctiid,                -- Tipo de Id ge_identifica_type
                                tbl_datos (nuindice).suscnice,                    -- Identificaci¿n
                                NULL,                                 -- Parent_id
                                tbl_datos (nuindice).suscticl,         -- Subscriber Type   ge_subscriber_type
                                tbl_datos (nuindice).DIREPARS,                      -- Direcci¿n cadena
                                tbl_datos (nuindice).susctele,                              -- Telefono
                                tbl_datos(nuindice).suscnomb,                     -- Nombre del cliente
                                tbl_datos(nuindice).suscapel,                             -- Apellido 1
                                SBAPELLIDO2,                                -- Apellido 2
                                NULL, --tbl_datos (nuindice).PERSFENA,               -- Fecha de Nacimiento
                                    SYSDATE,  -- FEcha de la ultima actualizacion
                                NULL, --tbl_datos (nuindice).PERSMAIL,          -- Email
                                NULL, -- 'www.prueba/api.net',                       -- URL
                                NULL,         --'3319999', -- ID del contacto 3090
                                tbl_datos (nuindice).TISUHOMO,    -- Actividad economica ge_economic_activity
                                1, -- ID del segmento de mercado cc_marketing_segment
                                1,                    -- Satus ID   ge_subs_status
                                'Y',                     -- Esta activo, SI=Y NO=N
                                tbl_datos (nuindice).PREDHOMO, -- ID de la dir parseada SELECT address_id, address FROM ab_address
                                1,            -- Tipo de contribuyente fa_tipocont
                                'N',                                  -- DATA_SEND
                                tbl_datos (nuindice).SUSCFEIN,                   -- Fecha de vinculaci¿n
                                    NULL,
                                    null,
                                    'N',
                                nuErrorCode,
                                sbErrorMessage);
         vcontLec := vcontLec + 1;
         vfecha_fin := SYSDATE;
         IF NUERRORCODE IS NULL THEN
                    vcontIns := vcontIns + 1;
                    INSERT INTO ldc_clie_susc VALUES (tbl_datos (nuindice).susccodi,tbl_datos(nuindice).basedato,cocli);
                    van:=van+1;
                    if van=1000 then
                       execute immediate 'analyze table ge_subscriber compute statistics';
            end if;
         else
                    NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra ( 154,154,2,vprograma||vcontIns,tbl_datos (nuindice).susccodi,0,'Cliente : '||tbl_datos (nuindice).susccodi||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
         end if;
            else
               INSERT INTO ldc_clie_susc VALUES (tbl_datos (nuindice).susccodi,tbl_datos (nuindice).basedato,nusubs_id);
            END if;
            COMMIT;
         EXCEPTION
            WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                  PKLOG_MIGRACION.prInsLogMigra ( 154,154,2,vprograma||vcontIns,tbl_datos (nuindice).susccodi,0,'Cliente e: '||tbl_datos (nuindice).susccodi||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
         END;
      END LOOP;
      EXIT WHEN cuDatos2%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuDatos2%ISOPEN)
   THEN
      --{
      CLOSE cuDatos2;
   --}
   END IF;
   VFECHA_FIN := SYSDATE;
   COMMIT;
   EXECUTE IMMEDIATE 'DROP INDEX DL_IX_SUBSCRIBER';
    -- Termina Log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 154,154,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
      update migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=154 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 154,154,2,vprograma||vcontIns,0,0,'Cliente : '||nuCliente||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
END GESUBSCRIBER; 
/
