CREATE OR REPLACE procedure PR_ACTUALIZA_PUNTOSCONEXMA(p_nuProduct in number default -1)  as
/* *****************************************************************************************************
   Author       :   Manuel Palomares - Olsoftware
   Programa   1 :  PR_ACTUALIZA_PUNTOSCONEXMA
   Descripcion  : Actualiza ab_info_premise al predio con la cantidad de conexion
********************************************************************************************************/
	CURSOR cuPrediosSfma
  is
	select t.* from (
                    SELECT
                         c.PREMISE_ID,
                         a.product_id,
                         case
                        when a.product_id < 1000000 then a.product_id
                        else
                          (a.product_id - 1000000)
                         end id_gasplus_Servsusc,
                         case
                        when a.product_id < 1000000 then 1
                        when a.product_id > 1000000 then 2
						end basedato
                    FROM PR_PRODUCT a,AB_ADDRESS b ,AB_PREMISE c
                    WHERE  b.ESTATE_NUMBER = c.PREMISE_ID
                    AND    a.ADDRESS_ID = b.address_id
                    and a.PRODUCT_TYPE_ID= 7014
    ) t
	where
	t.product_id = decode(p_nuProduct,-1,t.product_id,p_nuProduct);

	   --
     TYPE tipo_cu_datos IS TABLE OF cuPrediosSfma%ROWTYPE;

   -- DECLARACION DE TABLAS TIPOS.
   --
     tbl_datos      tipo_cu_datos := tipo_cu_datos ();

	 nuLogError NUMBER := 0;
begin

    -- Inserta registro de inicio en el log
   PKLOG_MIGRACION.prInsLogMigra (3020,3020,1,'PR_ACTUALIZA_PUNTOSCONEXMA',0,0,'Inicia Proceso','INICIO',nuLogError);
    -- Cargar datos


	begin
		update ab_info_premise
		set number_points = 0
		where number_points <> 2;
	end;
   OPEN cuPrediosSfma;
	--
	-- Borrar tablas 	tbl_datos.
    --
   LOOP
		tbl_datos.delete;
		FETCH cuPrediosSfma BULK COLLECT INTO tbl_datos LIMIT 1000;

		  FOR nuindice IN 1 .. tbl_datos.COUNT LOOP
				-- Actualiza datos de predio

				begin
					update ab_info_premise
					set number_points = 1
					where premise_id = tbl_datos(nuindice).PREMISE_ID;
				exception
				when others then
				PKLOG_MIGRACION.prInsLogMigra(3020,3020,1,'PR_ACTUALIZA_PUNTOSCONEXMA',0,0,'Error actualizando predio ['||tbl_datos(nuindice).PREMISE_ID||']'||sqlerrm,'INICIO',nuLogError);
				end;
		  END LOOP;

		commit;
		EXIT WHEN cuPrediosSfma%NOTFOUND;
	END LOOP;

		-- Cierra CURSOR.
		IF (cuPrediosSfma%ISOPEN)THEN
				CLOSE cuPrediosSfma;
		END IF;
	PKLOG_MIGRACION.prInsLogMigra (3020,3020,3,'PR_ACTUALIZA_PUNTOSCONEXMA',0,0,'Fin Proceso','FIN',nuLogError);
end PR_ACTUALIZA_PUNTOSCONEXMA;
/
