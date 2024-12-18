CREATE OR REPLACE PROCEDURE      PR_MEDIVIEJOS (NUMINICIO NUMBER,NUMFINAL NUMBER,inubasedato number)AS
   /*******************************************************************
 PROGRAMA        :    pr_mediviejos
 FECHA            :    29/10/2013
 AUTOR            :    OLSOFTWARE
 DESCRIPCION    :    Migra la informacion de los medidores a Elemmedi, ge_items_seriado, pro_component, elmesesu
                De aquellos medidores que estan asociados a las lecturas y no estan asociados a ningun usuario migrado

 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION

 *******************************************************************/
   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   vfecha_ini          DATE;
   VFECHA_FIN          DATE;
   vprograma           VARCHAR2 (100);
   verror              VARCHAR2 (4000);
   vcont               NUMBER;
    vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   sbMedidor          varchar2(50);
   bd number;
   cursor cuElemmedi (bd number)
       is
   SELECT UPPER(a.MEDINUSE) ELMECODI, -- falta homologacion de la marca
              1          ELMECLEM,  -- Cambio de acuerdo reunion OPEN 10-12-2012 antes era nulo
              7 ELMENUDC,
              1            ELMEUIEM,
              case
                  when a.MEDITIEN = 'D' then 1
                    when a.MEDITIEN = 'I' then 2
                  else  1
              end      ELMEPOSI,
                  1         ELMEFACM,
                  1         ELMEFACD,
              power(10,7)-1  ELMETOPE,
              NULL         ELMEEMAC,
          4001229  ITEMS_ID,
              UPPER(A.MEDINUSE)    SERIE,
              'N'           ESTADO_TECNICO,
          8    ID_ITEMS_ESTADO_INV,
          0         COSTO,
          0                SUBSIDIO,
          'C'            PROPIEDAD,
               case
              when c.sesufeco is not null then c.sesufeco
              else  
                case
                 when c.sesufein is not null  then c.sesufein
                 else 
                    sysdate-60
                end              
          end       FECHA_INGRESO,
          NULL            FECHA_SALIDA,
          NULL            FECHA_REACON,
          NULL            FECHA_BAJA,
          a.MEDIEGEM    FECHA_GARANTIA,
          NULL          OPERATING_UNIT_ID,
               C.SESUNUSE +nucomplementopr NUMERO_SERVICIO,
                pkbcsuscripc.fnugetsubscriberid(c.SESUSUSC+Nucomplementosu) Subscriber_Id,
                c.SESUSUSC+NUCOMPLEMENTOSU sesususc
     From Ldc_Temp_Medidor_sge A,  Ldc_Temp_Servsusc_sge C,
             LDC_MIG_mediviejos v
    WHERE A.MEDINUSE <> '-----------'
      AND A.MEDINUSE = v.MEDI
      and v.nuse=c.sesunuse
      AND  c.sesususc >= NUMINICIO
      AND c.sesususc < NUMFINAL
      and v.basedato= A.BASEDATO
    and c.sesuserv = 1
      AND A.BASEDATO =  C.Basedato
      And C.Basedato = bd
      and not exists (select 1 from elmesesu where emsssesu=c.sesunuse+NUCOMPLEMENTOPR and emsscoem=A.MEDINUSE);

     -- DECLARACION DE TIPOS.
   --
   TYPE tipo_cu_datos IS TABLE OF cuElemmedi%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
   
   -- Obtiene los atributos no requeridos de los tipos de item
    CURSOR cuMedidorProvisional(sbSerie varchar, nuBD number)
    IS
        SELECT count(DISTINCT hiprnuse) Existe
        FROM LDC_TEMP_HISTPROV
        WHERE hiprnuse = sbSerie
        AND BASEDATO = nuBD;

    rgProvisional cuMedidorProvisional%rowtype;
   
--- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0; 
   cate number;
   suca number;
   locahomo ab_address.geograp_location_id%type;
   dirpars ab_address.address_parsed%type;
   barhomo ab_address.neighborthood_id%type;
   dire ab_address.address_id%type;   
   nucomponentepapa NUMBER;
   nuErrorCode       NUMBER;
   sbErrorMessage    VARCHAR2 (4000);
   onuComponentId   pr_component.component_id%TYPE;
   IDCO NUMBER;
   CME NUMBER;
   fere date;
   codimedi elemmedi.ELMEIDEM%type;
   sbsql varchar2(800);
   maxnumber number;
   nuOperatingUnit  number := 173;
   sbValueProvisional VARCHAR2(2);
   
BEGIN

   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='P', RAPRFEIN=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=801;
   commit;
   /* se coloca esto para que no vaya a crear doble pr_component a los medidores que venian con minusculas */
   update ldc_temp_lectura set lectmedi=upper(lectmedi); 
   commit;
   
   
   
   --delete from log_migracion where lomiproc=801;
   vprograma:='PR_MEDIVIEJOS';
   PKLOG_MIGRACION.prInsLogMigra (801,801,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
   
   pkg_constantes.Complemento(inubasedato,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);


  -- dbms_output.put_line('voy a recorrer cursor de cali');
   OPEN cuElemmedi(inubasedato);

   LOOP
      --
        -- Borrar tablas     tbl_datos.
      --
      tbl_datos.delete;

        FETCH cuElemmedi
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;
      
      NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;


        FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
       
        BEGIN
            vcontLec := vcontLec + 1;
              sbMedidor := tbl_datos ( nuindice).ELMECODI;
    --        dbms_output.put_line('usuario '||to_char(tbl_datos ( nuindice).NUMERO_SERVICIO)||' medidor: '||tbl_datos ( nuindice).ELMECODI);
                vcont := Open.SQELEMMEDI.NEXTVAL;
            /* CREA EL ELEMMEDI */
            select count(1) into cme from elemmedi where elmecodi=tbl_datos ( nuindice).ELMECODI;
            if cme=0 then
               INSERT INTO ELEMMEDI (ELMEIDEM, ELMECODI, ELMECLEM, ELMENUDC, ELMEUIEM,
                                      ELMEPOSI, ELMEFACM, ELMEFACD, ELMETOPE, ELMEEMAC)
                         VALUES (vcont, tbl_datos ( nuindice).ELMECODI, tbl_datos ( nuindice).ELMECLEM,
                                           tbl_datos ( nuindice).ELMENUDC, tbl_datos ( nuindice).ELMEUIEM, tbl_datos ( nuindice).ELMEPOSI,
                                           tbl_datos ( nuindice).ELMEFACM, tbl_datos ( nuindice).ELMEFACD, tbl_datos ( nuindice).ELMETOPE,
                                           tbl_datos ( nuindice).ELMEEMAC);
              codimedi:=vcont;
            else
               if cme=1 then
                  select elmeidem into codimedi from elemmedi where elmecodi=tbl_datos ( nuindice).ELMECODI;
               end if;
            end if;
            
      --      dbms_output.put_line('creado elemmedi # '||to_number(vcont));
            /* CREA EL ITEM SERIADO */
            SELECT COUNT(1) INTO CME FROM  GE_ITEMS_SERIADO WHERE SERIE=tbl_datos ( nuindice).ELMECODI;
            IF CME=0 THEN
                   INSERT INTO GE_ITEMS_SERIADO (ID_ITEMS_SERIADO, ITEMS_ID, SERIE, ESTADO_TECNICO, ID_ITEMS_ESTADO_INV, COSTO,
                                        SUBSIDIO, PROPIEDAD, FECHA_INGRESO, FECHA_SALIDA, FECHA_REACON, FECHA_BAJA,
                                        FECHA_GARANTIA, OPERATING_UNIT_ID, NUMERO_SERVICIO, SUBSCRIBER_ID)
                                  VALUES (vcont, tbl_datos ( nuindice).ITEMS_ID, tbl_datos ( nuindice).SERIE, 'N',
                                                8, tbl_datos ( nuindice).COSTO, tbl_datos ( nuindice).SUBSIDIO,
                                                    tbl_datos ( nuindice).PROPIEDAD, tbl_datos ( nuindice).FECHA_INGRESO, tbl_datos ( nuindice).FECHA_SALIDA,
                                                   tbl_datos ( nuindice).FECHA_REACON, tbl_datos ( nuindice).FECHA_BAJA, tbl_datos ( nuindice).FECHA_GARANTIA,
                                        tbl_datos ( nuindice).OPERATING_UNIT_ID, null, null);
        --      dbms_output.put_line('creado el items seriado');
              /* LLENA ATRIBUTOS DEL ITEM SERIADO */
       
              Insert Into Ge_Items_Tipo_At_Val    (Id_Items_Tipo_At_Val, Id_Items_Tipo_Atr, Items_Id, Id_Items_Seriado, Valor)
                  Values (Seq_Ge_Items_Tipo_At_Val.Nextval, 1000037, Tbl_Datos ( Nuindice).Items_Id, Vcont, Tbl_Datos ( Nuindice).Elmetope );

              Insert Into Ge_Items_Tipo_At_Val    (Id_Items_Tipo_At_Val, Id_Items_Tipo_Atr, Items_Id, Id_Items_Seriado, Valor)
                  Values (Seq_Ge_Items_Tipo_At_Val.Nextval, 1000031, Tbl_Datos ( Nuindice).Items_Id, Vcont, 1 );
                  
              -----------------
                /*
                OPEN cuMedidorProvisional(tbl_datos(nuindice).SERIE,1);
                FETCH cuMedidorProvisional INTO rgProvisional;
                CLOSE cuMedidorProvisional;

                IF rgProvisional.Existe > 0 THEN
                    sbValueProvisional := 'S';

                    -- Como es medidor provisional, se le asocia la unidad operativa 173 Servicios e Ingenieria
                    UPDATE GE_ITEMS_SERIADO SET OPERATING_UNIT_ID = nuOperatingUnit WHERE ID_ITEMS_SERIADO = Vcont;
                    COMMIT;

                    -- Se actualiza el balance
                    IF (DAOR_ope_uni_item_bala.fblexist(Tbl_Datos(Nuindice).Items_Id,nuOperatingUnit))then
                        UPDATE or_ope_uni_item_bala SET balance = balance+1 WHERE operating_unit_id =nuOperatingUnit AND  items_id =Tbl_Datos(Nuindice).Items_Id;
                    ELSE
                        INSERT INTO or_ope_uni_item_bala VALUES (Tbl_Datos(Nuindice).Items_Id, nuOperatingUnit, 9999, 1, 0,null,null,null );
                    END if;
                    COMMIT;

                ELSE
                    sbValueProvisional := 'N';
                END IF;

                -- ES_PROVISIONAL
                Insert Into Ge_Items_Tipo_At_Val    (Id_Items_Tipo_At_Val, Id_Items_Tipo_Atr, Items_Id, Id_Items_Seriado, Valor)
                      Values (Seq_Ge_Items_Tipo_At_Val.Nextval, 1000219, Tbl_Datos(Nuindice).Items_Id, Vcont, sbValueProvisional);
                rgProvisional.Existe := 0;
            */
              -----------------

          --    dbms_output.put_line('creado los atributos del items seriado');
            ELSE
              CME:=5;
            --  dbms_output.put_line('YA ESTABA CREADO EL GE_ITEMS_SERIADO');
            END IF;
            
            /* BUSCA VALORES DE CATEGORIA Y SUBCATEGORIA PARA PODER CREAR EL COMPONENTE */
            select sesucate,sesusuca into cate,suca from servsusc where sesunuse=tbl_datos (nuindice).numero_servicio;
            
          --  dbms_output.put_line('trajo informacion del servicio suscrito (categoria y subcategoria');
            /* BUSCA INFORMACION DE LA DIRECCION DEL PRODUCTO */
            select susciddi into dire from suscripc where susccodi= tbl_datos (nuindice).SESUSUSC;
            select  geograp_location_id,address_parsed, neighborthood_id
                    into locahomo ,    dirpars ,    barhomo
                    from ab_address where ADDRESS_ID=dire;
          --  dbms_output.put_line('trajo informacion geografica para crear pr_component');        
            /* BUSCA EL COMPONENTE PADRE (EL 7038 CORRESPONDIENTE A ESE PRODUCTO */
            BEGIN
            SELECT COMPONENT_ID 
               INTO  nucomponentepapa 
              FROM PR_COMPONENT 
              WHERE PRODUCT_ID=tbl_datos (nuindice).numero_servicio AND 
                    COMPONENT_TYPE_ID=7038;    
            EXCEPTION
               WHEN OTHERS THEN
                    nucomponentepapa:=NULL;
            END;
          --  dbms_output.put_line('encontro componente padre');        
            onuComponentId:=NULL;  
        
            /* CREA EL PR_COMPONENT */
            GSI_MIG_RegistraComponentes (tbl_datos (nuindice).numero_servicio, 
                                        7039,  -- Tipo de componente PS_COMPONENT_TYPE  -
                                        3102,    -- Clase de servicio PS_CLASS_SERVICE
                                        tbl_datos (nuindice).numero_servicio,             -- N¿mero de servicio
                                        tbl_datos (nuindice).fecha_ingreso, -- Fecha de inicio de prestaci¿n del servicio
                                        sysdate,                 -- Fecha de retiro
                                        1,                                 -- CAntidad
                                        0,                           -- Di¿s de gracia
                                        'BI',                       -- Direccionalidad
                                        cate, -- Identificador del estrato socioeconomico GE_SOCIOECO_STRATUM
                                                        suca,
                                        -1, -- ID de la distribucci¿n admin GE_DISTRIBUT_ADMIN
                                        codimedi,                               -- Medidor
                                        NULL,                   -- Predio  IF_BUILDING
                                        NULL, -- Id de la ruta de asignaci¿n IM_ASSIGN_ROUTES
                                        nucomponentepapa,               -- ID del componente padre
                                        null,   -- Identificador del distrito IF_DISTRICT
                                        'N',         -- Es incluido "S" = Si, "N" = No
                                        dire, -- Identificador de la direcci¿n AB_ADDRESS
                                         LOCAHOMO, -- Identificador de la ubicaci¿n geografica GE_GEOGRA_LOCATION -- SELECT geograp_location_id, description FROM GE_GEOGRA_LOCATION
                                     BARHOMO,                -- Identificador del barrio
                                    DIRPARS,              -- Direcci¿n
                                        tbl_datos (nuindice).numero_servicio,     -- Identificador del producto Origen
                                        NULL,        -- Identificador de los incluidos,
                                                        9,   --- ESTADO DEL COMPONENTE DEL PRODUCTO 5 = ACTIVO, 8 = SUSPENDIDO Y 9 = RETIRADO,
                                        'N',
                                        onuComponentId,           -- Id del componente
                                        nuErrorCode,
                                        sbErrorMessage);
            --dbms_output.put_line('vine del api que crea el pr_component');        
            
            IF NUERRORCODE IS NULL THEN
              -- dbms_output.put_line('vine del api sin error');        
               /* BUSCA ID DEL COMPSESU RECIEN CREADO EN EL API */
        
               --SELECT CMSSIDCO INTO IDCO FROM COMPSESU WHERE CMSSSESU=tbl_datos (nuindice).numero_servicio AND CMSSESCM=9 AND Cmsstcom=7039;
               SELECT CMSSIDCO INTO IDCO FROM COMPSESU WHERE CMSSIDCO = onuComponentId;
               --dbms_output.put_line('traje informacion de compsesu recien creado'); 
               begin
                    select max(lectfech) into fere from ldc_temp_lectura_sge where lectmedi=tbl_datos ( nuindice).ELMECODI and lectcale=7;
               exception
                 when others then
                      fere:=tbl_datos (nuindice).fecha_ingreso;
              end;
              
              if fere IS null then
                  fere:=tbl_datos (nuindice).fecha_ingreso;
              END if;

              if IDCO IS not null then
                   /* INSERT EN ELMESESU */
                   INSERT INTO ELMESESU  (EMSSELME,EMSSCOEM,EMSSFEIN,EMSSFERE,EMSSCMSS,EMSSSESU,EMSSSERV,EMSSSSPR)
                               VALUES (codimedi, tbl_datos ( nuindice).ELMECODI, tbl_datos (nuindice).fecha_ingreso, fere,
                                       IDCO,tbl_datos (nuindice).numero_servicio, 7014, tbl_datos (nuindice).numero_servicio );
                  --dbms_output.put_line('inserte en elmesesu');
                   COMMIT;
               END if;
             --  dbms_output.put_line('hice commit');        
            else
             --  dbms_output.put_line('vine del api con error');        
               rollback;
            end if;


         EXCEPTION 
             WHEN OTHERS THEN
                BEGIN
                  
                   NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra ( 801,801,2,vprograma||vcontIns,0,0,'basedato: 1, nuse='||to_char(tbl_datos (nuindice).numero_servicio)||' Medidor : '||sbMedidor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                                 
                END;           
        
          END;
      END LOOP;

       COMMIT;

      EXIT WHEN cuElemmedi%NOTFOUND;

   END LOOP;

    -- Cierra CURSOR.
   IF (cuElemmedi%ISOPEN)
   THEN
      --{
      CLOSE cuElemmedi;
   --}
   END IF;

 --  COMMIT;
  
  --- Termina log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 801,801,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);

   UPDATE  MIGR_RANGO_PROCESOS SET RAPRTERM='T', RAPRFEFI=sysdate WHERE raprbase=inubasedato AND raprrain=NUMINICIO AND raprrafi=NUMFINAL AND raprcodi=801;
  EXCEPTION 
     WHEN OTHERS THEN
        BEGIN
          
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 801,801,2,vprograma||vcontIns,0,0,'Medidor : '||sbMedidor||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
                         
        END;           
          

  END pr_mediviejos; 
/
