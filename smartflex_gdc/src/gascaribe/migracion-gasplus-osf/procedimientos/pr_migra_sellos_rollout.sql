CREATE OR REPLACE PROCEDURE PR_MIGRA_SELLOS_ROLLOUT (nuInicio number, nuFinal number, nuBD number) AS 
/*******************************************************************
 PROGRAMA    	:	PR_MIGRA_SELLOS_ROLLOUT
 FECHA		:	15/05/2014
 AUTOR		:	OLSoftware
 DESCRIPCION	:	Migra la informacion de Sellos a GE_ITEMS_SERIADOS	
 HISTORIA DE MODIFICACIONES
 AUTOR	   FECHA	DESCRIPCION

 *******************************************************************/

    CURSOR cuSellos
    IS
    SELECT /*+ parallel */
      A.INSETISE,
      -1 ITEMS_ID,
      CASE
        WHEN A.INSEPREF = 'OP' THEN A.INSEPREF||A.INSENUSE
        ELSE
        A.INSENUSE
      END SERIE,
      A.INSEFECH FECHA,
      A.INSEUBIC,
      A.INSESEME MEDIDOR,
      A.INSEESTA,
      B.CUADHOMO UNIDAD_OPERATIVA,
      A.INSEPREF,
      A.INSEMANI
      FROM LDC_TEMP_INVSELLO_SGE A, LDC_MIG_CUADCONT B
      WHERE (A.INSENUSE,A.INSEFECH) in (SELECT INSENUSE, max(INSEFECH)
                                    FROM LDC_TEMP_INVSELLO_SGE
                                    GROUP BY INSENUSE)
      AND A.INSECOCO = B.CUADCODI
      AND A.BASEDATO = B.BASEDATO
      AND A.BASEDATO = nuBD;
      --AND INSEESTA in ('ECO','INS'); DEBEN DEFINIR QUÃ¿¡ ESTADOS MIGRAR
      
     TYPE tipo_cu_datos IS TABLE OF cuSellos%ROWTYPE;
     
     tbl_datos      tipo_cu_datos := tipo_cu_datos ();
          
    -- Se obtiene el medidor al que esta asociado
    CURSOR cuItemSeriado(sbSerie    VARCHAR2)
    IS
        SELECT *
        FROM GE_ITEMS_SERIADO
        WHERE SERIE = sbSerie;
     
    rgItemSerido         cuItemSeriado%rowtype;
    
    CURSOR cuUbicacion(sbTipoSello VARCHAR2, sbUbicacionSello VARCHAR2)
    IS
        SELECT DISTINCT UBSETISE,UBSECOUB,UBSEDESC
         FROM LDC_TEMP_UBISELLO_SGE
        WHERE UBSETISE = sbTipoSello
          AND UBSECOUB = sbUbicacionSello;

    rgUbicacion     cuUbicacion%rowtype;

    nuIdItemsSeriado    ge_items_seriado.id_items_seriado%type;
    nuOperatingUnit     or_operating_unit.operating_unit_id%type;
    nuNumeroServicio    ge_items_seriado.numero_servicio%type;
    nuSubscriberId      ge_items_seriado.subscriber_id%type;
    nuFlag              NUMBER := -1;
    nuIdItemSeriadoMed  ge_items_seriado.id_items_seriado%type;
    nuI                 NUMBER;
    nuEstadoSello       number;   -- 5 En Uso, 1 Disponible
    
    nuLogError 		NUMBER;
    nuTotalRegs 	number := 0;
    nuErrores 		number := 0;
    verror              VARCHAR2 (4000);
    vcont               NUMBER;
    sbsql 		varchar2(800);
    maxnumber 		number;
    nuExiste 		number;

BEGIN

   -- Se actualiza la secuencia de SEQ_GE_ITEMS_SERIADO al maximo de los ge_items_seriado

   BEGIN
   -- SECUENCIA SEQ_GE_ITEMS_SERIADO
    sbsql:='DROP SEQUENCE OPEN.SEQ_GE_ITEMS_SERIADO';

    execute immediate sbsql;

    SELECT max(id_items_seriado) + 1 INTO maxnumber FROM GE_ITEMS_SERIADO where id_items_seriado not in (999999999999999,999999);

    sbsql:=
    'CREATE SEQUENCE OPEN.SEQ_GE_ITEMS_SERIADO
      START WITH '||maxnumber||'
      MAXVALUE 9999999999999999999999999999
      MINVALUE 1
      NOCYCLE
      CACHE 20
      ORDER';

      execute immediate sbsql;
    END;

   PKLOG_MIGRACION.prInsLogMigra ( 501,501,1,'PR_MIGRA_SELLOS',nuTotalRegs,nuErrores,'INICIA PROCESO #regs: '||nuTotalRegs,'INICIA',nuLogError);

   update migr_rango_procesos set RAPRFEIN = SYSDATE, RAPRTERM = 'P' where RAPRCODI = 501 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;
   
   OPEN cuSellos;

   LOOP
      -- Borrar tablas PL.
      tbl_datos.delete;

      -- Cargar registros.
      FETCH cuSellos
      BULK COLLECT INTO tbl_datos
      LIMIT 1000;

      FOR nuI IN 1 .. tbl_datos.COUNT LOOP
         BEGIN
            
            -- Se valida si el sello ya esta asociado a un medidor
            IF  tbl_datos(nuI).MEDIDOR IS NOT NULL THEN

                /* Se abre el cursor cuItemSeriado*/
                OPEN cuItemSeriado(tbl_datos(nuI).MEDIDOR);
                FETCH cuItemSeriado INTO rgItemSerido;
                CLOSE cuItemSeriado;
                
                nuFlag := 1;
                nuIdItemSeriadoMed := rgItemSerido.id_items_seriado;

                IF rgItemSerido.numero_servicio IS NULL THEN
                
                   nuOperatingUnit := tbl_datos(nuI).UNIDAD_OPERATIVA;
                   nuNumeroServicio := null;
                   nuSubscriberId   := null;
                   nuEstadoSello := 1;
                   
                ELSE

                   nuOperatingUnit  := null;
                   nuNumeroServicio := rgItemSerido.numero_servicio;
                   nuSubscriberId   := rgItemSerido.subscriber_id;
                   nuEstadoSello := 5;
                   
                END IF;

            ELSE

                nuOperatingUnit := tbl_datos(nuI).UNIDAD_OPERATIVA;
                nuNumeroServicio := null;
                nuSubscriberId   := null;
                nuEstadoSello := 1;
            
            END IF;

            SELECT count(1) INTO nuExiste FROM GE_ITEMS_SERIADO WHERE serie = tbl_datos(nuI).SERIE;

            if nuExiste = 0 then
            
                nuIdItemsSeriado := SEQ_GE_ITEMS_SERIADO.nextval;
                -- Se inserta el item seriado
                INSERT INTO GE_ITEMS_SERIADO (ID_ITEMS_SERIADO, ITEMS_ID, SERIE, ESTADO_TECNICO, ID_ITEMS_ESTADO_INV, COSTO,
                                              SUBSIDIO, PROPIEDAD, FECHA_INGRESO, FECHA_SALIDA, FECHA_REACON, FECHA_BAJA,
                                              FECHA_GARANTIA, OPERATING_UNIT_ID, NUMERO_SERVICIO, SUBSCRIBER_ID)
                      VALUES (nuIdItemsSeriado, tbl_datos(nuI).ITEMS_ID, tbl_datos(nuI).SERIE, 'N',nuEstadoSello,0,0,
        					 'E', tbl_datos(nuI).FECHA, NULL, NULL, NULL, NULL, nuOperatingUnit, nuNumeroServicio, nuSubscriberId);


                OPEN cuUbicacion(tbl_datos(nuI).INSETISE, tbl_datos(nuI).INSEUBIC);
                FETCH cuUbicacion INTO rgUbicacion;
                CLOSE cuUbicacion;

                -- Se inserta la ubicacion
                INSERT INTO GE_ITEMS_TIPO_AT_VAL(ID_ITEMS_TIPO_AT_VAL,ID_ITEMS_TIPO_ATR,ITEMS_ID,ID_ITEMS_SERIADO,VALOR)
                        VALUES(Seq_Ge_Items_Tipo_At_Val.Nextval,1000042,tbl_datos(nuI).ITEMS_ID,nuIdItemsSeriado,rgUbicacion.UBSEDESC);

                -- Si el sello esta asociado un medidor se inserta en ge_asso_serial_items
                IF nuFlag = 1 THEN

                 INSERT INTO ge_asso_serial_items(ASSO_SERIAL_ITEMS_ID,SERIAL_ITEMS_ID)
                               VALUES(nuIdItemsSeriado,nuIdItemSeriadoMed);

                ELSE
		
			/*Se debe desactivar el trigger para poder actualizar o insertar en OR_OPE_UNI_ITEM_BALA*/
			EXECUTE IMMEDIATE 'ALTER TRIGGER OPEN.TRG_AUROR_OPE_UNI_ITEM_BALA DISABLE';
			
                  -- Si ya existe asociacion entre el item se actualiza el cupo, si no se inserta
                    IF (DAOR_ope_uni_item_bala.fblexist(tbl_datos(nuI).ITEMS_ID, nuOperatingUnit)) THEN
                        
                        UPDATE or_ope_uni_item_bala
                            SET balance = balance+1
                            WHERE operating_unit_id = nuOperatingUnit
                            AND  items_id =tbl_datos(nuI).ITEMS_ID;
                    ELSE
                      
                        INSERT INTO or_ope_uni_item_bala
                            VALUES (tbl_datos(nuI).ITEMS_ID, nuOperatingUnit, 9999, 1, 0,null,null,null );

                    END IF; --IF (DAOR_ope_uni_item_bala.fblexist(tbl_datos(nuI).ITEMS_ID, nuOperatingUnit)) THEN

                END IF;--IF nuFlag = 1 THEN
                
               COMMIT;
            END if;
            
         EXCEPTION
            WHEN OTHERS THEN
			      BEGIN
                    verror := 'Error en el sello : '||tbl_datos(nuI).SERIE ||' - '|| SQLERRM;
                    nuErrores := nuErrores + 1;
                    PKLOG_MIGRACION.prInsLogMigra ( 501,501,2,'PR_MIGRA_SELLOS',0,0,'Error: '||verror,to_char(sqlcode),nuLogError);
			      END;
         END;
      END LOOP;
      
      EXIT WHEN cuSellos%NOTFOUND;

      COMMIT;
   END LOOP;
   
   IF (cuSellos%ISOPEN) THEN
      CLOSE cuSellos;
   END IF;
   PKLOG_MIGRACION.prInsLogMigra ( 501,501,3,'PR_MIGRA_SELLOS',nuTotalRegs,nuErrores,'TERMINA PROCESO #regs: '||nuTotalRegs,'FIN',nuLogError);
   
   update migr_rango_procesos set RAPRFEFI = SYSDATE, RAPRTERM = 'T' where RAPRCODI = 501 AND RAPRBASE = nuBD AND RAPRRAIN = nuInicio AND RAPRRAFI = nuFinal;
   COMMIT;

EXCEPTION
   WHEN OTHERS THEN
      PKLOG_MIGRACION.prInsLogMigra ( 501,501,2,'PR_MIGRA_SELLOS',0,0,'Error: '||SQLERRM,to_char(sqlcode),nuLogError);
      
END PR_MIGRA_SELLOS_ROLLOUT; 
/
