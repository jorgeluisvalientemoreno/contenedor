CREATE OR REPLACE PROCEDURE "PRCOMPONENTMIGR" (NUMINICIO number, numFinal number,pbd number ) AS
  /*******************************************************************
 PROGRAMA            :    PRCOMPONENTmigr
 FECHA            :    15/05/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION        :    Migra la informacion de Servsusc a PR_COMPONENT
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   nuErrorCode       NUMBER;
   sbErrorMessage    VARCHAR2 (4000);
   onuComponentId   pr_component.component_id%TYPE;
   nuDocumento       number(20):= 0;
   vfecha_ini             DATE;
   vfecha_fin             DATE;
   vprograma              VARCHAR2 (100);
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   verror                 VARCHAR2 (4000);
   NUNUMERO               NUMBER := 0;
   NUCOMPONENTEPAPA      PR_COMPONENT.COMPONENT_ID%TYPE;
   nuProducto             number := 0;
   locahomo ab_address.geograp_location_id%type;
   dirpars ab_address.address_parsed%type;
   barhomo ab_address.neighborthood_id%type;
   dire ab_address.address_id%type;
   -- Cursor con los datos de origen para los componentes de productos de gas
   cursor cuSuscripcgas IS
          SELECT  p.product_id sesunuse,
                  p.subscription_id sesususc,
                  NVL(I.FECHCONE,SYSDATE) SESUFECO,
                  p.product_type_id sesuserv,
                  7038 TIPO1,
                  7039 TIPO2,
                  I.MEDIHOMO MEDIDOR,
                  P.subcategory_id subcategoria,
                  p.category_id categoria,
                  CASE
                      WHEN P.PRODUCT_STATUS_ID = 1   then 5
                      when P.PRODUCT_STATUS_ID = 2   then 8
                      when P.PRODUCT_STATUS_ID = 3   then 9
                      WHEN P.PRODUCT_STATUS_ID = 15  then 17
                      when P.PRODUCT_STATUS_ID = 16  then 18
                      when p.product_status_id = 20  then 21
                      else 5
                  end Estado
          FROM LDC_MIG_MEDIDOR_HOMO I, PR_PRODUCT P
          WHERE  P.product_type_id   = 7014
                 AND  P.product_id   = I.sesunuse
                 And  P.subscription_id >= NUMINICIO
                 AND  P.subscription_id < NUMFINAL;
                 
   cursor cuSuscripcinst IS
          SELECT  p.product_id sesunuse,
                  p.subscription_id sesususc,
                  null/*NVL(I.SESUFECO,SYSDATE)*/ SESUFECO,
                  p.product_type_id sesuserv,
                  7038 TIPO1,
                  7039 TIPO2,
                  null/*I.SESUMEDI*/ MEDIDOR,
                  P.subcategory_id subcategoria,
                  p.category_id categoria,
                  CASE
                      WHEN P.PRODUCT_STATUS_ID = 1   then 5
                      when P.PRODUCT_STATUS_ID = 2   then 8
                      when P.PRODUCT_STATUS_ID = 3   then 9
                      WHEN P.PRODUCT_STATUS_ID = 15  then 17
                      when P.PRODUCT_STATUS_ID = 16  then 18
                      when p.product_status_id = 20  then 21
                      else 5
                  end Estado
          FROM LDC_TEMP_SERVSUSC_SGE I, PR_PRODUCT P
          WHERE  P.product_type_id   = 7014
                 AND  P.product_id   = I.SESUNUSE
                 AND  SESUESTE       = 10
                 And  P.subscription_id >= NUMINICIO
                 AND  P.subscription_id < NUMFINAL
                 and not exists (select 1 from Pr_component c where c.product_id=p.product_id and component_type_id=7038) ;
                 
   cursor cuSuscripcSEGbri IS
          SELECT  B.PRODUCT_ID ,
                  B.SUBSCRIPTION_ID,  B.PRODUCT_TYPE_ID,
                  decode(b.PRODUCT_TYPE_ID,7053,7109,7055,7112,7052,7102,6121,7038,7056,7112,7054,7103)  TIPO1,
                  NULL TIPO2,
                  B.subcategory_id subcategoria,
                  B.category_id categoria,
                  CASE
                      WHEN B.PRODUCT_STATUS_ID = 1   then 5
                      when B.PRODUCT_STATUS_ID = 2   then 8
                      when B.PRODUCT_STATUS_ID = 3   then 9
                      WHEN B.PRODUCT_STATUS_ID = 15  then 17
                      when B.PRODUCT_STATUS_ID = 16  then 18
                      when B.product_status_id = 20  then 21
                      else 5
                  end Estado
          FROM open.PR_PRODUCT B
          WHERE (B.PRODUCT_TYPE_ID =  7053 or b.PRODUCT_TYPE_ID  = 7055 or b.PRODUCT_TYPE_ID =7052 OR B.PRODUCT_TYPE_ID =6121 or b.PRODUCT_TYPE_ID =7056 or b.PRODUCT_TYPE_ID =7054)
                And B.SUBSCRIPTION_ID >= NUMINICIO
                AND B.SUBSCRIPTION_ID < NUMFINAL;
   -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuSuscripcGAS%ROWTYPE;
   TYPE TIPO_CU_DATOSSEGbri IS TABLE OF CUSUSCRIPCSEGbri%ROWTYPE;
   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   tbl_datosS      tipo_cu_datosSEGbri := tipo_cu_datosSEGbri ();
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
   nuClassService_id ps_class_service.class_service_id%type;
   BEGIN
   update migr_rango_procesos set raprfein=sysdate,RAPRTERM='P' where raprcodi=162 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   commit;
   VPROGRAMA := 'PRCOMPONENTmigr';
   vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (162,162,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
   -- CREA COMPONENTES DE SERVICIOS DE GAS
   -- Cargar datos
   OPEN cuSuscripcgas;
   LOOP
      --
      -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuSuscripcgas
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
      NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR NUINDICE IN 1 .. TBL_DATOS.COUNT LOOP
          BEGIN
               NUERRORCODE := NULL;
           sbErrorMessage := NULL;
               onuComponentId := null;
            NUCOMPONENTEPAPA := NULL;
               nuProducto := tbl_datos (nuindice).sesunuse;
               select nvl(susciddi,1) into dire from suscripc where susccodi=tbl_datos (nuindice).sesususc;
               select  geograp_location_id,address_parsed, neighborthood_id
                       into locahomo ,    dirpars ,    barhomo
                       from ab_address where ADDRESS_ID=dire;
               nuClassService_id:=NULL;
           GSI_MIG_RegistraComponentes (tbl_datos (nuindice).sesunuse,         -- Identificador del producto PR_PRODUCT
                                            tbl_datos (nuindice).tipo1,            -- Tipo de componente PS_COMPONENT_TYPE
                                            nuClassService_id,                     -- Clase de servicio PS_CLASS_SERVICE
                                            tbl_datos (nuindice).sesunuse,         -- N¿mero de servicio
                                            tbl_datos (nuindice).sesufeco,         -- Fecha de inicio de prestaci¿n del servicio
                                            to_date('31/12/4732', 'dd/mm/yyyy'),   -- Fecha de retiro
                                            1,                                     -- CAntidad
                                            0,                                     -- Dias de gracia
                                            'BI',                                  -- Direccionalidad
                                            TBL_DATOS (NUINDICE).CATEGORIA,        -- Identificador del estrato socioeconomico GE_SOCIOECO_STRATUM
                                            tbl_datos (nuindice).subcategoria,
                                            -1,                                    -- ID de la distribuccion admin
                                            NULL,                                  -- Medidor
                                            NULL,                                  -- Predio  IF_BUILDING
                                            NULL,                                  -- Id de la ruta de asignacion
                                            NULL,                                  -- ID del componente padre
                                            null,                                  -- Identificador del distrito IF_DISTRICT
                                            'N',                                   -- Es incluido "S" = Si, "N" = No
                                            dire,                                  -- Identificador de la direcci¿n AB_ADDRESS
                                            LOCAHOMO,                              -- Identificador de la ubicaci¿n geografica GE_GEOGRA_LOCATION
                                            BARHOMO,                               -- Identificador del barrio
                                            DIRPARS,                               -- Direccion
                                            tbl_datos (nuindice).sesunuse,         -- Identificador del producto Origen
                                            NULL,                                  -- Identificador de los incluidos
                                            tbl_datos (nuindice).ESTADO,           -- ESTADO DEL PRODUCTO 5 = ACTIVO, 8 = SUSPENDIDO Y 9 = RETIRADO,
                                            'Y',
                                            onuComponentId,                        -- Id del componente
                                            nuErrorCode,
                                            sbErrorMessage);
          nucomponentepapa :=    onuComponentId;
          if nuErrorCode is null then
                     COMMIT;
                     null;
          else
                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
          end if;
          onuComponentId := null;
          nuErrorCode := NULL;
          sbErrorMessage := NULL;
          if tbl_datos (nuindice).sesuserv = 7014 then
             --- Componente de Medicion
                     nuClassService_id:=3102;
             GSI_MIG_RegistraComponentes (tbl_datos (nuindice).sesunuse, -- Identificador del producto PR_PRODUCT
                                          tbl_datos (nuindice).tipo2,  -- Tipo de componente PS_COMPONENT_TYPE  -
                                          nuClassService_id,    -- Clase de servicio PS_CLASS_SERVICE
                                          tbl_datos (nuindice).sesunuse,             -- N¿mero de servicio
                                          tbl_datos (nuindice).sesufeco, -- Fecha de inicio de prestaci¿n del servicio
                                          to_date('31/12/4732', 'dd/mm/yyyy'),                 -- Fecha de retiro
                                          1,                                 -- CAntidad
                                          0,                           -- Di¿s de gracia
                                          'BI',                       -- Direccionalidad
                                          TBL_DATOS (NUINDICE).CATEGORIA, -- Identificador del estrato socioeconomico GE_SOCIOECO_STRATUM
                                                  tbl_datos (nuindice).subcategoria,
                                                  -1, -- ID de la distribucci¿n admin GE_DISTRIBUT_ADMIN
                                                  tbl_datos (nuindice).medidor,                               -- Medidor
                                                  NULL,                   -- Predio  IF_BUILDING
                                          NULL, -- Id de la ruta de asignaci¿n IM_ASSIGN_ROUTES
                                          nucomponentepapa,               -- ID del componente padre
                                          null,   -- Identificador del distrito IF_DISTRICT
                                          'N',         -- Es incluido "S" = Si, "N" = No
                                          dire, -- Identificador de la direcci¿n AB_ADDRESS
                                          LOCAHOMO, -- Identificador de la ubicaci¿n geografica GE_GEOGRA_LOCATION -- SELECT geograp_location_id, description FROM GE_GEOGRA_LOCATION
                                                  BARHOMO,                -- Identificador del barrio
                                                  DIRPARS,              -- Direcci¿n
                                          tbl_datos (nuindice).sesunuse,     -- Identificador del producto Origen
                                          NULL,        -- Identificador de los incluidos,
                                                  tbl_datos (nuindice).ESTADO,   --- ESTADO DEL COMPONENTE DEL PRODUCTO 5 = ACTIVO, 8 = SUSPENDIDO Y 9 = RETIRADO,
                                          'N',
                                          onuComponentId,           -- Id del componente
                                          nuErrorCode,
                                          sbErrorMessage);
              vcontLec := vcontLec + 1;
          end if;
          vfecha_fin := SYSDATE;
          if nuErrorCode is null then
                     vcontIns := vcontIns + 1;
                     COMMIT;
          else
                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
          end if;
         EXCEPTION
             WHEN OTHERS THEN
                BEGIN
                   NUERRORES := NUERRORES + 1;
                   PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                END;
          END;
      END LOOP;
      EXIT WHEN cuSuscripcgas%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuSuscripcgas%ISOPEN)
   THEN
      --{
      CLOSE cuSuscripcgas;
   --}
   END IF;
   -- CREA LOS PR_COMPONENT DE GAS CON ESTADO TECNICO EN CONSTRUCCION
 
   OPEN cuSuscripcinst;
   LOOP
      --
      -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;
      FETCH cuSuscripcinst
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
      NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
      FOR NUINDICE IN 1 .. TBL_DATOS.COUNT LOOP
          BEGIN
               NUERRORCODE := NULL;
           sbErrorMessage := NULL;
               onuComponentId := null;
            NUCOMPONENTEPAPA := NULL;
               nuProducto := tbl_datos (nuindice).sesunuse;
               select nvl(susciddi,1) into dire from suscripc where susccodi=tbl_datos (nuindice).sesususc;
               select  geograp_location_id,address_parsed, neighborthood_id
                       into locahomo ,    dirpars ,    barhomo
                       from ab_address where ADDRESS_ID=dire;
               nuClassService_id:=NULL;
           GSI_MIG_RegistraComponentes (tbl_datos (nuindice).sesunuse,         -- Identificador del producto PR_PRODUCT
                                            tbl_datos (nuindice).tipo1,            -- Tipo de componente PS_COMPONENT_TYPE
                                            nuClassService_id,                     -- Clase de servicio PS_CLASS_SERVICE
                                            tbl_datos (nuindice).sesunuse,         -- N¿mero de servicio
                                            tbl_datos (nuindice).sesufeco,         -- Fecha de inicio de prestaci¿n del servicio
                                            to_date('31/12/4732', 'dd/mm/yyyy'),   -- Fecha de retiro
                                            1,                                     -- CAntidad
                                            0,                                     -- Dias de gracia
                                            'BI',                                  -- Direccionalidad
                                            TBL_DATOS (NUINDICE).CATEGORIA,        -- Identificador del estrato socioeconomico GE_SOCIOECO_STRATUM
                                            tbl_datos (nuindice).subcategoria,
                                            -1,                                    -- ID de la distribuccion admin
                                            NULL,                                  -- Medidor
                                            NULL,                                  -- Predio  IF_BUILDING
                                            NULL,                                  -- Id de la ruta de asignacion
                                            NULL,                                  -- ID del componente padre
                                            null,                                  -- Identificador del distrito IF_DISTRICT
                                            'N',                                   -- Es incluido "S" = Si, "N" = No
                                            dire,                                  -- Identificador de la direcci¿n AB_ADDRESS
                                            LOCAHOMO,                              -- Identificador de la ubicaci¿n geografica GE_GEOGRA_LOCATION
                                            BARHOMO,                               -- Identificador del barrio
                                            DIRPARS,                               -- Direccion
                                            tbl_datos (nuindice).sesunuse,         -- Identificador del producto Origen
                                            NULL,                                  -- Identificador de los incluidos
                                            tbl_datos (nuindice).ESTADO,           -- ESTADO DEL PRODUCTO 5 = ACTIVO, 8 = SUSPENDIDO Y 9 = RETIRADO,
                                            'Y',
                                            onuComponentId,                        -- Id del componente
                                            nuErrorCode,
                                            sbErrorMessage);
          nucomponentepapa :=    onuComponentId;
          if nuErrorCode is null then
                     COMMIT;
                     null;
          else
                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
          end if;
          onuComponentId := null;
          nuErrorCode := NULL;
          sbErrorMessage := NULL;
          if tbl_datos (nuindice).sesuserv = 7014 then
             --- Componente de Medicion
                     nuClassService_id:=3102;
             GSI_MIG_RegistraComponentes (tbl_datos (nuindice).sesunuse, -- Identificador del producto PR_PRODUCT
                                          tbl_datos (nuindice).tipo2,  -- Tipo de componente PS_COMPONENT_TYPE  -
                                          nuClassService_id,    -- Clase de servicio PS_CLASS_SERVICE
                                          tbl_datos (nuindice).sesunuse,             -- N¿mero de servicio
                                          tbl_datos (nuindice).sesufeco, -- Fecha de inicio de prestaci¿n del servicio
                                          to_date('31/12/4732', 'dd/mm/yyyy'),                 -- Fecha de retiro
                                          1,                                 -- CAntidad
                                          0,                           -- Di¿s de gracia
                                          'BI',                       -- Direccionalidad
                                          TBL_DATOS (NUINDICE).CATEGORIA, -- Identificador del estrato socioeconomico GE_SOCIOECO_STRATUM
                                                  tbl_datos (nuindice).subcategoria,
                                                  -1, -- ID de la distribucci¿n admin GE_DISTRIBUT_ADMIN
                                                  tbl_datos (nuindice).medidor,                               -- Medidor
                                                  NULL,                   -- Predio  IF_BUILDING
                                          NULL, -- Id de la ruta de asignaci¿n IM_ASSIGN_ROUTES
                                          nucomponentepapa,               -- ID del componente padre
                                          null,   -- Identificador del distrito IF_DISTRICT
                                          'N',         -- Es incluido "S" = Si, "N" = No
                                          dire, -- Identificador de la direcci¿n AB_ADDRESS
                                          LOCAHOMO, -- Identificador de la ubicaci¿n geografica GE_GEOGRA_LOCATION -- SELECT geograp_location_id, description FROM GE_GEOGRA_LOCATION
                                                  BARHOMO,                -- Identificador del barrio
                                                  DIRPARS,              -- Direcci¿n
                                          tbl_datos (nuindice).sesunuse,     -- Identificador del producto Origen
                                          NULL,        -- Identificador de los incluidos,
                                                  tbl_datos (nuindice).ESTADO,   --- ESTADO DEL COMPONENTE DEL PRODUCTO 5 = ACTIVO, 8 = SUSPENDIDO Y 9 = RETIRADO,
                                          'N',
                                          onuComponentId,           -- Id del componente
                                          nuErrorCode,
                                          sbErrorMessage);
              vcontLec := vcontLec + 1;
          end if;
          vfecha_fin := SYSDATE;
          if nuErrorCode is null then
                     vcontIns := vcontIns + 1;
                     COMMIT;
          else
                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
          end if;
         EXCEPTION
             WHEN OTHERS THEN
                BEGIN
                   NUERRORES := NUERRORES + 1;
                   PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                END;
          END;
      END LOOP;
      EXIT WHEN cuSuscripcinst%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuSuscripcinst%ISOPEN)
   THEN
      --{
      CLOSE cuSuscripcinst;
   --}
   END IF;  
   
   -- CREA LOS PR_COMPONENT DE BRILLAS Y MICROSEGUROS
   OPEN cuSuscripcSEGbri;
   LOOP
       --
       -- Borrar tablas     tbl_datos.
       --
       tbl_datosS.delete;
       FETCH cuSuscripcSEGbri
       BULK COLLECT INTO tbl_datosS
       LIMIT 1000;
       FOR nuindice IN 1 .. tbl_datosS.COUNT LOOP
           BEGIN
                nuErrorCode := NULL;
            sbErrorMessage := NULL;
                onuComponentId := null;
             NUCOMPONENTEPAPA := NULL;
                nuProducto := tbl_datosS (nuindice).product_id;
                select susciddi into dire from suscripc where susccodi=tbl_datosS (nuindice).subscription_id;
                select  geograp_location_id,address_parsed, neighborthood_id
                        into locahomo ,    dirpars ,    barhomo
                        from ab_address where ADDRESS_ID=dire;
                GSI_MIG_RegistraComponentes (tbl_datosS (nuindice).product_id,      -- Identificador del producto PR_PRODUCT
                                             tbl_datosS (nuindice).tipo1,         -- Tipo de componente PS_COMPONENT_TYPE
                                             NULL,                                -- Clase de servicio PS_CLASS_SERVICE
                                             tbl_datosS (nuindice).product_id,      -- NUmero de servicio
                                             sysdate,                             -- Fecha de inicio de prestaci¿n del servicio
                                             to_date('31/12/4732', 'dd/mm/yyyy'), -- Fecha de retiro
                                             1,                                   -- Cantidad
                                             0,                                   -- Dias de gracia
                                             'BI',                                -- Direccionalidad
                                             TBL_DATOSS (NUINDICE).CATEGORIA,     -- Identificador del estrato socioeconomico GE_SOCIOECO_STRATUM
                                             tbl_datosS (nuindice).subcategoria,
                                             -1,                                  -- ID de la distribuccion admin
                                             NULL,                                -- Medidor
                                             NULL,                                -- Predio  IF_BUILDING
                                             NULL,                                -- Id de la ruta de asignaci¿n IM_ASSIGN_ROUTES
                                             NULL,                                -- ID del componente padre
                                             null,                                -- Identificador del distrito IF_DISTRICT
                                             'N',                                 -- Es incluido "S" = Si, "N" = No
                                             dire,                                -- Identificador de la direcci¿n AB_ADDRESS
                                             LOCAHOMO,                            -- Identificador de la ubicaci¿n geografica GE_GEOGRA_LOCATION
                                             BARHOMO,                             -- Identificador del barrio
                                             DIRPARS,                             -- Direccion
                                             tbl_datosS (nuindice).product_id,     -- Identificador del producto Origen
                                             NULL,        -- Identificador de los incluidos
                                             tbl_datosS (nuindice).ESTADO,   --- ESTADO DEL PRODUCTO 5 = ACTIVO, 8 = SUSPENDIDO Y 9 = RETIRADO,
                                             'Y',
                                             onuComponentId,           -- Id del componente
                                             nuErrorCode,
                                             sbErrorMessage);
         if nuErrorCode is null then
                    vcontIns := vcontIns + 1;
                    COMMIT;
         else
                    NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
         end if;
         vfecha_fin := SYSDATE;
             EXCEPTION
                 WHEN OTHERS THEN
                      BEGIN
                           NUERRORES := NUERRORES + 1;
                           PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                      END;
             END;
         END LOOP;
         EXIT WHEN cuSuscripcSEGbri%NOTFOUND;
   END LOOP;
   -- Cierra CURSOR.
   IF (cuSuscripcSEGbri%ISOPEN)    THEN
      --{
      CLOSE cuSuscripcSEGbri;
      --}
   END IF;
   --- Termina log
   PKLOG_MIGRACION.PRINSLOGMIGRA ( 162,162,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
   update migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=162 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   commit;
  EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 162,162,2,vprograma||vcontIns,0,0,'Componente : '||NUPRODUCTO||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
END PRCOMPONENTmigr; 
/
