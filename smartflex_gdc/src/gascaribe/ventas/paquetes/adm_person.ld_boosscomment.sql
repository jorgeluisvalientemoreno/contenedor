CREATE OR REPLACE PACKAGE adm_person.LD_BOOSSCOMMENT AS
/*******************************************************************************
 Package: LD_BOOSSCOMMENT

 Descripción:   Métodos y funciones para obtener informción de la entidad
 mo_comment

 Autor: Germán David Camelo G.
 Fecha: Septiembre 05/2013

 Historia de Modificaciones
 Fecha          Autor - Modificación
 ===========    ================================================================
 23/07/2024     PAcosta             OSF-2952: Cambio de esquema ADM_PERSON
 05-09-2013     GcameloSAO216427    Creación.

*******************************************************************************/

    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------

    ----------------------------------------------------------------------------
    -- Cursores
    ----------------------------------------------------------------------------

    CURSOR cuRecord
	(
		inuCommentId in Mo_comment.Comment_Id%type
	)
	IS
		SELECT Mo_comment.*,Mo_comment.rowid
		FROM Mo_comment
		WHERE
		    Comment_id = inuCommentId;


    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------
    sbCommentAttributes varchar2(32767);
    sbCommentFrom       varchar2(6000);
    sbCommentWhere      varchar2(6000);

    subtype styMo_Comment  is  cuRecord%rowtype;

    ----------------------------------------------------------------------------
    -- Funciones y Procedimientos
    ----------------------------------------------------------------------------

    FUNCTION fsbVersion return varchar2;
    -- =========================================================================

    /***************************************************************************
     =========================================================================
     Metodo:        FillCommentAttributes
     Descripcion:   Arma el sql y llena la tabla de atributos para la selección
                    de las observaciones asociadas a un motivo

     Autor       :  Germán David Camelo G
     Fecha       :  05-09-2013

     Historia de Modificaciones
     Fecha          Autor                Modificacion
     ===========    ===================  =======================================
     06/01/2012     GCameloSAO216427    Creación
    ***************************************************************************/
    PROCEDURE FillCommentAttributes;

    -- =========================================================================

    /***************************************************************************
    Método :       GetComment
    Descripción:   Obtiene la información del comentario a partir del motivo

     Autor       :  Germán David Camelo G,
     Fecha       :  10-01-2012
     Parametros  :  inuMotiveId    Código del motivo
                    ocuCursor      Cursor referenciado con la información de la
                                   observación.

     Historia de Modificaciones
     Fecha          Autor - Modificación
     ===========    ============================================================
     Sep 05/20136   GCamelo SAO216427 Creación.
    ***************************************************************************/

    PROCEDURE GetComment
    (
        inuMotiveId   in mo_motive.motive_id%type,
        ocuCursor     out constants.tyRefCursor
    );

    /***************************************************************************
     Método :       GetComments
     Descripción:   REtorna CURSOR referenciado con los comentarios por motivo

     Autor       :  Germán David Camelo G,
     Fecha       :  10-01-2012
     Parametros  :  inuMotiveId    Código del motivo
                    ocuCursor      Cursor referenciado con la información de la
                                   observación.

     Historia de Modificaciones
     Fecha          Autor - Modificación
     ===========    ============================================================
     Sep 05/20136   Gcamelo SAO216427 Creación.
    ***************************************************************************/

    PROCEDURE GetComments
    (
        inuMotiveId  in mo_motive.motive_id%type,
        ocuCursor    out constants.tyRefCursor
    );

    PROCEDURE GetMotiveId
    (
        inuCommentId    in     mo_comment.comment_id%type,
        onuMotiveId     out    mo_motive.motive_id%type
    );

    PROCEDURE AccKey
	(
		inuCommentId    in MO_comment.Comment_Id%type
	);

	PROCEDURE Load
	(
		inuCommentId    in MO_comment.Comment_Id%type
	);

    FUNCTION fsbGetMessageDescription
	return varchar2;

	FUNCTION fnuGetMotive_Id
	(
		inuCommentId in Mo_comment.Comment_id%type,
		inuRaiseError in number default 1
	)
    RETURN Mo_comment.motive_id%Type;

END LD_BOOSSCOMMENT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BOOSSCOMMENT AS
/*******************************************************************************
 Package: LD_BOOSSCOMMENT

 Descripción:   Métodos y funciones para obtener informción de la entidad
                mo_comment

 Autor: Germán David Camelo G.
 Fecha: Septiembre 5/2013

*******************************************************************************/


    ----------------------------------------------------------------------------
    -- Constantes
    ----------------------------------------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO
    csbVersion  CONSTANT VARCHAR2(250)  := 'SAO216427';

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuGeEntityId constant varchar2(30) := 3210; -- Id de Ge_entity

    ----------------------------------------------------------------------------
    -- Variables
    ----------------------------------------------------------------------------
    sbRestrictionAttributes         varchar2(4000);
    tbRestrictionAttributes         cc_tytbAttribute;

  	/*Variables Globales*/
  	rcData cuRecord%rowtype;
    ----------------------------------------------------------------------------
    -- Funciones y Procedimientos
    ----------------------------------------------------------------------------

    FUNCTION fsbVersion
    return varchar2
    IS
    BEGIN
        return csbVersion;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            ERRORS.seterror;
            raise ex.CONTROLLED_ERROR;
    END;

    -- =============================================================================

    /*******************************************************************************
    Metodo: FillCommentAttributes

    Fecha          Autor - Modificacion   Historia de Modificaciones
    ===========    =====================  ==========================================
    Sep 05/2013    Germán David Camelo G.  Creación

    *******************************************************************************/
    PROCEDURE FillCommentAttributes
    IS

    sbComment               varchar2(300);
    sbCommentId             varchar2(300);
    sbOrganizatArea         varchar2(300);

    BEGIN

        if sbCommentAttributes is not null then
            return;
        end if;

        sbOrganizatArea := 'a.organizat_area_id'|| cc_boBossUtil.csbSEPARATOR ||'b.name_';

        CC_BOBossUtil.AddAttribute ('a.comment_id',        'comment_id',        sbCommentAttributes);
        CC_BOBossUtil.AddAttribute ('a.motive_id',         'motive_id',         sbCommentAttributes);
        CC_BOBossUtil.AddAttribute ('a.comment_',          'comment_',          sbCommentAttributes);
        CC_BOBossUtil.AddAttribute (sbOrganizatArea,       'organizat_area_id', sbCommentAttributes);
        cc_boBossUtil.AddAttribute (':parent_id',          'parent_id',         sbCommentAttributes);

        sbCommentFrom   :=  'mo_comment a, mo_motive b, ge_organizat_area c';

        sbCommentWhere  :=  'a.motive_id = :inuMotiveId';


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;

    END FillCommentAttributes;

    -- =============================================================================

    PROCEDURE GetComment
    (
        inuMotiveId     in     mo_motive.motive_id%type,
        ocuCursor       out    constants.tyRefCursor
    )
    IS
        sbSql        varchar2(32767);

    BEGIN
        ut_trace.trace('Begin LD_BOOSSCOMMENT.GetComment', 10);

        -- Se obtiene la cadena con los atributos
        FillCommentAttributes;

        -- Se arma la consulta de cotizaciones
        sbSql := 'SELECT '|| sbCommentAttributes        ||chr(10)||
                 'FROM '  || sbCommentFrom              ||chr(10)||
                 'WHERE ' || sbCommentWhere             ||chr(10)||
                 'AND a.motive_id = b.motive_id';


        --ut_trace.Trace('Consulta : '||sbSql||' Comentario['||inuMotiveId||']', 10);
        ut_trace.Trace('Consulta : '||chr(10)||sbSql, 1);
        ut_trace.Trace('Comentario[ '||inuMotiveId||' ]', 1);

        -- Se abre el CURSOR referenciado con la consulta
        OPEN ocuCursor FOR sbSql using inuMotiveId, inuMotiveId;

        ut_trace.trace('End LD_BOOSSCOMMENT.GetComment', 2);

    EXCEPTION

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;

    END;



    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: getComments
    Descripción	: Consulta de areas organizacionales, acotada por los parametros de
                  entrada.

    Parametros	:        Descripción
    inuMotiveId          Motivo

    Autor	: GcameloSAO216427
    Fecha	: Sep 05/2013

    Historia de Modificaciones
    Fecha	      IDEntrega
    ==========  ================================================================
    05-Sep-2013 GcameloSAO216427        Creación.
    ******************************************************************/

    PROCEDURE getComments
    (
        inuMotiveId          in     mo_motive.motive_id%type,
        ocuCursor            out    constants.tyRefCursor
    )
    IS
        sbSql             varchar2(32767) := '';

    BEGIN

        ut_trace.trace('Inicia LD_BOOSSCOMMENT.getComments',6 );
        ut_trace.trace('inuMotiveId: '||inuMotiveId,6 );
        -- Se obtiene la cadena con los atributos
        FillCommentAttributes;

        sbSql := 'SELECT ' || sbCommentAttributes          ||chr(10)||
                 'FROM  mo_comment a, ge_organizat_area b' ||chr(10)||
                 'WHERE a.motive_id = :inuMotiveId '       ||chr(10)||
                 'AND a.organizat_area_id = b.organizat_area_id';



        ut_trace.trace('Consulta: ['||sbSql||']',1);

        OPEN ocuCursor FOR sbSql using inuMotiveId, inuMotiveId;

        ut_trace.trace('Finaliza LD_BOOSSCOMMENT.getComments',6 );

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END getComments;

    -- =============================================================================
    /*****************************************************************
    Propiedad intelectual de Open International Systems. (c).

    Function	: GetMotiveId
    Descripción	: Obtiene el identificador del motivo.

    Parametros	:        Descripción
    inuCommentId         Identificador del comentario
    onuMotiveId          Identificador del motivo

    Autor	: GcameloSAO216427
    Fecha	: Sep 05/2013

    Historia de Modificaciones
    Fecha	      IDEntrega
    ==========  ================================================================
    05-Sep-2013 GcameloSAO216427        Creación.
    ******************************************************************/
    PROCEDURE GetMotiveId
    (
        inuCommentId    in     mo_comment.comment_id%type,
        onuMotiveId     out    mo_motive.motive_id%type
    )
    IS
    BEGIN
        ut_trace.trace('Begin LD_BOOSSCOMMENT.GetMotiveId', 5);

        if (inuCommentId is null) then
            ut_trace.trace('Código del motivo nulo', 6);
            onuMotiveId := null;
            return;
        end if;

        -- Valida si la observación existe
        AccKey(inuCommentId);

        --Obtiene el código de la solicitud a la que pertenece la cotización
        onuMotiveId := fnuGetMotive_Id(inuCommentId);

        ut_trace.trace('End LD_BOOSSCOMMENT.GetMotiveId', 2);
    EXCEPTION

        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;

    END GetMotiveId;

    -- =============================================================================
    PROCEDURE AccKey
	(
		inuCommentId in MO_comment.Comment_Id%type
	)
	IS
		rcError styMo_Comment;

    BEGIN		rcError.Comment_Id:=inuCommentId;

		Load
		(
            inuCommentId
		);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||inuCommentId);
			raise ex.CONTROLLED_ERROR;
    END;

    -- =============================================================================
	FUNCTION fsbGetMessageDescription
	return varchar2
	is
	      sbTableDescription varchar2(32000);
	BEGIN
	    if (cnuGeEntityId > 0 and dage_entity.fblExist (cnuGeEntityId))  then
	          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
	    else
	          sbTableDescription:= 'MO_COMMENT';
	    end if;

		return sbTableDescription ;
	END;


    -- =============================================================================
    PROCEDURE Load

	(
		inuCommentId in MO_comment.Comment_Id%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
            inuCommentId
		);

		fetch cuRecord into rcData;
		if cuRecord%notfound  then
			close cuRecord;
			rcData := rcRecordNull;
			raise no_data_found;
		end if;
		close cuRecord;
	END;

	-- =============================================================================
	FUNCTION fnuGetMotive_Id
	(
		inuCommentId in Mo_comment.Comment_id%type,
		inuRaiseError in number default 1
	)
	RETURN Mo_comment.Motive_Id%type
	IS
		rcError styMo_Comment;
	BEGIN

		rcError.Comment_id := inuCommentId;

        Load
		(
            inuCommentId
		);
		return(rcData.Motive_Id);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||inuCommentId);
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END fnuGetMotive_Id;


BEGIN

    sbCommentAttributes := null;
    sbCommentFrom       := null;
    sbCommentWhere      := null;

END LD_BOOSSCOMMENT;
/
PROMPT Otorgando permisos de ejecucion a LD_BOOSSCOMMENT
BEGIN
    pkg_utilidades.praplicarpermisos('LD_BOOSSCOMMENT', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LD_BOOSSCOMMENT para reportes
GRANT EXECUTE ON adm_person.LD_BOOSSCOMMENT TO rexereportes;
/