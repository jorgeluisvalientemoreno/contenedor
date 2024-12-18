CREATE OR REPLACE PACKAGE ADM_PERSON.DALDC_PKGMANTGRUPLOCA IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_PKGMANTGRUPLOCA
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                               
    ****************************************************************/   

     /* Cursor general para acceso por Llave Primaria */
    CURSOR cuRecord ( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type ) IS
    SELECT GRLOCODI, GRUPCODI, GRLOIDLO, GRLOSEOP
    FROM LDC_GRUPO_LOCALIDAD
    WHERE GRLOCODI = inuGRLOCODI;

    /* Cursor para validar si existe grupo */
    CURSOR cuRecordGrupo ( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type ) IS
    SELECT 'X'
    FROM LDC_GRUPO
    WHERE GRUPCODI = inuGRUPCODI;

    /* Cursor para validar si existe localidad */
	  CURSOR cuRecordLocalidad( inuGEOGRAP_LOCATION_ID in GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%type ) IS
    SELECT 'X'
    FROM GE_GEOGRA_LOCATION
    WHERE GEOGRAP_LOCATION_ID = inuGEOGRAP_LOCATION_ID;

	  /* Cursor para validar si existe sector operativo */
	  CURSOR cuRecordSectOp( inuOPERATING_SECTOR_ID in OR_OPERATING_SECTOR.OPERATING_SECTOR_ID%type ) IS
    SELECT 'X'
    FROM OR_OPERATING_SECTOR
    WHERE OPERATING_SECTOR_ID = inuOPERATING_SECTOR_ID;


    /* Subtipos */
    subtype styLDC_GRLOCODI  is  cuRecord%rowtype;
    type    tyRefCursor is  REF CURSOR;

    /*Tipos*/
	  type tytbLDC_GRLOCODI is table of styLDC_GRLOCODI index by binary_integer;
	  type tyrfRecords is ref cursor return styLDC_GRLOCODI;


    /* Tipos referenciando al registro */
    type tytbGRLOCODI   is table of LDC_GRUPO_LOCALIDAD.GRLOCODI%type index by binary_integer;
    type tytbGRUPCODI	is table of LDC_GRUPO_LOCALIDAD.GRUPCODI%type index by binary_integer;
    type tytbGRLOIDLO 	is table of LDC_GRUPO_LOCALIDAD.GRLOIDLO%type index by binary_integer;
	  type tytbGRLOSEOP   is table of LDC_GRUPO_LOCALIDAD.GRLOSEOP%type index by binary_integer;

    /*Registros*/
    type tyrcLDC_GRUPO_LOCALIDAD is record
    (
		GRLOCODI	tytbGRLOCODI,
		GRUPCODI	tytbGRUPCODI,
		GRLOIDLO	tytbGRLOIDLO,
		GRLOSEOP	tytbGRLOSEOP
    );


    /***** Metodos Publicos ****/
    FUNCTION fsbVersion  RETURN varchar2;

    FUNCTION fblExist( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type ) RETURN boolean;
    /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Funcion fblExist, valida si un registro existe en la tabla
                    LDC_GRUPO_LOCALIDAD

      Parametros Entrada
        inuGRLOCODI Id de la tabla
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE getRecordById( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type,
                             orcRecord out nocopy styLDC_GRLOCODI );
    /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que devuelve un registro por id de la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
        inuGRLOCODI Id de la tabla
      Valor de salida
       orcRecord Cursor de datos de la tabla LDC_GRUPO_LOCALIDAD

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    FUNCTION frcGetRcData(  inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type ) RETURN styLDC_GRLOCODI;
    /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Funcion que retorna un vector de la tabla LDC_GRUPO_LOCALIDAD dependiendo el ID

      Parametros Entrada
        inuGRLOCODI Id de la tabla
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    FUNCTION frcGetRcData RETURN styLDC_GRLOCODI;
    /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Funcion que retorna un vector de toda la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE insRecords (iotbLDC_GRUPO_LOCALIDAD in out nocopy tytbLDC_GRLOCODI );
    /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que inserta un registro en la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       iotbLDC_GRUPO_LOCALIDAD Registro de la tabla LDC_GRUPO_LOCALIDAD
      Valor de salida
        iotbLDC_GRUPO_LOCALIDAD  Registro de la tabla LDC_GRUPO_LOCALIDAD

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE delRecord (inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type);
    /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que elimina un registro en la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       inuGRLOCODI Id de la tabla LDC_GRUPO_LOCALIDAD
      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE updRecords(iotbLDC_GRUPO_LOCALIDAD in out nocopy tytbLDC_GRLOCODI);
      /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica varios registros de la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       iotbLDC_GRUPO_LOCALIDAD Registro de la tabla LDC_GRUPO_LOCALIDAD
      Valor de salida
        iotbLDC_GRUPO_LOCALIDAD  Registro de la tabla LDC_GRUPO_LOCALIDAD

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	  PROCEDURE updGRUPCODI(inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type,
							inuGRUPCODI in LDC_GRUPO_LOCALIDAD.GRUPCODI%type );
      /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica el id del tipo de trabajo dependiendo de ID de la tabla
                     LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       inuGRLOCODI ID de la tabla LDC_GRUPO_LOCALIDAD
       inuGRUPCODI  Id del tipo de trabajo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE updGRLOIDLO( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type,
                           inuGRLOIDLO in LDC_GRUPO_LOCALIDAD.GRLOIDLO%type);
     /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica la actividad de multa por el ID de la tabla
                     LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       inuGRLOCODI ID de la tabla LDC_GRUPO_LOCALIDAD
       inuGRLOIDLO  Id de actividad
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	PROCEDURE updGRLOSEOP( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type,
                           inuGRLOSEOP in LDC_GRUPO_LOCALIDAD.GRLOSEOP%type);
     /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica el tiempo en dia de multa por el ID de la tabla
                     LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       inuGRLOCODI ID de la tabla LDC_GRUPO_LOCALIDAD
       inuGRLOSEOP tiempo en dia para multar
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE SetUseCache(iblUseCache    in  boolean);
      /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que setea si se maneja o no cache

      Parametros Entrada
       iblUseCache   flag que indica si se maneja o no cache
      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
END;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALDC_PKGMANTGRUPLOCA IS

  csbVersion                CONSTANT VARCHAR2(20) := 'OSS_MAN_JGBA_2001090_1'; --Ticket 200-1090 JGBA -- se crea constante para almacenar version del programa
  cnuRECORD_NOT_EXIST       CONSTANT NUMBER(1)    := 1;                --Ticket 200-1090 JGBA -- se crea constante para almacenar el codigo de error si no existe registro
  cnuRECORD_ALREADY_EXIST   CONSTANT NUMBER(1)    := 2;                --Ticket 200-1090 JGBA -- se crea constante para almacenar el codigo de error si existe registro
  csbTABLEPARAMETER         CONSTANT VARCHAR2(30) := 'LDC_GRUPO_LOCALIDAD';   --Ticket 200-1090 JGBA -- se crea constante para almacenar el nombre de ta tabla
  cnuGeEntityId             CONSTANT VARCHAR2(30) := 4174;             --Ticket 200-1090 JGBA -- se crea constante para almacenar ID de la tabla en GE_ENTITY
  cnuRECORD_HAVE_CHILDREN   CONSTANT NUMBER(4)    := -2292;            --Ticket 200-1090 JGBA -- se crea constante para manejo de llaves foraneas
  blDAO_USE_CACHE           BOOLEAN := null;                           --Ticket 200-1090 JGBA -- se crea flag para manejo de cache
  rcRecOfTab                tyrcLDC_GRUPO_LOCALIDAD;                          --Ticket 200-1090 JGBA -- se crea registro de type tyrcLDC_GRUPO_LOCALIDAD
  rcData                    cuRecord%rowtype;                          --Ticket 200-1090 JGBA -- se crea registro de type cuRecord
  FUNCTION fsbVersion RETURN VARCHAR2 iS
   /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : funcion que retorna la version del programa

    Parametros Entrada

    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE SetUseCache (	iblUseCache in  BOOLEAN	) IS
  /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Procedimento que se encarga de setear el flag de cache

    Parametros Entrada
      iblUseCache   Flag que indica si se aneja cache o no
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	BEGIN
	    blDAO_USE_CACHE := iblUseCache; --Ticket 200-1090 JGBA -- se setea nuevo valor para el flag
	END;

	FUNCTION fsbGetMessageDescription	RETURN VARCHAR2 IS
  /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion que se encarga de mostrar la descripcion  de la tabla LDC_GRUPO_LOCALIDAD

    Parametros Entrada
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  sbTableDescription VARCHAR2(4000); --Ticket 200-1090 JGBA -- se almacena el id de la tabla LDC_GRUPO_LOCALIDAD

  BEGIN
    --Ticket 200-1090 JGBA -- se valida si al entidad existe en GE_ENTITY
    IF (cnuGeEntityId > 0 AND dage_entity.fblExist (cnuGeEntityId))  THEN
          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
    ELSE
          sbTableDescription:= csbTABLEPARAMETER;
    END IF;

		RETURN sbTableDescription ;
	END;

  FUNCTION fsbPrimaryKey( rcI in styLDC_GRLOCODI default rcData )	RETURN VARCHAR2 IS
  /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion que se encarga de mostrar la llave primaria de la tabla LDC_GRUPO_LOCALIDAD

    Parametros Entrada
     rcI   Tabla PL de LDC_GRUPO_LOCALIDAD
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
		sbPk VARCHAR2(500); --Ticket 200-1090 JGBA -- se almacena el id de la tabla LDC_GRUPO_LOCALIDAD
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.GRLOCODI);
		sbPk:=sbPk||']';
		RETURN sbPk;
	END;
   PROCEDURE DelRecordOfTables	IS
   /**************************************************************************
		Autor       : Josh Glen Brito Avila / Horbath
		Fecha       : 2017-04-04
		Ticket      : 200-1090
		Descripcion : Procedimiento que se encarga de limpiar la tabla PL rcRecOfTab

		Parametros Entrada
		Valor de salida

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
   BEGIN
			rcRecOfTab.GRLOCODI.delete;
			rcRecOfTab.GRUPCODI.delete;
			rcRecOfTab.GRLOIDLO.delete;
			rcRecOfTab.GRLOSEOP.delete;

  END;

  PROCEDURE FillRecordOfTables ( itbLDC_GRLOCODI in out nocopy tytbLDC_GRLOCODI ) IS
   /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Procedimiento que se encarga de copiar los registros a la tabla PL rcRecOfTab

    Parametros Entrada
      itbLDC_GRLOCODI Tabla PL de LDC_GRUPO_LOCALIDAD
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	BEGIN
		DelRecordOfTables; --Ticket 200-1090 JGBA -- elimina los datos de la tabla PL rcRecOfTab

   --Ticket 200-1090 JGBA -- consulta los registros de la tabla  PL itbLDC_GRLOCODI
		FOR n IN itbLDC_GRLOCODI.FIRST .. itbLDC_GRLOCODI.LAST LOOP
			rcRecOfTab.GRLOCODI(n) := itbLDC_GRLOCODI(n).GRLOCODI;
			rcRecOfTab.GRUPCODI(n) := itbLDC_GRLOCODI(n).GRUPCODI;
			rcRecOfTab.GRLOIDLO(n) := itbLDC_GRLOCODI(n).GRLOIDLO;
			rcRecOfTab.GRLOSEOP(n) := itbLDC_GRLOCODI(n).GRLOSEOP;
		END LOOP;
	END;

  PROCEDURE LOAD ( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type )	IS
  /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Procedimiento que carga los registro en memoria dependiendo el ID de la tabla
                  LDC_GRUPO_LOCALIDAD

    Parametros Entrada
      inuGRLOCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    rcError styLDC_GRLOCODI; --Ticket 200-1090 JGBA -- se crea registro para los errores
		rcRecordNull cuRecord%rowtype;  --Ticket 200-1090 JGBA -- Almacena una tabla pl vacia
	BEGIN
    rcError.GRLOCODI := inuGRLOCODI; --Ticket 200-1090 JGBA -- se almacena id del registro consultado

		--Ticket 200-1090 JGBA -- valida si el cursor cuRecord esta abierto para cerrarlo
    IF cuRecord%isOPEN THEN
			CLOSE cuRecord;
		END IF;
    --Ticket 200-1090 JGBA -- se carga la inFORmacion por ID
		OPEN cuRecord ( inuGRLOCODI );
		FETCH cuRecord INTO rcData;
		IF cuRecord%notfound  THEN
			CLOSE cuRecord;
			rcData := rcRecordNull;
			RAISE no_data_found;
		END IF;
		CLOSE cuRecord;
  EXCEPTION
    WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;
	END;

  FUNCTION fblAlreadyLoaded (inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type )RETURN BOOLEAN
  /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion fblAlreadyLoaded, valida si un registro ya esta cargado  en memoria

    Parametros Entrada
      inuGRLOCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	IS

  BEGIN
    --Ticket 200-1090 JGBA -- valida si el ID  a buscar ya esta cargado en memoria
		IF ( inuGRLOCODI = rcData.GRLOCODI ) THEN
			RETURN ( TRUE );
		END IF;
		RETURN (FALSE);
	END;


   FUNCTION fblExist ( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type ) RETURN BOOLEAN IS
   /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion fblExist, valida si un registro existe en la tabla
                  LDC_GRUPO_LOCALIDAD

    Parametros Entrada
      inuGRLOCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	BEGIN
		--Ticket 200-1090 JGBA -- se consulta registro en la BD
    LOAD ( inuGRLOCODI );

		RETURN (TRUE); --Ticket 200-1090 JGBA -- retorna verdadero si existe
	EXCEPTION
		WHEN no_data_found THEN
			RETURN (FALSE);
  END fblExist;

  PROCEDURE getRecordById  (  inuGRLOCODI IN LDC_GRUPO_LOCALIDAD.GRLOCODI%TYPE,
                              orcRecord OUT NOCOPY styLDC_GRLOCODI  )    IS
 	 /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que devuelve un registro por id de la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
        inuGRLOCODI Id de la tabla
      Valor de salida
       orcRecord Cursor de datos de la tabla LDC_GRUPO_LOCALIDAD

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

    rcError styLDC_GRLOCODI;  --Ticket 200-1090 JGBA -- se Crea registro para manejar error
	BEGIN
     rcError.GRLOCODI := inuGRLOCODI;  --Ticket 200-1090 JGBA -- se almacena ID del registro consultado
    --Ticket 200-1090 JGBA -- se consulta registro en la BD
		LOAD ( inuGRLOCODI );
		orcRecord := rcData;
	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;
  END getRecordById;

  FUNCTION frcGetRcData( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type )  RETURN styLDC_GRLOCODI IS
   /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion que retorna un vector de la tabla LDC_GRUPO_LOCALIDAD dependiendo el ID

    Parametros Entrada
      inuGRLOCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

    rcError styLDC_GRLOCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error
	BEGIN
		rcError.GRLOCODI:=inuGRLOCODI;  --Ticket 200-1090 JGBA -- se almacena ID del registro consultado
    --Ticket 200-1090 JGBA --se valida si usa cache y esta cargado retorna
	  IF  blDAO_USE_CACHE AND fblAlreadyLoaded ( inuGRLOCODI )	THEN
		  RETURN(rcData);
		END IF;
    --Ticket 200-1090 JGBA -- se consulta registro en la BD
		LOAD ( inuGRLOCODI );
		RETURN(rcData);
	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;
	END frcGetRcData;

  FUNCTION frcGetRcData RETURN styLDC_GRLOCODI IS
    /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Funcion que retorna un vector de toda la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

	BEGIN
		RETURN(rcData);
	END frcGetRcData;

  PROCEDURE insRecords ( iotbLDC_GRUPO_LOCALIDAD in out nocopy tytbLDC_GRLOCODI )	IS
   /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que inserta un registro en la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       iotbLDC_GRUPO_LOCALIDAD Registro de la tabla LDC_GRUPO_LOCALIDAD
      Valor de salida
        iotbLDC_GRUPO_LOCALIDAD  Registro de la tabla LDC_GRUPO_LOCALIDAD

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

	BEGIN
		FillRecordOfTables(iotbLDC_GRUPO_LOCALIDAD); --Ticket 200-1090 JGBA -- se cargan los registro en memoria
		FORALL n in iotbLDC_GRUPO_LOCALIDAD.first..iotbLDC_GRUPO_LOCALIDAD.last
				INSERT INTO LDC_GRUPO_LOCALIDAD
								  ( GRLOCODI,
									GRUPCODI,
									GRLOIDLO,
									GRLOSEOP
								  )
			VALUES
						(
						 rcRecOfTab.GRLOCODI(n),
						 rcRecOfTab.GRUPCODI(n),
						 rcRecOfTab.GRLOIDLO(n),
						 rcRecOfTab.GRLOSEOP(n)
						);

	EXCEPTION
		WHEN dup_val_on_index THEN
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			RAISE ex.CONTROLLED_ERROR;
	END insRecords;

  PROCEDURE delRecord ( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type ) IS
  /**************************************************************************
    Autor       : Josh Glen Brito Avila / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Procedimiento que elimina un registro en la tabla LDC_GRUPO_LOCALIDAD

    Parametros Entrada
     inuGRLOCODI Id de la tabla LDC_GRUPO_LOCALIDAD
    Valor de salida


    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

		rcError styLDC_GRLOCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error
	BEGIN
		rcError.GRLOCODI := inuGRLOCODI; --Ticket 200-1090 JGBA -- se almacena ID del registro consultado
    --Ticket 200-1090 JGBA -- se elimina registro de la tabla
		DELETE 	FROM LDC_GRUPO_LOCALIDAD
		WHERE GRLOCODI= inuGRLOCODI;

    IF SQL%notfound THEN
        RAISE no_data_found;
    END IF;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
         RAISE ex.CONTROLLED_ERROR;
		WHEN ex.RECORD_HAVE_CHILDREN THEN
			Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;
	END delRecord;

  PROCEDURE updRecords ( iotbLDC_GRUPO_LOCALIDAD in out nocopy tytbLDC_GRLOCODI ) IS
    /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica varios registros de la tabla LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       iotbLDC_GRUPO_LOCALIDAD Registro de la tabla LDC_GRUPO_LOCALIDAD
      Valor de salida
        iotbLDC_GRUPO_LOCALIDAD  Registro de la tabla LDC_GRUPO_LOCALIDAD

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	BEGIN
		FillRecordOfTables(iotbLDC_GRUPO_LOCALIDAD);

		FORALL n in iotbLDC_GRUPO_LOCALIDAD.first .. iotbLDC_GRUPO_LOCALIDAD.last
		  UPDATE LDC_GRUPO_LOCALIDAD	SET
								GRUPCODI = rcRecOfTab.GRUPCODI(n),
								GRLOIDLO = rcRecOfTab.GRLOIDLO(n),
								GRLOSEOP = rcRecOfTab.GRLOSEOP(n)
		  WHERE  GRLOCODI =  rcRecOfTab.GRLOCODI(n);

	END updRecords;

	 PROCEDURE updGRUPCODI(inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type,
							inuGRUPCODI in LDC_GRUPO_LOCALIDAD.GRUPCODI%type ) IS
      /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica el id del tipo de trabajo dependiendo de ID de la tabla
                     LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       inuGRLOCODI ID de la tabla LDC_GRUPO_LOCALIDAD
       inuGRUPCODI  Id del tipo de trabajo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_GRLOCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1090 JGBA -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1090 JGBA -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1090 JGBA -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1090 JGBA -- se almacena excepcion en caso que el registro no existe

	BEGIN
		rcError.GRLOCODI := inuGRLOCODI; --Ticket 200-1090 JGBA -- se almacena id para manejo de error
		--Ticket 200-1090 JGBA -- se valida si esta abierto el cursor cuRecordGrupo para cerrarlo
		IF cuRecordGrupo%isOPEN THEN
			CLOSE cuRecordGrupo;
		END IF;
        --Ticket 200-1090 JGBA -- se valida si existe el ID del tipo de trabajo
		OPEN cuRecordGrupo	(	inuGRUPCODI	);
		FETCH cuRecordGrupo INTO sdDato;
		IF cuRecordGrupo%notfound  THEN
			CLOSE cuRecordGrupo;
			RAISE erNoExiste;
		END IF;
		CLOSE cuRecordGrupo;
       --Ticket 200-1090 JGBA -- se modifica el codido del tipo de trabajo
		UPDATE LDC_GRUPO_LOCALIDAD
			SET	GRUPCODI = inuGRUPCODI
		WHERE GRLOCODI = inuGRLOCODI;
       --Ticket 200-1090 JGBA -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.GRUPCODI:= inuGRUPCODI;

	EXCEPTION
    WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

		WHEN erNoExiste THEN
        Errors.setError;
        sbMensError := 'Error no Existe Tipo de trabajo con codigo ['||inuGRUPCODI||']';
        Errors.GETERROR(nuErrorCode, sbMensError);
        Errors.SETMESSAGE(sbMensError);
			RAISE ex.CONTROLLED_ERROR;
	END updGRUPCODI;

	PROCEDURE updGRLOIDLO( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type,
                           inuGRLOIDLO in LDC_GRUPO_LOCALIDAD.GRLOIDLO%type) IS
     /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica la actividad de multa por el ID de la tabla
                     LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       inuGRLOCODI ID de la tabla LDC_GRUPO_LOCALIDAD
       inuGRLOIDLO  Id de actividad
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_GRLOCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1090 JGBA -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1090 JGBA -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1090 JGBA -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1090 JGBA -- se almacena excepcion en caso que el registro no existe

	BEGIN
		rcError.GRLOCODI := inuGRLOCODI; --Ticket 200-1090 JGBA -- se almacena id para manejo de error
		--Ticket 200-1090 JGBA -- se valida si esta abierto el cursor cuRecordLocalidad para cerrarlo
		IF cuRecordLocalidad%isOPEN THEN
			CLOSE cuRecordLocalidad;
		END IF;
        --Ticket 200-1090 JGBA -- se valida si existe el ID de la actividad
		OPEN cuRecordLocalidad	(	inuGRLOIDLO	);
		FETCH cuRecordLocalidad INTO sdDato;
		IF cuRecordLocalidad%notfound  THEN
			CLOSE cuRecordLocalidad;
			RAISE erNoExiste;
		END IF;
		CLOSE cuRecordLocalidad;
       --Ticket 200-1090 JGBA -- se modifica el codido de la actividad
		UPDATE LDC_GRUPO_LOCALIDAD
			SET	GRLOIDLO = inuGRLOIDLO
		WHERE GRLOCODI = inuGRLOCODI;
       --Ticket 200-1090 JGBA -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.GRLOIDLO:= inuGRLOIDLO;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

		WHEN erNoExiste THEN
			Errors.setError;
			sbMensError := 'Error no Existe Actividad con codigo ['||inuGRLOIDLO||']';
			Errors.GETERROR(nuErrorCode, sbMensError);
			Errors.SETMESSAGE(sbMensError);
			RAISE ex.CONTROLLED_ERROR;
	END updGRLOIDLO;

	PROCEDURE updGRLOSEOP( inuGRLOCODI in LDC_GRUPO_LOCALIDAD.GRLOCODI%type,
                           inuGRLOSEOP in LDC_GRUPO_LOCALIDAD.GRLOSEOP%type) IS
     /**************************************************************************
      Autor       : Josh Glen Brito Avila / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica la causal de incumplimiento de multa por el ID de la tabla
                     LDC_GRUPO_LOCALIDAD

      Parametros Entrada
       inuGRLOCODI ID de la tabla LDC_GRUPO_LOCALIDAD
       inuGRLOSEOP causal de incumplimiento

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_GRLOCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1090 JGBA -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1090 JGBA -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1090 JGBA -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1090 JGBA -- se almacena excepcion en caso que el registro no existe

	BEGIN
		rcError.GRLOCODI := inuGRLOCODI; --Ticket 200-1090 JGBA -- se almacena id para manejo de error
		--Ticket 200-1090 JGBA -- se valida si esta abierto el cursor cuRecordSectOp para cerrarlo
		IF cuRecordSectOp%isOPEN THEN
			CLOSE cuRecordSectOp;
		END IF;
        --Ticket 200-1090 JGBA -- se valida si existe el ID de causal de incumplimiento
		OPEN cuRecordSectOp	(	inuGRLOSEOP	);
		FETCH cuRecordSectOp INTO sdDato;
		IF cuRecordSectOp%notfound  THEN
			CLOSE cuRecordSectOp;
			RAISE erNoExiste;
		END IF;
		CLOSE cuRecordSectOp;
       --Ticket 200-1090 JGBA -- se modifica el codido de la causal de incumplimiento
		UPDATE LDC_GRUPO_LOCALIDAD
			SET	GRLOSEOP = inuGRLOSEOP
		WHERE GRLOCODI = inuGRLOCODI;
       --Ticket 200-1090 JGBA -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.GRLOSEOP:= inuGRLOSEOP;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

		WHEN erNoExiste THEN
			Errors.setError;
			sbMensError := 'Error no Existe Causal de Incumplimiento con codigo ['||inuGRLOSEOP||']';
			Errors.GETERROR(nuErrorCode, sbMensError);
			Errors.SETMESSAGE(sbMensError);
			RAISE ex.CONTROLLED_ERROR;
	END updGRLOSEOP;




END;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PKGMANTGRUPLOCA
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PKGMANTGRUPLOCA', 'ADM_PERSON');
END;
/