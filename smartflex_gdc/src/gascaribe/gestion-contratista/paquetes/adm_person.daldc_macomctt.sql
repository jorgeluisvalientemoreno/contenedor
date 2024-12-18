CREATE OR REPLACE PACKAGE adm_person.DALDC_MACOMCTT  IS
    
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     :  DALDC_MACOMCTT
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                
    ****************************************************************/   

     /* Cursor general para acceso por Llave Primaria */
    CURSOR cuRecord ( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type ) IS
    SELECT CMTTCODI, CMTTTITR, CMTTACTI, CMTTTIED, CMTTCAIN, CMTTMULT, CMTTVAFI, CMTTFLVV
    FROM LDC_COMCTT
    WHERE CMTTCODI = inuCMTTCODI;

    /* Cursor para validar si existe tipo de  trabajo */
    CURSOR cuRecordTitr ( inuTASK_TYPE_ID in OR_TASK_TYPE.TASK_TYPE_ID%type ) IS
    SELECT 'X'
    FROM OR_TASK_TYPE
    WHERE TASK_TYPE_ID = inuTASK_TYPE_ID;

    /* Cursor para validar si existe actividad */
	CURSOR cuRecordActi( inuITEMS_ID in GE_ITEMS.ITEMS_ID%type ) IS
    SELECT 'X'
    FROM GE_ITEMS
    WHERE ITEMS_ID = inuITEMS_ID;

	  /* Cursor para validar si existe causal de incumplimiento */
	CURSOR cuRecordCausal( inuCAUSAL_ID in GE_CAUSAL.CAUSAL_ID%type ) IS
    SELECT 'X'
    FROM GE_CAUSAL
    WHERE CAUSAL_ID = inuCAUSAL_ID;

	 /* Cursor para validar si existe unidad operativa */
	CURSOR cuRecordUnidOpe( inuOPERATING_UNIT_ID in OR_OPERATING_UNIT.OPERATING_UNIT_ID%type ) IS
    SELECT 'X'
    FROM OR_OPERATING_UNIT
    WHERE OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;



    /* Subtipos */
    subtype styLDC_CMTTCODI  is  cuRecord%rowtype;
    type    tyRefCursor is  REF CURSOR;

    /*Tipos*/
	  type tytbLDC_CMTTCODI is table of styLDC_CMTTCODI index by binary_integer;
	  type tyrfRecords is ref cursor return styLDC_CMTTCODI;


    /* Tipos referenciando al registro */
    type tytbCMTTCODI   is table of LDC_COMCTT.CMTTCODI%type index by binary_integer;
    type tytbCMTTTITR	is table of LDC_COMCTT.CMTTTITR%type index by binary_integer;
    type tytbCMTTACTI 	is table of LDC_COMCTT.CMTTACTI%type index by binary_integer;
	type tytbCMTTTIED   is table of LDC_COMCTT.CMTTTIED%type index by binary_integer;
    type tytbCMTTCAIN	is table of LDC_COMCTT.CMTTCAIN%type index by binary_integer;
    type tytbCMTTMULT 	is table of LDC_COMCTT.CMTTMULT%type index by binary_integer;
	type tytbCMTTVAFI   is table of LDC_COMCTT.CMTTVAFI%type index by binary_integer;
    type tytbCMTTFLVV	is table of LDC_COMCTT.CMTTFLVV%type index by binary_integer;

    /*Registros*/
    type tyrcLDC_COMCTT is record
    (
		CMTTCODI	tytbCMTTCODI,
		CMTTTITR	tytbCMTTTITR,
		CMTTACTI	tytbCMTTACTI,
		CMTTTIED	tytbCMTTTIED,
		CMTTCAIN	tytbCMTTCAIN,
		CMTTMULT	tytbCMTTMULT,
		CMTTVAFI	tytbCMTTVAFI,
		CMTTFLVV	tytbCMTTFLVV
    );


    /***** Metodos Publicos ****/
    FUNCTION fsbVersion  RETURN varchar2;

    FUNCTION fblExist( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type ) RETURN boolean;
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Funcion fblExist, valida si un registro existe en la tabla
                    LDC_COMCTT

      Parametros Entrada
        inuCMTTCODI Id de la tabla
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE getRecordById( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                             orcRecord out nocopy styLDC_CMTTCODI );
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que devuelve un registro por id de la tabla LDC_COMCTT

      Parametros Entrada
        inuCMTTCODI Id de la tabla
      Valor de salida
       orcRecord Cursor de datos de la tabla LDC_COMCTT

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    FUNCTION frcGetRcData(  inuCMTTCODI in LDC_COMCTT.CMTTCODI%type ) RETURN styLDC_CMTTCODI;
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Funcion que retorna un vector de la tabla LDC_COMCTT dependiendo el ID

      Parametros Entrada
        inuCMTTCODI Id de la tabla
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    FUNCTION frcGetRcData RETURN styLDC_CMTTCODI;
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Funcion que retorna un vector de toda la tabla LDC_COMCTT

      Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE insRecords (iotbLDC_COMCTT in out nocopy tytbLDC_CMTTCODI );
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que inserta un registro en la tabla LDC_COMCTT

      Parametros Entrada
       iotbLDC_COMCTT Registro de la tabla LDC_COMCTT
      Valor de salida
        iotbLDC_COMCTT  Registro de la tabla LDC_COMCTT

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE delRecord (inuCMTTCODI in LDC_COMCTT.CMTTCODI%type);
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que elimina un registro en la tabla LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI Id de la tabla LDC_COMCTT
      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE updRecords(iotbLDC_COMCTT in out nocopy tytbLDC_CMTTCODI);
      /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica varios registros de la tabla LDC_COMCTT

      Parametros Entrada
       iotbLDC_COMCTT Registro de la tabla LDC_COMCTT
      Valor de salida
        iotbLDC_COMCTT  Registro de la tabla LDC_COMCTT

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	  PROCEDURE updCMTTTITR(inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
							inuCMTTTITR in LDC_COMCTT.CMTTTITR%type );
      /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el id del tipo de trabajo dependiendo de ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTTITR  Id del tipo de trabajo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE updCMTTACTI( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTACTI in LDC_COMCTT.CMTTACTI%type);
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica la actividad de multa por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTACTI  Id de actividad
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	PROCEDURE updCMTTTIED( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTTIED in LDC_COMCTT.CMTTTIED%type);
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el tiempo en dia de multa por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTTIED tiempo en dia para multar
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

	PROCEDURE updCMTTCAIN( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTCAIN in LDC_COMCTT.CMTTCAIN%type);
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica la causal de incumplimiento de multa por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTCAIN causal de incumplimiento

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

	PROCEDURE updCMTTMULT( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTMULT in LDC_COMCTT.CMTTMULT%type);
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el multiplicador  de multa por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTMULT causal de incumplimiento

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/


	PROCEDURE updCMTTVAFI( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTVAFI in LDC_COMCTT.CMTTVAFI%type);
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el valor fijo de la multa  por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTVAFI valor fijo de la multa

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/


	PROCEDURE updCMTTFLVV( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTFLVV in LDC_COMCTT.CMTTFLVV%type);
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el flag si el tipo de trabajo es visita de venta  por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTFLVV flag que indica si es visita de venta

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/


    PROCEDURE SetUseCache(iblUseCache    in  boolean);
      /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que setea si se maneja o no cache

      Parametros Entrada
       iblUseCache   flag que indica si se maneja o no cache
      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
END;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_MACOMCTT  IS

  csbVersion                CONSTANT VARCHAR2(20) := 'CRM_VEN_LJLB_2001132_1'; --Ticket 200-1132 LJLB -- se crea constante para almacenar version del programa
  cnuRECORD_NOT_EXIST       CONSTANT NUMBER(1)    := 1;                --Ticket 200-1132 LJLB -- se crea constante para almacenar el codigo de error si no existe registro
  cnuRECORD_ALREADY_EXIST   CONSTANT NUMBER(1)    := 2;                --Ticket 200-1132 LJLB -- se crea constante para almacenar el codigo de error si existe registro
  csbTABLEPARAMETER         CONSTANT VARCHAR2(30) := 'LDC_COMCTT';   --Ticket 200-1132 LJLB -- se crea constante para almacenar el nombre de ta tabla
  cnuGeEntityId             CONSTANT VARCHAR2(30) := 4174;             --Ticket 200-1132 LJLB -- se crea constante para almacenar ID de la tabla en GE_ENTITY
  cnuRECORD_HAVE_CHILDREN   CONSTANT NUMBER(4)    := -2292;            --Ticket 200-1132 LJLB -- se crea constante para manejo de llaves foraneas
  blDAO_USE_CACHE           BOOLEAN := null;                           --Ticket 200-1132 LJLB -- se crea flag para manejo de cache
  rcRecOfTab                tyrcLDC_COMCTT;                          --Ticket 200-1132 LJLB -- se crea registro de type tyrcLDC_COMCTT
  rcData                    cuRecord%rowtype;                          --Ticket 200-1132 LJLB -- se crea registro de type cuRecord
  FUNCTION fsbVersion RETURN VARCHAR2 iS
   /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
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
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Procedimento que se encarga de setear el flag de cache

    Parametros Entrada
      iblUseCache   Flag que indica si se aneja cache o no
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	BEGIN
	    blDAO_USE_CACHE := iblUseCache; --Ticket 200-1132 LJLB -- se setea nuevo valor para el flag
	END;

	FUNCTION fsbGetMessageDescription	RETURN VARCHAR2 IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Funcion que se encarga de mostrar la descripcion  de la tabla LDC_COMCTT

    Parametros Entrada
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  sbTableDescription VARCHAR2(4000); --Ticket 200-1132 LJLB -- se almacena el id de la tabla LDC_COMCTT

  BEGIN
    --Ticket 200-1132 LJLB -- se valida si al entidad existe en GE_ENTITY
    IF (cnuGeEntityId > 0 AND dage_entity.fblExist (cnuGeEntityId))  THEN
          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
    ELSE
          sbTableDescription:= csbTABLEPARAMETER;
    END IF;

		RETURN sbTableDescription ;
	END;

  FUNCTION fsbPrimaryKey( rcI in styLDC_CMTTCODI default rcData )	RETURN VARCHAR2 IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Funcion que se encarga de mostrar la llave primaria de la tabla LDC_COMCTT

    Parametros Entrada
     rcI   Tabla PL de LDC_COMCTT
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
		sbPk VARCHAR2(500); --Ticket 200-1132 LJLB -- se almacena el id de la tabla LDC_COMCTT
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.CMTTCODI);
		sbPk:=sbPk||']';
		RETURN sbPk;
	END;
   PROCEDURE DelRecordOfTables	IS
   /**************************************************************************
		Autor       : Luis Javier Lopez Barrios / Horbath
		Fecha       : 2017-03-24
		Ticket      : 200-1132
		Descripcion : Procedimiento que se encarga de limpiar la tabla PL rcRecOfTab

		Parametros Entrada
		Valor de salida

		HISTORIA DE MODIFICACIONES
		FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
   BEGIN
			rcRecOfTab.CMTTCODI.delete;
			rcRecOfTab.CMTTTITR.delete;
			rcRecOfTab.CMTTACTI.delete;
			rcRecOfTab.CMTTTIED.delete;
			rcRecOfTab.CMTTCAIN.delete;
			rcRecOfTab.CMTTMULT.delete;
			rcRecOfTab.CMTTVAFI.delete;
			rcRecOfTab.CMTTFLVV.delete;


  END;

  PROCEDURE FillRecordOfTables ( itbLDC_CMTTCODI in out nocopy tytbLDC_CMTTCODI ) IS
   /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Procedimiento que se encarga de copiar los registros a la tabla PL rcRecOfTab

    Parametros Entrada
      itbLDC_CMTTCODI Tabla PL de LDC_COMCTT
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	BEGIN
		DelRecordOfTables; --Ticket 200-1132 LJLB -- elimina los datos de la tabla PL rcRecOfTab

   --Ticket 200-1132 LJLB -- consulta los registros de la tabla  PL itbLDC_CMTTCODI
		FOR n IN itbLDC_CMTTCODI.FIRST .. itbLDC_CMTTCODI.LAST LOOP
			rcRecOfTab.CMTTCODI(n) := itbLDC_CMTTCODI(n).CMTTCODI;
			rcRecOfTab.CMTTTITR(n) := itbLDC_CMTTCODI(n).CMTTTITR;
			rcRecOfTab.CMTTACTI(n) := itbLDC_CMTTCODI(n).CMTTACTI;
			rcRecOfTab.CMTTTIED(n) := itbLDC_CMTTCODI(n).CMTTTIED;
			rcRecOfTab.CMTTCAIN(n) := itbLDC_CMTTCODI(n).CMTTCAIN;
			rcRecOfTab.CMTTMULT(n) := itbLDC_CMTTCODI(n).CMTTMULT;
			rcRecOfTab.CMTTVAFI(n) := itbLDC_CMTTCODI(n).CMTTVAFI;
			rcRecOfTab.CMTTFLVV(n) := itbLDC_CMTTCODI(n).CMTTFLVV;

		END LOOP;
	END;

  PROCEDURE LOAD ( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type )	IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Procedimiento que carga los registro en memoria dependiendo el ID de la tabla
                  LDC_COMCTT

    Parametros Entrada
      inuCMTTCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se crea registro para los errores
		rcRecordNull cuRecord%rowtype;  --Ticket 200-1132 LJLB -- Almacena una tabla pl vacia
	BEGIN
    rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena id del registro consultado

		--Ticket 200-1132 LJLB -- valida si el cursor cuRecord esta abierto para cerrarlo
    IF cuRecord%isOPEN THEN
			CLOSE cuRecord;
		END IF;
    --Ticket 200-1132 LJLB -- se carga la inFORmacion por ID
		OPEN cuRecord ( inuCMTTCODI );
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

  FUNCTION fblAlreadyLoaded (inuCMTTCODI in LDC_COMCTT.CMTTCODI%type )RETURN BOOLEAN
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Funcion fblAlreadyLoaded, valida si un registro ya esta cargado  en memoria

    Parametros Entrada
      inuCMTTCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	IS

  BEGIN
    --Ticket 200-1132 LJLB -- valida si el ID  a buscar ya esta cargado en memoria
		IF ( inuCMTTCODI = rcData.CMTTCODI ) THEN
			RETURN ( TRUE );
		END IF;
		RETURN (FALSE);
	END;


   FUNCTION fblExist ( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type ) RETURN BOOLEAN IS
   /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Funcion fblExist, valida si un registro existe en la tabla
                  LDC_COMCTT

    Parametros Entrada
      inuCMTTCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
	BEGIN
		--Ticket 200-1132 LJLB -- se consulta registro en la BD
    LOAD ( inuCMTTCODI );

		RETURN (TRUE); --Ticket 200-1132 LJLB -- retorna verdadero si existe
	EXCEPTION
		WHEN no_data_found THEN
			RETURN (FALSE);
  END fblExist;

  PROCEDURE getRecordById  (  inuCMTTCODI IN LDC_COMCTT.CMTTCODI%TYPE,
                              orcRecord OUT NOCOPY styLDC_CMTTCODI  )    IS
 	 /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que devuelve un registro por id de la tabla LDC_COMCTT

      Parametros Entrada
        inuCMTTCODI Id de la tabla
      Valor de salida
       orcRecord Cursor de datos de la tabla LDC_COMCTT

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

    rcError styLDC_CMTTCODI;  --Ticket 200-1132 LJLB -- se Crea registro para manejar error
	BEGIN
     rcError.CMTTCODI := inuCMTTCODI;  --Ticket 200-1132 LJLB -- se almacena ID del registro consultado
    --Ticket 200-1132 LJLB -- se consulta registro en la BD
		LOAD ( inuCMTTCODI );
		orcRecord := rcData;
	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;
  END getRecordById;

  FUNCTION frcGetRcData( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type )  RETURN styLDC_CMTTCODI IS
   /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Funcion que retorna un vector de la tabla LDC_COMCTT dependiendo el ID

    Parametros Entrada
      inuCMTTCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

    rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error
	BEGIN
		rcError.CMTTCODI:=inuCMTTCODI;  --Ticket 200-1132 LJLB -- se almacena ID del registro consultado
    --Ticket 200-1132 LJLB --se valida si usa cache y esta cargado retorna
	  IF  blDAO_USE_CACHE AND fblAlreadyLoaded ( inuCMTTCODI )	THEN
		  RETURN(rcData);
		END IF;
    --Ticket 200-1132 LJLB -- se consulta registro en la BD
		LOAD ( inuCMTTCODI );
		RETURN(rcData);
	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;
	END frcGetRcData;

  FUNCTION frcGetRcData RETURN styLDC_CMTTCODI IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Funcion que retorna un vector de toda la tabla LDC_COMCTT

      Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

	BEGIN
		RETURN(rcData);
	END frcGetRcData;

  PROCEDURE insRecords ( iotbLDC_COMCTT in out nocopy tytbLDC_CMTTCODI )	IS
   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que inserta un registro en la tabla LDC_COMCTT

      Parametros Entrada
       iotbLDC_COMCTT Registro de la tabla LDC_COMCTT
      Valor de salida
        iotbLDC_COMCTT  Registro de la tabla LDC_COMCTT

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

	BEGIN
		FillRecordOfTables(iotbLDC_COMCTT); --Ticket 200-1132 LJLB -- se cargan los registro en memoria
		FORALL n in iotbLDC_COMCTT.first..iotbLDC_COMCTT.last
				INSERT INTO LDC_COMCTT
								  ( CMTTCODI,
									CMTTTITR,
									CMTTACTI,
									CMTTTIED,
									CMTTCAIN,
									CMTTMULT,
									CMTTVAFI,
									CMTTFLVV
								  )
			VALUES
						(
						 rcRecOfTab.CMTTCODI(n),
						 rcRecOfTab.CMTTTITR(n),
						 rcRecOfTab.CMTTACTI(n),
						 rcRecOfTab.CMTTTIED(n),
						 rcRecOfTab.CMTTCAIN(n),
						 rcRecOfTab.CMTTMULT(n),
						 rcRecOfTab.CMTTVAFI(n),
						 rcRecOfTab.CMTTFLVV(n)
						);

	EXCEPTION
		WHEN dup_val_on_index THEN
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			RAISE ex.CONTROLLED_ERROR;
	END insRecords;

  PROCEDURE delRecord ( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type ) IS
  /**************************************************************************
    Autor       : Luis Javier Lopez Barrios / Horbath
    Fecha       : 2017-03-24
    Ticket      : 200-1132
    Descripcion : Procedimiento que elimina un registro en la tabla LDC_COMCTT

    Parametros Entrada
     inuCMTTCODI Id de la tabla LDC_COMCTT
    Valor de salida


    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

		rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error
	BEGIN
		rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena ID del registro consultado
    --Ticket 200-1132 LJLB -- se elimina registro de la tabla
		DELETE 	FROM LDC_COMCTT
		WHERE CMTTCODI= inuCMTTCODI;

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

  PROCEDURE updRecords ( iotbLDC_COMCTT in out nocopy tytbLDC_CMTTCODI ) IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica varios registros de la tabla LDC_COMCTT

      Parametros Entrada
       iotbLDC_COMCTT Registro de la tabla LDC_COMCTT
      Valor de salida
        iotbLDC_COMCTT  Registro de la tabla LDC_COMCTT

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	BEGIN
		FillRecordOfTables(iotbLDC_COMCTT);

		FORALL n in iotbLDC_COMCTT.first .. iotbLDC_COMCTT.last
		  UPDATE LDC_COMCTT	SET
								CMTTTITR = rcRecOfTab.CMTTTITR(n),
								CMTTACTI = rcRecOfTab.CMTTACTI(n),
								CMTTTIED = rcRecOfTab.CMTTTIED(n),
								CMTTCAIN = rcRecOfTab.CMTTCAIN(n),
								CMTTMULT = rcRecOfTab.CMTTMULT(n),
								CMTTVAFI = rcRecOfTab.CMTTVAFI(n),
								CMTTFLVV = rcRecOfTab.CMTTFLVV(n)
		  WHERE  CMTTCODI =  rcRecOfTab.CMTTCODI(n);

	END updRecords;

	 PROCEDURE updCMTTTITR(inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
							inuCMTTTITR in LDC_COMCTT.CMTTTITR%type ) IS
      /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el id del tipo de trabajo dependiendo de ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTTITR  Id del tipo de trabajo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1132 LJLB -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1132 LJLB -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1132 LJLB -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1132 LJLB -- se almacena excepcion en caso que el registro no existe

	BEGIN
		rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena id para manejo de error
		--Ticket 200-1132 LJLB -- se valida si esta abierto el cursor cuRecordTitr para cerrarlo
		IF cuRecordTitr%isOPEN THEN
			CLOSE cuRecordTitr;
		END IF;
        --Ticket 200-1132 LJLB -- se valida si existe el ID del tipo de trabajo
		OPEN cuRecordTitr	(	inuCMTTTITR	);
		FETCH cuRecordTitr INTO sdDato;
		IF cuRecordTitr%notfound  THEN
			CLOSE cuRecordTitr;
			RAISE erNoExiste;
		END IF;
		CLOSE cuRecordTitr;
       --Ticket 200-1132 LJLB -- se modifica el codido del tipo de trabajo
		UPDATE LDC_COMCTT
			SET	CMTTTITR = inuCMTTTITR
		WHERE CMTTCODI = inuCMTTCODI;
       --Ticket 200-1132 LJLB -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.CMTTTITR:= inuCMTTTITR;

	EXCEPTION
    WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

		WHEN erNoExiste THEN
        Errors.setError;
        sbMensError := 'Error no Existe Tipo de trabajo con codigo ['||inuCMTTTITR||']';
        Errors.GETERROR(nuErrorCode, sbMensError);
        Errors.SETMESSAGE(sbMensError);
			RAISE ex.CONTROLLED_ERROR;
	END updCMTTTITR;

	PROCEDURE updCMTTACTI( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTACTI in LDC_COMCTT.CMTTACTI%type) IS
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica la actividad de multa por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTACTI  Id de actividad
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1132 LJLB -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1132 LJLB -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1132 LJLB -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1132 LJLB -- se almacena excepcion en caso que el registro no existe

	BEGIN
		rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena id para manejo de error
		--Ticket 200-1132 LJLB -- se valida si esta abierto el cursor cuRecordActi para cerrarlo
		IF cuRecordActi%isOPEN THEN
			CLOSE cuRecordActi;
		END IF;
        --Ticket 200-1132 LJLB -- se valida si existe el ID de la actividad
		OPEN cuRecordActi	(	inuCMTTACTI	);
		FETCH cuRecordActi INTO sdDato;
		IF cuRecordActi%notfound  THEN
			CLOSE cuRecordActi;
			RAISE erNoExiste;
		END IF;
		CLOSE cuRecordActi;
       --Ticket 200-1132 LJLB -- se modifica el codido de la actividad
		UPDATE LDC_COMCTT
			SET	CMTTACTI = inuCMTTACTI
		WHERE CMTTCODI = inuCMTTCODI;
       --Ticket 200-1132 LJLB -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.CMTTACTI:= inuCMTTACTI;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

		WHEN erNoExiste THEN
			Errors.setError;
			sbMensError := 'Error no Existe Actividad con codigo ['||inuCMTTACTI||']';
			Errors.GETERROR(nuErrorCode, sbMensError);
			Errors.SETMESSAGE(sbMensError);
			RAISE ex.CONTROLLED_ERROR;
	END updCMTTACTI;

	PROCEDURE updCMTTTIED( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTTIED in LDC_COMCTT.CMTTTIED%type) IS
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el tiempo en dia de multa por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTTIED tiempo en dia para multar
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1132 LJLB -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1132 LJLB -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1132 LJLB -- se almacena descripcion del error


	BEGIN
		rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena id para manejo de error

		--Ticket 200-1132 LJLB -- se modifica el tiempo en dias para multar
		UPDATE LDC_COMCTT
			SET	CMTTTIED = inuCMTTTIED
		WHERE CMTTCODI = inuCMTTCODI;
       --Ticket 200-1132 LJLB -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.CMTTTIED:= inuCMTTTIED;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

	END updCMTTTIED;
	PROCEDURE updCMTTCAIN( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTCAIN in LDC_COMCTT.CMTTCAIN%type) IS
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica la causal de incumplimiento de multa por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTCAIN causal de incumplimiento

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1132 LJLB -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1132 LJLB -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1132 LJLB -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1132 LJLB -- se almacena excepcion en caso que el registro no existe

	BEGIN
		rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena id para manejo de error
		--Ticket 200-1132 LJLB -- se valida si esta abierto el cursor cuRecordCausal para cerrarlo
		IF cuRecordCausal%isOPEN THEN
			CLOSE cuRecordCausal;
		END IF;
        --Ticket 200-1132 LJLB -- se valida si existe el ID de causal de incumplimiento
		OPEN cuRecordCausal	(	inuCMTTCAIN	);
		FETCH cuRecordCausal INTO sdDato;
		IF cuRecordCausal%notfound  THEN
			CLOSE cuRecordCausal;
			RAISE erNoExiste;
		END IF;
		CLOSE cuRecordCausal;
       --Ticket 200-1132 LJLB -- se modifica el codido de la causal de incumplimiento
		UPDATE LDC_COMCTT
			SET	CMTTCAIN = inuCMTTCAIN
		WHERE CMTTCODI = inuCMTTCODI;
       --Ticket 200-1132 LJLB -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.CMTTCAIN:= inuCMTTCAIN;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

		WHEN erNoExiste THEN
			Errors.setError;
			sbMensError := 'Error no Existe Causal de Incumplimiento con codigo ['||inuCMTTCAIN||']';
			Errors.GETERROR(nuErrorCode, sbMensError);
			Errors.SETMESSAGE(sbMensError);
			RAISE ex.CONTROLLED_ERROR;
	END updCMTTCAIN;

	PROCEDURE updCMTTMULT( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTMULT in LDC_COMCTT.CMTTMULT%type) IS
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el multiplicador  de multa por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTMULT multiplicador

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1132 LJLB -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1132 LJLB -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1132 LJLB -- se almacena descripcion del error

	BEGIN
		rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena id para manejo de error

       --Ticket 200-1132 LJLB -- se modifica el multiplicador de la multa
		UPDATE LDC_COMCTT
			SET	CMTTMULT = inuCMTTMULT
		WHERE CMTTCODI = inuCMTTCODI;
       --Ticket 200-1132 LJLB -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.CMTTMULT:= inuCMTTMULT;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

	END updCMTTMULT;

	PROCEDURE updCMTTVAFI( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTVAFI in LDC_COMCTT.CMTTVAFI%type) IS
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el valor fijo de la multa  por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTVAFI valor fijo de la multa

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
	rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1132 LJLB -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1132 LJLB -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1132 LJLB -- se almacena descripcion del error

	BEGIN
		rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena id para manejo de error

       --Ticket 200-1132 LJLB -- se modifica el valor fijo de la multa
		UPDATE LDC_COMCTT
			SET	CMTTVAFI = inuCMTTVAFI
		WHERE CMTTCODI = inuCMTTCODI;
       --Ticket 200-1132 LJLB -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.CMTTVAFI:= inuCMTTVAFI;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

	END updCMTTVAFI;

	PROCEDURE updCMTTFLVV( inuCMTTCODI in LDC_COMCTT.CMTTCODI%type,
                           inuCMTTFLVV in LDC_COMCTT.CMTTFLVV%type) IS
     /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-03-24
      Ticket      : 200-1132
      Descripcion : Procedimiento que modifica el flag si el tipo de trabajo es visita de venta  por el ID de la tabla
                     LDC_COMCTT

      Parametros Entrada
       inuCMTTCODI ID de la tabla LDC_COMCTT
       inuCMTTFLVV flag que indica si es visita de venta

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
		rcError styLDC_CMTTCODI; --Ticket 200-1132 LJLB -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1132 LJLB -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1132 LJLB -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1132 LJLB -- se almacena descripcion del error

	BEGIN
		rcError.CMTTCODI := inuCMTTCODI; --Ticket 200-1132 LJLB -- se almacena id para manejo de error

       --Ticket 200-1132 LJLB -- se modifica el flag de si es visita de venta
		UPDATE LDC_COMCTT
			SET	CMTTFLVV = inuCMTTFLVV
		WHERE CMTTCODI = inuCMTTCODI;
       --Ticket 200-1132 LJLB -- se valida si se hizo o no la sentencia DML
		IF sql%notfound THEN
			RAISE no_data_found;
		END IF;

		rcData.CMTTFLVV:= inuCMTTFLVV;

	EXCEPTION
		WHEN no_data_found THEN
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			RAISE ex.CONTROLLED_ERROR;

	END updCMTTFLVV;




END;
/
PROMPT Otorgando permisos de ejecucion a DALDC_MACOMCTT
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_MACOMCTT', 'ADM_PERSON');
END;
/