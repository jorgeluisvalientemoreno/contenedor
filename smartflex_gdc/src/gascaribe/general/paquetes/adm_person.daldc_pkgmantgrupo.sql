CREATE OR REPLACE PACKAGE adm_person.DALDC_PKGMANTGRUPO IS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_PKGMANTGRUPO
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                
    ****************************************************************/   
    
     /* Cursor general para acceso por Llave Primaria */
    CURSOR cuRecord ( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type ) IS
    SELECT GRUPCODI, GRUPDESC, GRUPTAMU, VIGENCIA_INIT_DATE, VIGENCIA_FINAL_DATE
    FROM LDC_GRUPO
    WHERE GRUPCODI = inuGRUPCODI;



    /* Subtipos */
    subtype styLDC_GRUPCODI  is  cuRecord%rowtype;
    type    tyRefCursor is  REF CURSOR;

    /*Tipos*/
    type tytbLDC_GRUPCODI is table of styLDC_GRUPCODI index by binary_integer;
    type tyrfRecords is ref cursor return styLDC_GRUPCODI;


    /* Tipos referenciando al registro */
    type tytbGRUPCODI   is table of LDC_GRUPO.GRUPCODI%type index by binary_integer;
    type tytbGRUPDESC is table of LDC_GRUPO.GRUPDESC%type index by binary_integer;
    type tytbGRUPTAMU   is table of LDC_GRUPO.GRUPTAMU%type index by binary_integer;
    type tytbVIGENCIA_INIT_DATE   is table of LDC_GRUPO.VIGENCIA_INIT_DATE%type index by binary_integer;
    type tytbVIGENCIA_FINAL_DATE  is table of LDC_GRUPO.VIGENCIA_FINAL_DATE%type index by binary_integer;


    /*Registros*/
    type tyrcLDC_GRUPO is record
    (
    GRUPCODI  tytbGRUPCODI,
    GRUPDESC  tytbGRUPDESC,
    GRUPTAMU  tytbGRUPTAMU,
    VIGENCIA_INIT_DATE tytbVIGENCIA_INIT_DATE,
    VIGENCIA_FINAL_DATE tytbVIGENCIA_FINAL_DATE
    );


    /***** Metodos Publicos ****/
    FUNCTION fsbVersion  RETURN varchar2;

    FUNCTION fblExist( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type ) RETURN boolean;
    /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Funcion fblExist, valida si un registro existe en la tabla
                    LDC_GRUPO

      Parametros Entrada
        inuGRUPCODI Id de la tabla
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE getRecordById( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
                             orcRecord out nocopy styLDC_GRUPCODI );
    /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que devuelve un registro por id de la tabla LDC_GRUPO

      Parametros Entrada
        inuGRUPCODI Id de la tabla
      Valor de salida
       orcRecord Cursor de datos de la tabla LDC_GRUPO

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    FUNCTION frcGetRcData(  inuGRUPCODI in LDC_GRUPO.GRUPCODI%type ) RETURN styLDC_GRUPCODI;
    /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Funcion que retorna un vector de la tabla LDC_GRUPO dependiendo el ID

      Parametros Entrada
        inuGRUPCODI Id de la tabla
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    FUNCTION frcGetRcData RETURN styLDC_GRUPCODI;
    /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Funcion que retorna un vector de toda la tabla LDC_GRUPO

      Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE insRecords (iotbLDC_GRUPO in out nocopy tytbLDC_GRUPCODI );
    /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que inserta un registro en la tabla LDC_GRUPO

      Parametros Entrada
       iotbLDC_GRUPO Registro de la tabla LDC_GRUPO
      Valor de salida
        iotbLDC_GRUPO  Registro de la tabla LDC_GRUPO

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE delRecord (inuGRUPCODI in LDC_GRUPO.GRUPCODI%type);
    /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que elimina un registro en la tabla LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI Id de la tabla LDC_GRUPO
      Valor de salida


      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

    PROCEDURE updRecords(iotbLDC_GRUPO in out nocopy tytbLDC_GRUPCODI);
      /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica varios registros de la tabla LDC_GRUPO

      Parametros Entrada
       iotbLDC_GRUPO Registro de la tabla LDC_GRUPO
      Valor de salida
        iotbLDC_GRUPO  Registro de la tabla LDC_GRUPO

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE updGRUPDESC(inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
              inuGRUPDESC in LDC_GRUPO.GRUPDESC%type);
      /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica la descripcion dependiendo de ID de la tabla
                     LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI ID de la tabla LDC_GRUPO
       inuGRUPDESC  descripcin del grupo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE updGRUPTAMU( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
                           inuGRUPTAMU in LDC_GRUPO.GRUPTAMU%type);
      /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica la muestra dependiendo de ID de la tabla
                     LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI ID de la tabla LDC_GRUPO
       inuGRUPDESC  descripcin del grupo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE updVIGENCIA_INIT_DATE( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
                           inuVIGENCIA_INIT_DATE in LDC_GRUPO.VIGENCIA_INIT_DATE%type);
      /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica la fecha inicial de vigencia dependiendo de ID de la tabla
                     LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI ID de la tabla LDC_GRUPO
       inuGRUPDESC  descripcin del grupo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE updVIGENCIA_FINAL_DATE( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
                           inuVIGENCIA_FINAL_DATE in LDC_GRUPO.VIGENCIA_FINAL_DATE%type);
     /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento tamaÃ±o de la fecha final de vigencia por el ID de la tabla
                     LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI ID de la tabla LDC_GRUPO
       inuGRUPTAMU tamaÃ±o de la muestra
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/


    PROCEDURE SetUseCache(iblUseCache    in  boolean);
      /**************************************************************************
      Autor       : Josh Brito / Horbath
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
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_PKGMANTGRUPO IS

  csbVersion                CONSTANT VARCHAR2(20) := 'OSS_MAN_JGBA_2001090_1'; --Ticket 200-1090 JGBA -- se crea constante para almacenar version del programa
  cnuRECORD_NOT_EXIST       CONSTANT NUMBER(1)    := 1;                --Ticket 200-1090 JGBA -- se crea constante para almacenar el codigo de error si no existe registro
  cnuRECORD_ALREADY_EXIST   CONSTANT NUMBER(1)    := 2;                --Ticket 200-1090 JGBA -- se crea constante para almacenar el codigo de error si existe registro
  csbTABLEPARAMETER         CONSTANT VARCHAR2(30) := 'LDC_GRUPO';   --Ticket 200-1090 JGBA -- se crea constante para almacenar el nombre de ta tabla
  cnuGeEntityId             CONSTANT VARCHAR2(30) := 4174;             --Ticket 200-1090 JGBA -- se crea constante para almacenar ID de la tabla en GE_ENTITY
  cnuRECORD_HAVE_CHILDREN   CONSTANT NUMBER(4)    := -2292;            --Ticket 200-1090 JGBA -- se crea constante para manejo de llaves foraneas
  blDAO_USE_CACHE           BOOLEAN := null;                           --Ticket 200-1090 JGBA -- se crea flag para manejo de cache
  rcRecOfTab                tyrcLDC_GRUPO;                          --Ticket 200-1090 JGBA -- se crea registro de type tyrcLDC_GRUPO
  rcData                    cuRecord%rowtype;                          --Ticket 200-1090 JGBA -- se crea registro de type cuRecord
  FUNCTION fsbVersion RETURN VARCHAR2 iS
   /**************************************************************************
    Autor       : Josh Brito / Horbath
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

  PROCEDURE SetUseCache ( iblUseCache in  BOOLEAN ) IS
  /**************************************************************************
    Autor       : Josh Brito / Horbath
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

  FUNCTION fsbGetMessageDescription RETURN VARCHAR2 IS
  /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion que se encarga de mostrar la descripcion  de la tabla LDC_GRUPO

    Parametros Entrada
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

  sbTableDescription VARCHAR2(4000); --Ticket 200-1090 JGBA -- se almacena el id de la tabla LDC_GRUPO

  BEGIN
    --Ticket 200-1090 JGBA -- se valida si al entidad existe en GE_ENTITY
    IF (cnuGeEntityId > 0 AND dage_entity.fblExist (cnuGeEntityId))  THEN
          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
    ELSE
          sbTableDescription:= csbTABLEPARAMETER;
    END IF;

    RETURN sbTableDescription ;
  END;

  FUNCTION fsbPrimaryKey( rcI in styLDC_GRUPCODI default rcData ) RETURN VARCHAR2 IS
  /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion que se encarga de mostrar la llave primaria de la tabla LDC_GRUPO

    Parametros Entrada
     rcI   Tabla PL de LDC_GRUPO
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    sbPk VARCHAR2(500); --Ticket 200-1090 JGBA -- se almacena el id de la tabla LDC_GRUPO
  BEGIN
    sbPk:='[';
    sbPk:=sbPk||ut_convert.fsbToChar(rcI.GRUPCODI);
    sbPk:=sbPk||']';
    RETURN sbPk;
  END;
   PROCEDURE DelRecordOfTables  IS
   /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Procedimiento que se encarga de limpiar la tabla PL rcRecOfTab

    Parametros Entrada
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
   BEGIN
      rcRecOfTab.GRUPCODI.delete;
      rcRecOfTab.GRUPDESC.delete;
      rcRecOfTab.GRUPTAMU.delete;
      rcRecOfTab.VIGENCIA_INIT_DATE.delete;
      rcRecOfTab.VIGENCIA_FINAL_DATE.delete;

  END;

  PROCEDURE FillRecordOfTables ( itbLDC_GRUPCODI in out nocopy tytbLDC_GRUPCODI ) IS
   /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Procedimiento que se encarga de copiar los registros a la tabla PL rcRecOfTab

    Parametros Entrada
      itbLDC_GRUPCODI Tabla PL de LDC_GRUPO
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  BEGIN
    DelRecordOfTables; --Ticket 200-1090 JGBA -- elimina los datos de la tabla PL rcRecOfTab

   --Ticket 200-1090 JGBA -- consulta los registros de la tabla  PL itbLDC_GRUPCODI
    FOR n IN itbLDC_GRUPCODI.FIRST .. itbLDC_GRUPCODI.LAST LOOP
      rcRecOfTab.GRUPCODI(n) := itbLDC_GRUPCODI(n).GRUPCODI;
      rcRecOfTab.GRUPDESC(n) := itbLDC_GRUPCODI(n).GRUPDESC;
      rcRecOfTab.GRUPTAMU(n) := itbLDC_GRUPCODI(n).GRUPTAMU;
      rcRecOfTab.VIGENCIA_INIT_DATE(n) := itbLDC_GRUPCODI(n).VIGENCIA_INIT_DATE;
      rcRecOfTab.VIGENCIA_FINAL_DATE(n) := itbLDC_GRUPCODI(n).VIGENCIA_FINAL_DATE;
    END LOOP;
  END;

  PROCEDURE LOAD ( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type ) IS
  /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Procedimiento que carga los registro en memoria dependiendo el ID de la tabla
                  LDC_GRUPO

    Parametros Entrada
      inuGRUPCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
    rcError styLDC_GRUPCODI; --Ticket 200-1090 JGBA -- se crea registro para los errores
    rcRecordNull cuRecord%rowtype;  --Ticket 200-1090 JGBA -- Almacena una tabla pl vacia
  BEGIN
    rcError.GRUPCODI := inuGRUPCODI; --Ticket 200-1090 JGBA -- se almacena id del registro consultado

    --Ticket 200-1090 JGBA -- valida si el cursor cuRecord esta abierto para cerrarlo
    IF cuRecord%isOPEN THEN
      CLOSE cuRecord;
    END IF;
    --Ticket 200-1090 JGBA -- se carga la inFORmacion por ID
    OPEN cuRecord ( inuGRUPCODI );
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

  FUNCTION fblAlreadyLoaded (inuGRUPCODI in LDC_GRUPO.GRUPCODI%type )RETURN BOOLEAN
  /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion fblAlreadyLoaded, valida si un registro ya esta cargado  en memoria

    Parametros Entrada
      inuGRUPCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  IS

  BEGIN
    --Ticket 200-1090 JGBA -- valida si el ID  a buscar ya esta cargado en memoria
    IF ( inuGRUPCODI = rcData.GRUPCODI ) THEN
      RETURN ( TRUE );
    END IF;
    RETURN (FALSE);
  END;


   FUNCTION fblExist ( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type ) RETURN BOOLEAN IS
   /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion fblExist, valida si un registro existe en la tabla
                  LDC_GRUPO

    Parametros Entrada
      inuGRUPCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/
  BEGIN
    --Ticket 200-1090 JGBA -- se consulta registro en la BD
    LOAD ( inuGRUPCODI );

    RETURN (TRUE); --Ticket 200-1090 JGBA -- retorna verdadero si existe
  EXCEPTION
    WHEN no_data_found THEN
      RETURN (FALSE);
  END fblExist;

  PROCEDURE getRecordById  (  inuGRUPCODI IN LDC_GRUPO.GRUPCODI%TYPE,
                              orcRecord OUT NOCOPY styLDC_GRUPCODI  )    IS
   /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que devuelve un registro por id de la tabla LDC_GRUPO

      Parametros Entrada
        inuGRUPCODI Id de la tabla
      Valor de salida
       orcRecord Cursor de datos de la tabla LDC_GRUPO

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/

    rcError styLDC_GRUPCODI;  --Ticket 200-1090 JGBA -- se Crea registro para manejar error
  BEGIN
     rcError.GRUPCODI := inuGRUPCODI;  --Ticket 200-1090 JGBA -- se almacena ID del registro consultado
    --Ticket 200-1090 JGBA -- se consulta registro en la BD
    LOAD ( inuGRUPCODI );
    orcRecord := rcData;
  EXCEPTION
    WHEN no_data_found THEN
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      RAISE ex.CONTROLLED_ERROR;
  END getRecordById;

  FUNCTION frcGetRcData( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type )  RETURN styLDC_GRUPCODI IS
   /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Funcion que retorna un vector de la tabla LDC_GRUPO dependiendo el ID

    Parametros Entrada
      inuGRUPCODI Id de la tabla
    Valor de salida

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

    rcError styLDC_GRUPCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error
  BEGIN
    rcError.GRUPCODI:=inuGRUPCODI;  --Ticket 200-1090 JGBA -- se almacena ID del registro consultado
    --Ticket 200-1090 JGBA --se valida si usa cache y esta cargado retorna
    IF  blDAO_USE_CACHE AND fblAlreadyLoaded ( inuGRUPCODI )  THEN
      RETURN(rcData);
    END IF;
    --Ticket 200-1090 JGBA -- se consulta registro en la BD
    LOAD ( inuGRUPCODI );
    RETURN(rcData);
  EXCEPTION
    WHEN no_data_found THEN
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
      RAISE ex.CONTROLLED_ERROR;
  END frcGetRcData;

  FUNCTION frcGetRcData RETURN styLDC_GRUPCODI IS
    /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Funcion que retorna un vector de toda la tabla LDC_GRUPO

      Parametros Entrada
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

  BEGIN
    RETURN(rcData);
  END frcGetRcData;

  PROCEDURE insRecords ( iotbLDC_GRUPO in out nocopy tytbLDC_GRUPCODI ) IS
   /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que inserta un registro en la tabla LDC_GRUPO

      Parametros Entrada
       iotbLDC_GRUPO Registro de la tabla LDC_GRUPO
      Valor de salida
        iotbLDC_GRUPO  Registro de la tabla LDC_GRUPO

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/

  BEGIN
    FillRecordOfTables(iotbLDC_GRUPO); --Ticket 200-1090 JGBA -- se cargan los registro en memoria
    FORALL n in iotbLDC_GRUPO.first..iotbLDC_GRUPO.last
        INSERT INTO LDC_GRUPO
                  ( GRUPCODI,
                  GRUPDESC,
                  GRUPTAMU,
                  VIGENCIA_INIT_DATE,
                  VIGENCIA_FINAL_DATE
                  )
      VALUES
            (
             rcRecOfTab.GRUPCODI(n),
             rcRecOfTab.GRUPDESC(n),
             rcRecOfTab.GRUPTAMU(n),
             rcRecOfTab.VIGENCIA_INIT_DATE(n),
             rcRecOfTab.VIGENCIA_FINAL_DATE(n)
            );

  EXCEPTION
    WHEN dup_val_on_index THEN
      Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
      RAISE ex.CONTROLLED_ERROR;
  END insRecords;

  PROCEDURE delRecord ( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type ) IS
  /**************************************************************************
    Autor       : Josh Brito / Horbath
    Fecha       : 2017-04-04
    Ticket      : 200-1090
    Descripcion : Procedimiento que elimina un registro en la tabla LDC_GRUPO

    Parametros Entrada
     inuGRUPCODI Id de la tabla LDC_GRUPO
    Valor de salida


    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
  ***************************************************************************/

    rcError styLDC_GRUPCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error
  BEGIN
    rcError.GRUPCODI := inuGRUPCODI; --Ticket 200-1090 JGBA -- se almacena ID del registro consultado
    --Ticket 200-1090 JGBA -- se elimina registro de la tabla
    DELETE  FROM LDC_GRUPO
    WHERE GRUPCODI= inuGRUPCODI;

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

  PROCEDURE updRecords ( iotbLDC_GRUPO in out nocopy tytbLDC_GRUPCODI ) IS
    /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica varios registros de la tabla LDC_GRUPO

      Parametros Entrada
       iotbLDC_GRUPO Registro de la tabla LDC_GRUPO
      Valor de salida
        iotbLDC_GRUPO  Registro de la tabla LDC_GRUPO

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  BEGIN
    FillRecordOfTables(iotbLDC_GRUPO);

    FORALL n in iotbLDC_GRUPO.first .. iotbLDC_GRUPO.last
      UPDATE LDC_GRUPO  SET
                GRUPDESC = rcRecOfTab.GRUPDESC(n),
                GRUPTAMU = rcRecOfTab.GRUPTAMU(n),
                VIGENCIA_INIT_DATE = rcRecOfTab.VIGENCIA_INIT_DATE(n),
                VIGENCIA_FINAL_DATE = rcRecOfTab.VIGENCIA_FINAL_DATE(n)
      WHERE  GRUPCODI =  rcRecOfTab.GRUPCODI(n);

  END updRecords;

   PROCEDURE updGRUPDESC(inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
              inuGRUPDESC in LDC_GRUPO.GRUPDESC%type ) IS
      /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica el id del tipo de trabajo dependiendo de ID de la tabla
                     LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI ID de la tabla LDC_GRUPO
       inuGRUPDESC  Id del tipo de trabajo
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  rcError styLDC_GRUPCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1090 JGBA -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1090 JGBA -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1090 JGBA -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1090 JGBA -- se almacena excepcion en caso que el registro no existe

  BEGIN
    rcError.GRUPCODI := inuGRUPCODI; --Ticket 200-1090 JGBA -- se almacena id para manejo de error

    rcData.GRUPDESC:= inuGRUPDESC;

  EXCEPTION
    WHEN no_data_found THEN
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      RAISE ex.CONTROLLED_ERROR;

    WHEN erNoExiste THEN
        Errors.setError;
        sbMensError := 'Error no Existe Tipo de trabajo con codigo ['||inuGRUPDESC||']';
        Errors.GETERROR(nuErrorCode, sbMensError);
        Errors.SETMESSAGE(sbMensError);
      RAISE ex.CONTROLLED_ERROR;
  END updGRUPDESC;

  PROCEDURE updGRUPTAMU( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
                           inuGRUPTAMU in LDC_GRUPO.GRUPTAMU%type) IS
     /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2017-04-04
      Ticket      : 200-1090
      Descripcion : Procedimiento que modifica la actividad de multa por el ID de la tabla
                     LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI ID de la tabla LDC_GRUPO
       inuGRUPTAMU  Id de actividad
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  rcError styLDC_GRUPCODI; --Ticket 200-1090 JGBA -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1090 JGBA -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1090 JGBA -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1090 JGBA -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1090 JGBA -- se almacena excepcion en caso que el registro no existe

  BEGIN
    rcError.GRUPCODI := inuGRUPCODI; --Ticket 200-1090 JGBA -- se almacena id para manejo de error

    rcData.GRUPTAMU:= inuGRUPTAMU;

  EXCEPTION
    WHEN no_data_found THEN
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      RAISE ex.CONTROLLED_ERROR;

    WHEN erNoExiste THEN
      Errors.setError;
      sbMensError := 'Error no Existe Actividad con codigo ['||inuGRUPTAMU||']';
      Errors.GETERROR(nuErrorCode, sbMensError);
      Errors.SETMESSAGE(sbMensError);
      RAISE ex.CONTROLLED_ERROR;
  END updGRUPTAMU;

  PROCEDURE updVIGENCIA_INIT_DATE( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
                           inuVIGENCIA_INIT_DATE in LDC_GRUPO.VIGENCIA_INIT_DATE%type) IS
     /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-05-02
      Ticket      : 200-1881
      Descripcion : Procedimiento que modifica la fecha inicial de vigencia por el ID de la tabla
                     LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI ID de la tabla LDC_GRUPO
       VIGENCIA_INIT_DATE  fecha inicial
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  rcError styLDC_GRUPCODI; --Ticket 200-1881 JGBA -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1881 JGBA -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1881 JGBA -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1881 JGBA -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1881 JGBA -- se almacena excepcion en caso que el registro no existe

  BEGIN
    rcError.GRUPCODI := inuGRUPCODI; --Ticket 200-1881 JGBA -- se almacena id para manejo de error

    rcData.VIGENCIA_INIT_DATE:= inuVIGENCIA_INIT_DATE;

  EXCEPTION
    WHEN no_data_found THEN
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      RAISE ex.CONTROLLED_ERROR;

    WHEN erNoExiste THEN
      Errors.setError;
      sbMensError := 'Error no Existe fecha inicial de Vigencia ['||inuVIGENCIA_INIT_DATE||']';
      Errors.GETERROR(nuErrorCode, sbMensError);
      Errors.SETMESSAGE(sbMensError);
      RAISE ex.CONTROLLED_ERROR;
  END updVIGENCIA_INIT_DATE;


  PROCEDURE updVIGENCIA_FINAL_DATE( inuGRUPCODI in LDC_GRUPO.GRUPCODI%type,
                           inuVIGENCIA_FINAL_DATE in LDC_GRUPO.VIGENCIA_FINAL_DATE%type) IS
     /**************************************************************************
      Autor       : Josh Brito / Horbath
      Fecha       : 2018-05-02
      Ticket      : 200-1881
      Descripcion : Procedimiento que modifica la fecha final de vigencia por el ID de la tabla
                     LDC_GRUPO

      Parametros Entrada
       inuGRUPCODI ID de la tabla LDC_GRUPO
       VIGENCIA_FINAL_DATE  fecha final
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
  rcError styLDC_GRUPCODI; --Ticket 200-1881 JGBA -- se Crea registro para manejar error

    sdDato VARCHAR2(1); --Ticket 200-1881 JGBA -- se almacena dato si la persona existe
    nuErrorCode NUMBER;  --Ticket 200-1881 JGBA -- se almacena codigo de error
    sbMensError VARCHAR2(200);  --Ticket 200-1881 JGBA -- se almacena descripcion del error

    erNoExiste  EXCEPTION; --Ticket 200-1881 JGBA -- se almacena excepcion en caso que el registro no existe

  BEGIN
    rcError.GRUPCODI := inuGRUPCODI; --Ticket 200-1881 JGBA -- se almacena id para manejo de error

    rcData.VIGENCIA_FINAL_DATE:= inuVIGENCIA_FINAL_DATE;

  EXCEPTION
    WHEN no_data_found THEN
      Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
      RAISE ex.CONTROLLED_ERROR;

    WHEN erNoExiste THEN
      Errors.setError;
      sbMensError := 'Error no Existe fecha inicial de vigencia ['||inuVIGENCIA_FINAL_DATE||']';
      Errors.GETERROR(nuErrorCode, sbMensError);
      Errors.SETMESSAGE(sbMensError);
      RAISE ex.CONTROLLED_ERROR;
  END updVIGENCIA_FINAL_DATE;




END;
/
PROMPT Otorgando permisos de ejecucion a DALDC_PKGMANTGRUPO
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_PKGMANTGRUPO', 'ADM_PERSON');
END;
/