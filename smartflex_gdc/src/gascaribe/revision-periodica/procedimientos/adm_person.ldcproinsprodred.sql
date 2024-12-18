CREATE OR REPLACE PROCEDURE adm_person.ldcproinsprodred Is

/*******************************************************************************
Propiedad intelectual de PROYECTO GASES DEL CARIBE

  Autor         :ESANTIAGO (horbath)
  Fecha         :24-04-2020
  DESCRIPCION   : cargue de archivo plano para el proceso de asociación del producto con el tipo de red.
  CASO          : 319

  Fecha                IDEntrega           Modificacion
  ============    ================    ============================================
  08/05/2024      OSF-2668             Se migra del esquema OPEN al esquema ADM_PERSON
  *******************************************************************************/

 sbmensaje        VARCHAR2(2000);
 eerror           EXCEPTION;
 erextarc         EXCEPTION;


  usercon SA_USER.MASK%TYPE;
  us number;
  SBDIRECTORY_ID ge_boInstanceControl.stysbValue;
  SBFILENAME  ge_boInstanceControl.stysbValue;
  SBPATHFILE GE_DIRECTORY.PATH%TYPE;
  NUCODIGOERROOR NUMBER;
  SBMENSAJEERROR VARCHAR2(4000);
  --archivo
   SBARCHIVOORIGEN    UTL_FILE.FILE_TYPE;
    SBLINEARORIGEN     VARCHAR2(4000) := NULL;
    NUREGISTRO         NUMBER := 1;
    NUCANTIDADPALABRAS NUMBER;
    SBARRAYVARCHAR     ldc_boarchivo.tbarray;
    NUCONTADOR         NUMBER;
    ----------DESTINO
    SBARCHIVODESTINO       UTL_FILE.FILE_TYPE;
    SBNOMBREARCHIVODESTINO VARCHAR2(4000);
    NUINPRODUCT NUMBER(15);
    NUINTIPORED NUMBER(15);
    SBINTIPORED varchar2(10);
    NUVALLINEA NUMBER;
    NUVALEXTARC NUMBER;
	nuExistepr NUMBER;
	nuExisteTipo NUMBER;
	nuTipoAnt NUMBER;
	SBTERMINAL varchar2(100);
	archivo_error number(1);



  CURSOR cu_valuser (usua number, tipo number) IS
    SELECT count(*)
	FROM LDC_USERCAFEC
	where USUARIO = usua
	and permiso='REGISTRAR'
	and TASK_TYPE_ID = tipo;

  CURSOR curtipred (tipo number) IS
	select 1
	from LDC_TYPE_RED
	where type_red_id=tipo;

  CURSOR cuValpr (producto number) IS
	select type_red_id
	from LDC_PRODUCT_RED
	where product_id=producto;

  CURSOR cu_extpr (producto number) IS
    SELECT 1
    FROM PR_PRODUCT
    WHERE PRODUCT_ID=producto;

  PROCEDURE PR_WRTERROR (mensaje  VARCHAR2, NOMARCH VARCHAR2,DIRARCH VARCHAR2)  IS
	SBARCHIVOERR       UTL_FILE.FILE_TYPE;
  BEGIN
	SBARCHIVOERR:= UTL_FILE.FOPEN(DIRARCH,NOMARCH,'A');
	UTL_FILE.PUT_LINE(SBARCHIVOERR,mensaje);
	UTL_FILE.FCLOSE(SBARCHIVOERR);
  EXCEPTION
    when OTHERS then
    UT_TRACE.TRACE( 'ERROR AL ACCEDER AL ARCHIVO DE ERRORES'||sysdate, 10 );

  END;



begin

    UT_TRACE.TRACE( 'LDCPROINSPRODRED inicio'||sysdate, 10 );

    usercon:= dasa_user.fsbgetmask(dage_person.fnugetuser_id(GE_BOPERSONAL.FNUGETPERSONID()));
	SBDIRECTORY_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_DIRECTORY', 'DIRECTORY_ID' ); --'/smartfiles/tmp';
	SBFILENAME := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER_COMMENT', 'ORDER_COMMENT' ); --'prueba_1_319.txt'
	SBPATHFILE := DAGE_DIRECTORY.FSBGETPATH( SBDIRECTORY_ID );
    NUVALEXTARC := REGEXP_COUNT(UPPER(SBFILENAME),'\.TXT$');
    UT_TRACE.TRACE( 'LDCPROINSPRODRED  NUVALEXTARC: '||NUVALEXTARC, 10 );
    IF NUVALEXTARC = 0 THEN
        UT_TRACE.TRACE( 'LDCPROINSPRODRED Error en el la extecion de archivo SBMENSAJEERROR: '||SBMENSAJEERROR, 10 );
      --Errors.SetError(cnuNULL_ATTRIBUTE, SBMENSAJEERROR);
      raise erextarc;
    END IF;


	LDC_BOARCHIVO.PRVALIDAEXISTENCIAABRIR(SBPATHFILE,
                                          SBFILENAME,
                                          NUCODIGOERROOR,
                                          SBMENSAJEERROR);

	IF NUCODIGOERROOR <> 0 THEN
        UT_TRACE.TRACE( 'LDCPROINSPRODRED aqui 3.1 SBMENSAJEERROR: '||SBMENSAJEERROR, 10 );
      --Errors.SetError(cnuNULL_ATTRIBUTE, SBMENSAJEERROR);
      raise eerror;
    END IF;

	--INICIO ABRIR ARCHIVO DE ITEMS SERIADOS
    SBARCHIVOORIGEN := UTL_FILE.FOPEN(SBPATHFILE, SBFILENAME, 'R');
	---INICIO ARCHIVO DE ERRORES
    SBNOMBREARCHIVODESTINO := SBFILENAME;
    SBNOMBREARCHIVODESTINO := REPLACE(UPPER(SBNOMBREARCHIVODESTINO), '.TXT') || '_' ||
                              REPLACE(REPLACE(REPLACE(TO_CHAR(SYSDATE,
                                                              'DD/MM/YYYY HH:MI:SS'),
                                                      '/',
                                                      '_'),
                                              ':',
                                              '_'),
                                      ' ',
                                      '_') || '.ERR';

	LOOP
      BEGIN

        UT_TRACE.TRACE( 'LDCPROINSPRODRED aqui 5 NUREGISTRO:'||NUREGISTRO, 10 );

        UTL_FILE.get_line(SBARCHIVOORIGEN, SBLINEARORIGEN);
        SBLINEARORIGEN:=replace(replace(SBLINEARORIGEN, chr(10), ''), chr(13), '');
        UT_TRACE.TRACE('LINEA --> ' || SBLINEARORIGEN, 10);
        NUVALLINEA :=REGEXP_COUNT(SBLINEARORIGEN,'^[0-9]*\|[0-9]*;$');

        UT_TRACE.TRACE( 'LDCPROINSPRODRED  LINEA --> ' || SBLINEARORIGEN||' NUVALLINEA:'||NUVALLINEA, 10 );
      EXCEPTION
        WHEN NO_DATA_FOUND THEN
          EXIT;
      END;
		IF NUVALLINEA >=1 THEN

			--CANTIDAD DE PALABRAS EN EL REGISTRO DEL ARCHIVO
			NUCANTIDADPALABRAS := LDC_BOARCHIVO.FNUCOUNTCHARACTER(SBLINEARORIGEN,'|');

			--INICIALIZA EL VECTOR Y VARIABLE
			SBARRAYVARCHAR.DELETE;
			NUINPRODUCT:= NULL;
			NUINTIPORED := NULL;
			SBINTIPORED := NULL;
            nuExistepr := NULL;
            nuExisteTipo := NULL;
            nuTipoAnt    := NULL;

			UT_TRACE.TRACE( 'LDCPROINSPRODRED  NUINPRODUCT: '||NUINPRODUCT||' NUINTIPORED:'||NUINTIPORED, 10 );
			--COLOCA CADA PALABRA EN UN POSICION DEL VECTOR
			SBARRAYVARCHAR := LDC_BOARCHIVO.FSBARRAYVARCHAR(SBLINEARORIGEN,
														  '|',
														  NUCANTIDADPALABRAS);

			--RECORRE EL VECTOR PARA OBTENER EL VALOR DE CADA POSCION Y SER UTILIZADOS EN EL XML DE OPEN


			FOR NUCONTADOR IN 1 .. NUCANTIDADPALABRAS LOOP
				IF NUINPRODUCT IS NULL THEN

				  NUINPRODUCT := TO_NUMBER(SBARRAYVARCHAR(NUCONTADOR));
				ELSIF NUINTIPORED IS NULL THEN

				  SBINTIPORED := (SUBSTR(SBARRAYVARCHAR(NUCONTADOR), 1, instr(SBARRAYVARCHAR(NUCONTADOR) ,';')-1 ));
				  NUINTIPORED := TO_NUMBER(replace(replace(SBINTIPORED, chr(10), ''), chr(13), ''));

				END IF;
				UT_TRACE.TRACE('CONTADOR[' || NUCONTADOR || ']', 10);

			END LOOP;


			open cu_extpr(NUINPRODUCT);
			fetch cu_extpr into nuExistepr;
			close cu_extpr;

			open curtipred(NUINTIPORED);
			fetch curtipred into nuExisteTipo;
			close curtipred;

			-- SE VALIDA LA EXISTENCIA DE DEL PRODUCTO Y DEL TIPO DE RED
			IF nuExistepr = 1 and nuExisteTipo = 1 then
				open cuValpr(NUINPRODUCT);
				fetch cuValpr into nuTipoAnt;
				close cuValpr;
				-- SE VALUDA QUE ESTE PREVIAMNTE REGISTRADO EN LA TABLA LDC_PRODUCT_RED
				IF nuTipoAnt IS NOT NULL THEN
					BEGIN
						update LDC_PRODUCT_RED
						SET TYPE_RED_ID=NUINTIPORED
						where PRODUCT_ID=NUINPRODUCT;

					EXCEPTION
						when OTHERS then
                        UT_TRACE.TRACE('ERROR AL ACTUALIZAR LDC_PRODUCT_RED', 10);

					end;
				ELSE -- SINO SE CREA UN NUEVO REGISTRO EN LA TABLA LDC_PRODUCT_RED
					BEGIN
						INSERT INTO LDC_PRODUCT_RED (PRODUCT_ID, TYPE_RED_ID) VALUES (NUINPRODUCT, NUINTIPORED);

					EXCEPTION
						when OTHERS then
                        UT_TRACE.TRACE('ERROR AL INSERTAR LDC_PRODUCT_RED', 10);

					end;
				END IF;
				-- SE CREA UN REGISTRO EN LA TBALA LDC_LOG_PRODUCT_RED
				BEGIN
					SELECT SYS_CONTEXT('USERENV','HOST')
					INTO SBTERMINAL
					FROM DUAL;

					INSERT INTO LDC_LOG_PRODUCT_RED (LOG_PRODUCT_RED_ID, PRODUCT_ID, TYPE_RED_ANT,TYPE_RED_ACT, FECHA, USUARIO, TERMINAL)
					VALUES (SEQ_LOG_PRODUCT_RED.NEXTVAL, NUINPRODUCT, nuTipoAnt,NUINTIPORED, sysdate, usercon, SBTERMINAL);

				EXCEPTION
					when OTHERS then
					UT_TRACE.TRACE('ERROR AL INSERTAR LDC_LOG_PRODUCT_RED', 10);
				end;

			ELSIF nuExisteTipo <>1 OR nuExisteTipo IS NULL THEN
            PR_WRTERROR ('Error línea '||NUREGISTRO||': el tipo '||NUINTIPORED||' no existe', SBNOMBREARCHIVODESTINO,SBPATHFILE);

			ELSIF nuExistepr <>1 OR nuExistepr IS NULL THEN
			PR_WRTERROR ('Error línea '||NUREGISTRO||': el producto '||NUINPRODUCT||' no existe', SBNOMBREARCHIVODESTINO,SBPATHFILE);

			END IF;

		ELSE

		PR_WRTERROR ('Error línea '||NUREGISTRO||': LINEA NO TIENE LE FORMATO CORRECTO', SBNOMBREARCHIVODESTINO,SBPATHFILE);
		END IF;

		--SBSERIE := replace(replace(SBSERIE, chr(10), ''), chr(13), '');
		NUREGISTRO := NUREGISTRO + 1;
    END LOOP;
    COMMIT;
	UTL_FILE.FCLOSE(SBARCHIVOORIGEN);

UT_TRACE.TRACE('LDCPROINSPRODRED fin: '||sysdate, 10);

EXCEPTION
  WHEN eerror THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'NO se encontro el archivo '||SBFILENAME||' en el directorio especificado');
   ut_trace.trace('LDCPROINSPRODRED '||sbmensaje||' '||SQLERRM, 10);
  WHEN erextarc THEN
   ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,'El tipo de archivo inválido. Debe ser .txt');
   ut_trace.trace('LDCPROINSPRODRED '||sbmensaje||' '||SQLERRM, 10);
 WHEN OTHERS THEN
  ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,SQLERRM);
  ut_trace.trace('LDCPROINSPRODRED '||' '||SQLERRM, 10);
end LDCPROINSPRODRED;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre procedimiento LDCPROINSPRODRED
BEGIN
    pkg_utilidades.prAplicarPermisos('LDCPROINSPRODRED', 'ADM_PERSON'); 
END;
/
