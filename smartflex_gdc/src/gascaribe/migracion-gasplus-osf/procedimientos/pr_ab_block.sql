CREATE OR REPLACE procedure PR_AB_BLOCK(inubasedato number) AS
 /* ******************************************************************
 PROGRAMA    	: PR_AB_BLOCK
 FECHA		    :	30/03/2012
 AUTOR		    :
 DESCRIPCION	:	Migra la informacion de las manzanas de la tabla MANZCATA
                    de las bases de Datos GasPlus y GPNV. Dichas manzanas deben
                    deben estar ubicadas en barrios (zona-sector) ya homologados.

 HISTORIA DE MODIFICACIONES
 AUTOR	       FECHA     DESCRIPCION

 *******************************************************************/
    vfecha_ini          DATE;
    vfecha_fin          DATE;
    vprograma           VARCHAR2 (100);
    verror              VARCHAR2 (4000);
    vcontLec            NUMBER := 0;
    vcontIns            NUMBER := 0;
    nuErrorCode         NUMBER := NULL;
    nuContador          number(10) := 0;
    sbErrorMessage      VARCHAR2 (4000) := NULL;
    blError             boolean := false;
    nuSinonimo          number := 0;
    sbManzana           varchar2(25) := NULL;
	nuPaso              number := null;

    -- Cursor con los datos de origen
    CURSOR cuManzana
        IS
      SELECT *
        From --manzcata@gdo_dbtest a, -- Manzanas Catastrales DBTEST
             migra.LDC_TEMP_manzcata_sge a,   -- Manzanas Catastrales QGASPLUS
             --manzcata@qgpnv a,    -- Manzanas Catastrales QGPNV
             Ldc_Mig_localidad B       -- Homologaci¿n de barrios
       WHERE A.BASEDATO = inubasedato
         AND a.macadepa = b.codidepa (+)
         and a.macaloca = b.codiloca (+)
       --  AND to_char(a.macazoca||lpad(a.macaseca,2,0)) =  to_char(b.codibarr (+))
         --AND barrhomo is not null
       ORDER BY a.macadepa, a.macaloca, a.macazoca, a.macaseca, a.macacodi;

    -- Cursor Consecutivo_id AB_BLOCK
    cursor cuConsecutivo
           is
        select nvl(max(BLOCK_ID),0)+1
          from AB_BLOCK;

    -- DECLARACION DE TIPOS.
    TYPE tipo_cu_datos IS TABLE OF cuManzana%ROWTYPE;

    -- DECLARACION DE TABLAS TIPOS.
    tbl_datos      tipo_cu_datos := tipo_cu_datos ();

    --- Control de Errores
   nuLogError NUMBER;
   NUTOTALREGS NUMBER := 0;
   NUERRORES NUMBER := 0;

BEGIN
    vprograma := 'AB_BLOCK';
    vfecha_ini := SYSDATE;

    -- Inserta registro de inicio en el log
    PKLOG_MIGRACION.prInsLogMigra (139,139,1,vprograma,0,0,'Inicia Proceso','INICIO',nuLogError);


    -- Extraer Datos y cargarlos
    -- nuContador := 1;
    blError := False;
    nuErrorCode := NULL;
    sbErrorMessage := null;



    OPEN cuManzana;
    LOOP
       -- Borrar tabla tbl_datos.
       --
       tbl_datos.delete;

       FETCH cuManzana
       BULK COLLECT INTO tbl_datos
       LIMIT 1000;

       NUTOTALREGS := NUTOTALREGS + TBL_DATOS.COUNT;

       FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
          BEGIN
            blError := False;
            nuErrorCode := NULL;
            sbErrorMessage := null;
            sbManzana := tbl_datos (nuindice).macadepa||'-'||tbl_datos (nuindice).macaloca||'-'||tbl_datos (nuindice).macazoca||'-'||
                         tbl_datos (nuindice).macaseca||'-'||tbl_datos (nuindice).macacodi;
            vcontLec := vcontLec + 1;
            nupaso := null;
           -- if tbl_datos (nuindice).barrhomo is not null then
        BEGIN
				    NUCONTADOR := SEQ_AB_BLOCK.NEXTVAL;
            BEGIN
              INSERT INTO MANZANAS (MANZDEPA, MANZLOCA, MANZZONA, MANZSECT, MANZCODI, MANZPRIN, MANZPRFI, MANZNOPR,
                                              MANZTLIN, MANZPEAT, MANZVIAS)
                          VALUES(tbl_datos (nuindice).depahomo, tbl_datos (nuindice).COLOHOMO, tbl_datos (nuindice).macazoca,
                             tbl_datos (nuindice).macaseca, tbl_datos (nuindice).macacodi, tbl_datos (nuindice).macaprin, tbl_datos (nuindice).macaprfi,
                         tbl_datos (nuindice).macanupr,0,0, null);

              INSERT INTO AB_BLOCK (BLOCK_ID, GEOGRAP_LOCATION_ID, ZONE, SECTOR, BLOCK_,
                                              PREMISE_AMOUNT, DESCRIPTION, INITIAL_PREMISE, FINAL_PREMISE)
                             VALUES (nuContador, tbl_datos (nuindice).COLOHOMO, tbl_datos (nuindice).macazoca, tbl_datos (nuindice).macaseca, tbl_datos (nuindice).macacodi,
                                     tbl_datos (nuindice).macanupr, NULL, tbl_datos (nuindice).macaprin, tbl_datos (nuindice).macaprfi);

              EXCEPTION
               WHEN OTHERS THEN
                  BEGIN

                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 139,139,2,vprograma||vcontIns,0,0,'Manzana : '||sbManzana||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                  END;
              END;

                    vcontIns := vcontIns + 1;
					           NUPASO := 2;

					           BEGIN
                        INSERT INTO LDC_MIG_MANZCATA (CODIDEPA, CODILOCA, CODIZOCA, CODISECA, CODIMACA, MANZHOMO, DEPAHOMO, LOCAHOMO, BARRHOMO)
                             VALUES (tbl_datos (nuindice).macadepa, tbl_datos (nuindice).macaloca, tbl_datos (nuindice).macazoca,
                                     tbl_datos (nuindice).macaseca, tbl_datos (nuindice).macacodi, nucontador, tbl_datos (nuindice).depahomo,
                                     tbl_datos (nuindice).COLOHOMO, -1);
                        commit;
                        EXCEPTION
                         WHEN OTHERS THEN
                            BEGIN

                               NUERRORES := NUERRORES + 1;
                               PKLOG_MIGRACION.prInsLogMigra ( 139,139,2,vprograma||vcontIns,0,0,'Manzana : '||sbManzana||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                            END;
                        END;

            EXCEPTION
               WHEN OTHERS THEN
                  BEGIN

                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 139,139,2,vprograma||vcontIns,0,0,'Manzana : '||sbManzana||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                  END;
              END;


            if (blerror) then
                --- Insertar en el Log de Errores
                if nuErrorCode = 1 then
                    sbErrorMessage := 'Error al insertar en LDC_MIG_MANZCATA. Registro C : '||sbErrorMessage;
                elsif nuErrorCode = 2 then
                    sbErrorMessage := 'Error al insertar en AB_BLOCK. Registro C : '||sbErrorMessage;
                else --nuErrorCode = 3
                    sbErrorMessage := 'Manzana con barrio(zona-sector) no registrado en Smartflex. Registro C : '||sbManzana;
                end if;

                NUERRORES := NUERRORES + 1;
                PKLOG_MIGRACION.prInsLogMigra ( 139,139,2,vprograma||vcontIns,0,0,'Manzana : '||sbManzana||' - Error: '||sbErrorMessage,to_char(nuErrorCode),nuLogError);

            end if;

          EXCEPTION
               WHEN OTHERS THEN
                  BEGIN

                     NUERRORES := NUERRORES + 1;
                     PKLOG_MIGRACION.prInsLogMigra ( 139,139,2,vprograma||vcontIns,0,0,'Manzana : '||sbManzana||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

                  END;
              END;

        END LOOP;
        vfecha_fin := SYSDATE;

		   COMMIT;

        EXIT WHEN cuManzana%NOTFOUND;

    END LOOP;

    -- Cierra CURSOR.
    IF (cuManzana%ISOPEN) THEN
        CLOSE cuManzana;
    END IF;

    vfecha_fin := SYSDATE;

    -- Termina Log
    PKLOG_MIGRACION.PRINSLOGMIGRA ( 139,139,3,VPROGRAMA,NUTOTALREGS,NUERRORES,'TERMINO PROCESO #regs: '||VCONTINS,'FIN',NULOGERROR);


EXCEPTION
 WHEN OTHERS THEN
    BEGIN

       NUERRORES := NUERRORES + 1;
       PKLOG_MIGRACION.prInsLogMigra ( 139,139,2,vprograma||vcontIns,0,0,'Manzana : '||sbManzana||' - Error: '||sqlerrm,to_char(sqlcode),nuLogError);

    END;


  END PR_AB_BLOCK; 
/
