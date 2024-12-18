CREATE OR REPLACE PROCEDURE      "PRPRODUCTMGR" (NUMINICIO number, numFinal number ,pbd number)  AS
  /*******************************************************************
 PROGRAMA            :    PRPRODUCTmgr
 FECHA            :    15/05/2014
 AUTOR            :    VICTOR HUGO MUNIVE ROCA
 DESCRIPCION        :    Migra la informacion de SERVSUSC A PR_PRODUCT
 HISTORIA DE MODIFICACIONES
 AUTOR       FECHA    DESCRIPCION
 *******************************************************************/
   nuComplementoPR   number;
   nuComplementoSU   number;
   nuComplementoFA   number;
   nuComplementoCU   number;
   nuComplementoDI  number;
   nuErrorCode      NUMBER;
   sbErrorMessage   VARCHAR2 (4000);
   nuproduct_id     PR_Product.product_id%TYPE;
   vfecha_ini             DATE;
   vfecha_fin             DATE;
   vprograma              VARCHAR2 (100);
   vcontLec               NUMBER := 0;
   vcontIns               NUMBER := 0;
   VERROR                 VARCHAR2 (4000);
   dtFEcha                date;
   NUROL                  NUMBER := 0;
   NUCLIENTE              NUMBER := 0;

   Cursor cuSuscripc
       IS
   select /*+ NOPARALLEL  */
          b.sesunuse+nuComplementoPR sesunuse,
          b.sesususc+nuComplementoSU sesususc,
          E.SERVHOMO SERVICIO,
          V.CICLHOMO CICLHOMO,
          b.SESUFEIN,
          b.SESUNUCP,
          b.SESUSAFA,
          b.sesunusa,
          DECODE(ISNUMBER(A.SUSCTELE),1,TO_NUMBER(A.SUSCTELE),NULL)  TELEFONO,
          F.PLSUHOMO PLANSUSC,
          G.ESTRHOMO SUBCATEGORIA,
          G.CATEHOMO CATEGORIA,
          a.suscnice,
      O.PREDHOMO PREDHOMO,
      H.OSF_ESTADO_PRODUC estado,
        H.OSF_ESTADO_FINANCR SESUESFN,
          H.OSF_ESTADO_CORTE ESTADO_CORTE
          FROM LDC_TEMP_SUSCRIPC_sge A, LDC_TEMP_SERVSUSC_sge B, SUSCRIPC D,
               LDC_MIG_SERVICIO E, LDC_MIG_PLANSUSC F,
           LDC_MIG_SUBCATEG G, LDC_ESTADOS_SERV_HOMO  H,LDC_MIG_CICLO V ,
           LDC_MIG_DIRECCION O
          where A.SUSCCICL = V.CODICICL and v.database= a.basedato AND a.BASEDATO =  pbd and
                b.basedato =  pbd AND
                A.SUSCCODI =  B.SESUSUSC and
                b.sesuserv =  e.CODISERV AND
                D.SUSCCODI =  A.SUSCCODI+nucomplementosu AND
                b.sesuplsu =  F.CODIPLSU AND
                A.SUSCCODI >= NUMINICIO AND
                A.SUSCCODI <  NUMFINAL and
                f.basedato =  pbd AND
                o.database = b.basedato AND
                o.PREDCODI = b.SESUPRED AND
                G.CODICATE =  B.SESUCATE AND
                G.CODISUCA =  B.SESUSUCA AND
                H.ESTADO_TECNICO = B.SESUESTE AND
                H.ESTADO_FINANCI = B.SESUESFI;
  -- DECLARACION DE TIPOS.
  --
   TYPE tipo_cu_datos IS TABLE OF cuSuscripc%ROWTYPE;
  -- DECLARACION DE TABLAS TIPOS.
   --
   tbl_datos      tipo_cu_datos := tipo_cu_datos ();
--- Control de errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;
BEGIN
   update migr_rango_procesos set raprfein=sysdate,RAPRTERM='P' where raprcodi=158 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
   COMMIT;
   
    pkg_constantes.COMPLEMENTO(pbd,nuComplementoPR,nuComplementoSU,nuComplementoFA,nuComplementoCU,nuComplementoDI);
      
    VPROGRAMA := 'PRPRODUCTmgr';
    vfecha_ini := SYSDATE;
    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (158,158,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);
    -- Extraer los datos
    OPEN cuSuscripc;
    LOOP
        --
    -- Borrar tablas     tbl_datos.
        --
        tbl_datos.delete;
        FETCH cuSuscripc
        BULK COLLECT INTO tbl_datos
        LIMIT 1000;
        NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;
    FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
            BEGIN
         nuErrorCode := NULL;
         SBERRORMESSAGE := NULL;
                 NUCLIENTE := tbl_datos (nuindice).sesunuse;
                 IF tbl_datos (nuindice).SERVICIO=6121 THEN
                    IF PBD=1 OR PBD=2 OR PBD=3 THEN
                       tbl_datos (nuindice).plansusc:=12;
                    END IF;
                    IF PBD=5 THEN
                       tbl_datos (nuindice).plansusc:=20;
                    END IF;
                    IF PBD=4 THEN
                       tbl_datos (nuindice).plansusc:=10;
                    END IF;
                 END IF;
         GSI_MIG_RegistraProducto (tbl_datos (nuindice).sesunuse,
                                           tbl_datos (nuindice).sesususc,           -- Codigo del contrato SUSCRIPC
                                           tbl_datos (nuindice).SERVICIO,           -- Tipo de producto SERVICIO
                                           tbl_datos (nuindice).CATEGORIA,          -- Estado del producto  PS_PRODUCT_STATUS
                                           tbl_datos (nuindice).SUBCATEGORIA,
                                           tbl_datos (nuindice).ESTADO,             -- Estado del producto  PS_PRODUCT_STATUS
                                           tbl_datos (nuindice).sesunuse,           -- Numero de servicio
                                           sysdate,                                 -- Fecha de creacion
                                           to_date('31/12/4732', 'dd/mm/yyyy'),     -- Fecha de Retiro
                                   tbl_datos (nuindice).plansusc,           -- ID del plan comercial  CC_COMMERCIAL_PLAN
                                           1,                                       -- ID del vendedor GE_PERSON
                                           1,                                       -- ID del area organizacional GE_ORGANIZAT_AREA
                                           NULL,
                                           tbl_datos (nuindice).PREDHOMO,           -- ID de la direccion  AB_ADDRESS
                                           tbl_datos (nuindice).CICLHOMO,           -- Ciclo de Consumo CICLCONS
                                           null,                                    -- Multifamiliar
                                           tbl_datos (nuindice).CICLHOMO,           -- Ciclo de Facturaci¿n CICLO
                                           TBL_DATOS (NUINDICE).SESUFEIN,           -- Fecha de Instalaci¿n
                                           TBL_DATOS (NUINDICE).PLANSUSC,           -- tbl_datos (nuindice).plansusc,
                                           TBL_DATOS (NUINDICE).ESTADO_CORTE,       -- tbl_datos (nuindice).estacort,
                                           NULL,                                    -- Fecha de suspension
                                           NULL,                                    -- Fecha del ultimo cambio de contrato
                                           tbl_datos (nuindice).SESUNUCP,           -- Numero de COnsumos promedios
                                           tbl_datos (nuindice).SESUnusa,           -- Total de sanciones
                                           1,                                       -- Perfil de fraude  LE_PERFFRAU
                                           NULL,                                    -- Rol de garantia
                                           tbl_datos (nuindice).SESUSAFA,           -- Saldo a favor
                                           NULL,                                    -- Ultimo Periodo De Facturacion
                                           null,                                    -- colecct distribucion
                                           TBL_DATOS (NUINDICE).SESUESFN,
                                           SYSDATE,                                 -- Fecha de la ultima actualizacion
                                           2 ,                                      -- Rol del suscriptor
                                           nuErrorCode,
                                           sbErrorMessage);
                 vcontLec := vcontLec + 1;
                 vfecha_fin := sysdate;
                 if nuErrorCode is null then
                VCONTINS := VCONTINS + 1;
             /*       IF TBL_DATOS (NUINDICE).CATEGORIA = 3 THEN
                       UPDATE SUSCRIPC
                              SET SUSCRIPC.SUSCCEMD = 24,
                                  SUSCRIPC.SUSCCOEM = 24
                              WHERE SUSCCODI = TBL_DATOS (NUINDICE).SESUSUSC;
                    end if;   */
         else
                    NUERRORES := NUERRORES + 1;
                    PKLOG_MIGRACION.prInsLogMigra ( 158,158,2,vprograma||vcontIns,tbl_datos (nuindice).sesunuse,0,'Cliente : '||nuCliente||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);
         end if;
          EXCEPTION
           WHEN OTHERS THEN
              BEGIN
                 NUERRORES := NUERRORES + 1;
                 PKLOG_MIGRACION.prInsLogMigra ( 158,158,2,vprograma||vcontIns,tbl_datos (nuindice).sesunuse,0,'Cliente : '||nuCliente||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
              END;
        END;
      END LOOP;
      COMMIT;
      EXIT WHEN cuSuscripc%NOTFOUND;
   END LOOP;
    -- Cierra CURSOR.
   IF (cuSuscripc%ISOPEN)
   THEN
      --{
      CLOSE cuSuscripc;
   --}
   END IF;
  --- Termina log
    update migr_rango_procesos set raprfefi=sysdate,raprterm='T' where raprcodi=158 and raprbase=pbd and raprrain=numinicio and raprrafi=NUMFINAL;
     COMMIT;
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 158,158,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);
  EXCEPTION
     WHEN OTHERS THEN
        BEGIN
           NUERRORES := NUERRORES + 1;
            PKLOG_MIGRACION.prInsLogMigra ( 158,158,2,vprograma||vcontIns,0,0,'Cliente : '||nuCliente||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);
        END;
  END PRPRODUCTmgr; 
/
