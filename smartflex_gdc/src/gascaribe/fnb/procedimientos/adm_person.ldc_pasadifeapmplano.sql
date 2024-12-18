CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PASADIFEAPMPLANO(SBPATHFILE         IN VARCHAR2,
                                                 SBFILE_NAME        IN VARCHAR2,
                                                 NUPERSON           IN GE_PERSON.PERSON_ID%TYPE) IS
/*****************************************************************
  Unidad         : LDC_PASADIFEAPM
  Descripcion    : Pasa deuda diferida a presente mes de los productos encontrados en el archivo plano
  Fecha          : 01/12/2022

  Historia de Modificaciones
  Fecha             Autor             Modificacion
  =========       =========           ====================
  06-03-2024   		jsoto			  OSF-2381  Ajustes:
										Se reemplaza uso de  UTL_FILE.IS_OPEN por  PKG_GESTIONARCHIVOS.FBLARCHIVOABIERTO_SMF
										Se reemplaza uso de  GE_BOFILEMANAGER.FILECLOSE por  PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_SMF
										Se reemplaza uso de  UTL_FILE.FILE_TYPE por  PKG_GESTIONARCHIVOS.STYARCHIVO
										Se reemplaza uso de  EX.CONTROLLED_ERROR por  PKG_ERROR.CONTROLLED_ERROR
										Se reemplaza uso de  ERRORS.GETERROR por  PKG_ERROR.GETERROR
										Se reemplaza uso de  GE_BOFILEMANAGER.CSBREAD_OPEN_FILE por  PKG_GESTIONARCHIVOS.CSBMODO_LECTURA
										Se reemplaza uso de  GE_BOFILEMANAGER.CHECKFILEISEXISTING por  PKG_GESTIONARCHIVOS.PRCVALIDAEXISTEARCHIVO_SMF
										Se reemplaza uso de  ERRORS.SETERROR por  PKG_ERROR.SETERROR
										Se reemplaza uso de  UT_TRACE.TRACE por  PKG_TRAZA.TRACE
										Se reemplaza uso de  GE_BOFILEMANAGER.FILEREAD por  PKG_GESTIONARCHIVOS.FSBOBTENERLINEA_SMF
										Se reemplaza uso de  GE_BOFILEMANAGER.FILEOPEN por  PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF
										Se reemplaza uso de  UT_FILE.FILEOPEN por  PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF
										Se reemplaza uso de  UT_FILE.FILEWRITE por  PKG_GESTIONARCHIVOS.PRCESCRIBIRLINEA_SMF
										Se adiciona el nombre de la base de datos sbInstanciaBD al asunto de los correos.
  20-06-2024   		jpinedc			  OSF-2605  Ajustes:
                                        * Se usa pkg_Correo
******************************************************************/


  -- Valida si se esta facturando el producto
  Cursor CuValCargos(nuProducto diferido.difenuse%type) Is
    SELECT count(1)
      FROM cargos
     WHERE cargnuse = nuProducto
       AND cargcuco = -1;

  SUBTYPE STYSIZELINE           IS         VARCHAR2(32000);
  FPDIFERIDODATA                pkg_GestionArchivos.styArchivo;
  SBLINE                        STYSIZELINE;
  NURECORD                      NUMBER;
  FPDIFERIDOERRORS              pkg_GestionArchivos.styArchivo;
  SBERRORFILE                   VARCHAR2(100);
  SBERRORLINE                   STYSIZELINE;
  NUERRORCODE                   NUMBER;
  SBERRORMESSAGE                VARCHAR2(2000);

  NUNUSE                        SERVSUSC.SESUNUSE%TYPE;
  NUCTRLCAR                     NUMBER;

  RCPERSON                      DAGE_PERSON.STYGE_PERSON;
  
  sbvariable                    varchar2(20);
  csbMetodo    					CONSTANT VARCHAR2(35):= 'LDC_PASADIFEAPMPLANO'; 

  PROCEDURE PASADIFEAPM
    (
        INUPRODUCTID    IN  OR_ORDER.ORDER_ID%TYPE,
        ONUERRORCODE    OUT NUMBER,
        OSBERRORMESSAGE OUT GE_MESSAGE.DESCRIPTION%TYPE
    )
    IS

     Cursor CuDiferidos(NUNUSE diferido.difenuse%type) Is
        select *
          from diferido d
         where difenuse = NUNUSE
              and difesape != 0;


     Nudifecodi      diferido.difecodi%type;
     Nudifenuse      diferido.difenuse%type;
	 csbMetodo1		 varchar2(100) := csbMetodo||'.PASADIFEAPM';
     
    BEGIN

     pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);

      For reg in Cudiferidos(INUPRODUCTID) Loop
        -- Inicializamos variables por si hay error
        Nudifecodi := reg.difecodi;
        Nudifenuse := reg.difenuse;

        -- Trae deuda a presente mes
        CC_BODefToCurTransfer.GlobalInitialize;

        CC_BODefToCurTransfer.AddDeferToCollect(reg.difecodi);

        CC_BODefToCurTransfer.TransferDebt
        (
            'FINAN',
            nuErrorCode,
            sbErrorMessage,
            false,
            ld_boconstans.cnuCero_Value,
            sysdate
        );

        commit;
        --
      End Loop;

	 pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


    EXCEPTION
    WHEN pkg_error.controlled_error THEN
		pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
		pkg_traza.trace(csbMetodo1||' '||OSBERRORMESSAGE);
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(ONUERRORCODE, OSBERRORMESSAGE);
		pkg_traza.trace(csbMetodo1||' '||OSBERRORMESSAGE);
		pkg_traza.trace(csbMetodo1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END;

BEGIN

  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


  RCPERSON := DAGE_PERSON.FRCGETRECORD(NUPERSON);
  IF RCPERSON.E_MAIL IS NOT NULL THEN    
    pkg_Correo.prcEnviaCorreo
    (
        isbDestinatarios    => RCPERSON.E_MAIL,
        isbAsunto           => ' ASIGNACION POR ARCHIVO PLANO ',
        isbMensaje          => 'INICIA ASIGNACION POR ARCHIVO PLANO'
    );
  END IF;
  
  PKG_GESTIONARCHIVOS.PRCVALIDAEXISTEARCHIVO_SMF (SBPATHFILE,sbFILE_NAME);
  SBERRORFILE := SUBSTR(sbFILE_NAME,1,INSTR(sbFILE_NAME,'.')-1);

  IF SBERRORFILE IS NULL THEN
     SBERRORFILE := sbFILE_NAME;
  END IF;

  SBERRORFILE := SBERRORFILE||'.err';

  FPDIFERIDODATA:= PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF(SBPATHFILE, sbFILE_NAME, PKG_GESTIONARCHIVOS.CSBMODO_LECTURA);
  FPDIFERIDOERRORS:= PKG_GESTIONARCHIVOS.FTABRIRARCHIVO_SMF(SBPATHFILE,SBERRORFILE,'w');
  
  NURECORD := 0;

    WHILE TRUE LOOP
		 BEGIN
            SBLINE:= PKG_GESTIONARCHIVOS.FSBOBTENERLINEA_SMF(FPDIFERIDODATA);
            EXCEPTION
                WHEN NO_DATA_FOUND THEN
                    EXIT;
                WHEN OTHERS THEN
                    RAISE;
          END;
		
        NURECORD := NURECORD + 1;
        NUNUSE   := TO_NUMBER(substr(SBLINE, 1, instr(SBLINE, ';')-1));

        -- Valida que el producto no tenga cargos con cuenta de cobro a la -1
        If cuValcargos%isopen then
          close cuValcargos;
        end if;
        --
        open cuValcargos(NUNUSE);
        fetch CuValCargos into nuctrlcar;
        close CuValCargos;
        --
        IF nuctrlcar <= 0 THEN
          PASADIFEAPM(NUNUSE, NUERRORCODE, SBERRORMESSAGE);
          IF NUERRORCODE IS NOT NULL THEN
            SBERRORLINE := 'El Producto ' || NUNUSE || ' PRESENTA ERROR: ' || SUBSTR(SBERRORMESSAGE,1,70);
            PKG_GESTIONARCHIVOS.PRCESCRIBIRLINEA_SMF(FPDIFERIDOERRORS,SBERRORLINE);
            SBERRORLINE := NULL;
          END IF;
        ELSE
          SBERRORLINE := 'El Producto ' || NUNUSE || ' se esta facturando, tiene cargos a la -1';
          PKG_GESTIONARCHIVOS.PRCESCRIBIRLINEA_SMF(FPDIFERIDOERRORS,SBERRORLINE);
          SBERRORLINE := NULL;
        END IF;

    END LOOP;

    IF pkg_GestionArchivos.fblArchivoAbierto_Ut (FPDIFERIDODATA) THEN
        PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_SMF (FPDIFERIDODATA);
    END IF;

    IF pkg_GestionArchivos.fblArchivoAbierto_Ut (FPDIFERIDOERRORS) THEN
        PKG_GESTIONARCHIVOS.PRCCERRARARCHIVO_SMF (FPDIFERIDOERRORS);
    END IF;
    COMMIT;
    IF RCPERSON.E_MAIL IS NOT NULL THEN
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => RCPERSON.E_MAIL,
            isbAsunto           => ' PASO DE DIFERIDO POR ARCHIVO PLANO ',
            isbMensaje          => 'PASAR DIFERIDO POR ARCHIVO PLANO TERMINO. VALIDE Y CORRIJA LAS INCONSISTENCIAS DEL ARCHIVO: '||
                     SBPATHFILE||'/'||SBERRORFILE
        );    
    END IF;
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
WHEN pkg_error.controlled_error THEN
		pkg_error.getError(NUERRORCODE, SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo||' '||SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => RCPERSON.E_MAIL,
            isbAsunto           => ' NOTIFICACION DE ERROR [LDC_DIFEAPM]',
            isbMensaje          => SBERRORMESSAGE
        );		
		ROLLBACK;
		RAISE pkg_error.controlled_error;
WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.getError(NUERRORCODE, SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo||' '||SBERRORMESSAGE);
		pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        pkg_Correo.prcEnviaCorreo
        (
            isbDestinatarios    => RCPERSON.E_MAIL,
            isbAsunto           => ' NOTIFICACION DE ERROR [LDC_DIFEAPM]',
            isbMensaje          => ''|| sbvariable || ' NUNUSE ' || NUNUSE || '----' ||SBERRORMESSAGE
        );			
		ROLLBACK;
		RAISE pkg_error.controlled_error;
END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PASADIFEAPMPLANO', 'ADM_PERSON');
END;
/
