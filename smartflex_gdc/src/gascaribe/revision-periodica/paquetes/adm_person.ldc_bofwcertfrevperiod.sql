CREATE OR REPLACE PACKAGE adm_person.LDC_BofwCertfRevPeriod AS
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : LDC_BofwCertfRevPeriod
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    23/07/2024              PAcosta         OSF-2952: Cambio de esquema ADM_PERSON                              
    ****************************************************************/     

    sbSqlSuspenMark          varchar2(10000);
    sbSuspenMarkAttributes  varchar2(4000);

    /*******************************************************************************
     Metodo: FillSuspenMark
     Descripcion:
     Autor:   Emiro Leyva
     Fecha:   12/04/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     12/04/2014      - Creacion
    *******************************************************************************/
    PROCEDURE FillSuspenMark;


    /*******************************************************************************
     Metodo: GetSuspenMark
     Descripcion:
     Autor:   Emiro Leyva
     Fecha: 12/04/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     12/04/2014      - Creacion
    *******************************************************************************/
    PROCEDURE GetSuspenMark
    (
        inuProducto       in     LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
        ocuCursor         out    constants.tyRefCursor
    );

    /*******************************************************************************
     Metodo: GetMarcasByCertificate
     Descripcion:   Obtiene todos las marcas que tiene un producto
                    Este es Hijo del Padre
     Autor: Emiro Leyva
     Fecha: 14/08/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     14/08/2014     emirol - Creacion
    *******************************************************************************/
    PROCEDURE GetMarcasByCertificate
    (
        inuCertificate    in ldc_plazos_cert.plazos_cert_id%type,
        ocuCursor         out constants.tyRefCursor
    );
    /*******************************************************************************
     Metodo: GetCertificateByMarcas
     Descripcion:   Esto es Padre de Hijo Marcas
     Autor: Emiro Leyva
     Fecha: 14/08/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     12/04/2014     Emirol - Creacion
    *******************************************************************************/
    PROCEDURE GetCertificateByMarcas
    (
        inuproducto        in number,
        onuCertificate           out number
    );
END LDC_BofwCertfRevPeriod;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LDC_BofwCertfRevPeriod AS

    /*******************************************************************************
     Metodo: FillSuspenMark
     Descripcion:
     Autor:   Emiro Leyva
     Fecha:   12/04/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     12/04/2014      - Creacion
    *******************************************************************************/
    PROCEDURE FillSuspenMark
    IS

    sbID_PRODUCTO           varchar2(500);
    sbORDER_ID              varchar2(500);
    sbCERTIFICADO           varchar2(500);
    sbFECHA_ULTIMA_ACTU     varchar2(500);
    sbINTENTOS              varchar2(500);
    sbMEDIO_RECEPCION       varchar2(500);
    sbREGISTER_POR_DEFECTO  varchar2(500);
    sbSUSPENSION_TYPE_ID    varchar2(500);
    sbParent                varchar2(500);
    sbFromSuspenMark        varchar2(4000);

    BEGIN
        -- Si ya existe una sentencia de atributos no se debe continuar
        if sbSqlSuspenMark IS not null then
            return;
        END if;

        -- Definicion de cada uno de los atributos
        sbID_PRODUCTO           := 'LDC_MARCA_PRODUCTO.ID_PRODUCTO';
        sbORDER_ID              := 'LDC_MARCA_PRODUCTO.ORDER_ID';
        sbCERTIFICADO           := 'LDC_MARCA_PRODUCTO.CERTIFICADO';
        sbFECHA_ULTIMA_ACTU     := 'LDC_MARCA_PRODUCTO.FECHA_ULTIMA_ACTU';
        sbINTENTOS              := 'LDC_MARCA_PRODUCTO.INTENTOS';
        sbMEDIO_RECEPCION       := 'decode(LDC_MARCA_PRODUCTO.MEDIO_RECEPCION,''I'',''I - Interna'',''E - Externa'')MEDIO_RECEPCION';
        sbREGISTER_POR_DEFECTO  := 'LDC_MARCA_PRODUCTO.REGISTER_POR_DEFECTO';
        sbSUSPENSION_TYPE_ID    := 'nvl(LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID,101)||'' - ''||dage_suspension_type.fsbgetdescription(nvl(LDC_MARCA_PRODUCTO.SUSPENSION_TYPE_ID,101)) SUSPENSION_TYPE_ID';
        sbParent                := 'to_char(:parent_id) parent_id';

        -- Conformacion de la cadena con los atributos
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbID_PRODUCTO ||', '|| chr(10);
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbORDER_ID||', '|| chr(10);
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbCERTIFICADO ||', '|| chr(10);
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbFECHA_ULTIMA_ACTU ||', '|| chr(10);
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbINTENTOS ||', '|| chr(10);
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbMEDIO_RECEPCION ||', '|| chr(10);
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbREGISTER_POR_DEFECTO ||', '|| chr(10);
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbSUSPENSION_TYPE_ID ||', '|| chr(10);
        sbSuspenMarkAttributes := sbSuspenMarkAttributes || sbParent ||chr(10);


        -- Definicion del FROM con las dos tablas origen de datos
        sbFromSuspenMark      :=  'FROM LDC_MARCA_PRODUCTO'||chr(10);

        -- Relacion entre las tablas origen de datos
        --sbJoinsAssociate     :=  'WHERE  ldc_certificados_oia.ID_CONTRATO = PAG_ID_PRODUCTO_type.ID_CONTRATO' ||chr(10);

        --  la sentencia con todos los componentes comunes
        sbSqlSuspenMark := 'SELECT '|| chr(10);
        sbSqlSuspenMark := sbSqlSuspenMark || sbSuspenMarkAttributes;
        sbSqlSuspenMark := sbSqlSuspenMark || sbFromSuspenMark;




    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END;


    /*******************************************************************************
     Metodo: GetSuspenMark
     Descripcion:
     Autor:   Emiro Leyva
     Fecha:   12/04/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     12/04/2014      - Creacion
    *******************************************************************************/
    PROCEDURE GetSuspenMark
    (
        inuProducto         in     LDC_MARCA_PRODUCTO.ID_PRODUCTO%type,
        ocuCursor           out    constants.tyRefCursor
    )
    IS
    sbSqlFinal varchar2(10000);
    BEGIN

        ut_trace.trace('-- Paso 1. GetSuspenMark, inuProducto:['||inuProducto||']',2);
        -- Llamado al metodo que define los atributos
        FillSuspenMark;

        -- Condicion para traer un unico atributo recibiendo valor de ID
        sbSqlFinal := sbSqlSuspenMark || 'WHERE LDC_MARCA_PRODUCTO.id_producto = :ID_PRODUCTO'||chr(10);

        ut_trace.trace('-- Paso 2. GetSuspenMark, sbSqlFinal:['||sbSqlFinal||']',2);

        -- Abrir CURSOR con sentencia y parametros
        open ocuCursor for sbSqlFinal using cc_boBossUtil.cnuNULL, inuProducto;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END;

    /*******************************************************************************
     Metodo: GetMarcasByCertificate
     Descripcion:   Obtiene todos las marcas que tiene un producto
                    Este es Hijo del Padre
     Autor: Emiro Leyva
     Fecha: 14/08/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     14/08/2014     emirol - Creacion
    *******************************************************************************/
    PROCEDURE GetMarcasByCertificate
    (
        inuCertificate    in ldc_plazos_cert.plazos_cert_id%type,
        ocuCursor         out constants.tyRefCursor
    )
    IS
        sbSqlFinal           varchar2(4000);
        nuProducto       ldc_plazos_cert.id_producto%type;
    BEGIN

        SELECT ID_PRODUCTO into nuProducto
        FROM ldc_plazos_cert
        where plazos_cert_id = inuCertificate;

        FillSuspenMark;

        sbSqlFinal := sbSqlSuspenMark || 'WHERE ldc_marca_producto.ID_PRODUCTO = :Product_id';
        dbms_output.put_Line(sbSqlFinal);

        ut_trace.trace('-- Paso 21. GetCertificateSFByCertificate, nuProducto:['||nuProducto||']',2);
        ut_trace.trace('-- Paso 22. GetCertificateSFByCertificate, sbSqlFinal:['||sbSqlFinal||']',2);

        --GE_BOINSTANCECONTROL.ADDATTRIBUTE('WORK_INSTANCE', null, 'PR_PRODUCT', 'PRODUCT_ID',nuProducto , true);

        open ocuCursor for sbSqlFinal using inuCertificate,nuProducto;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;

        when others then
            errors.seterror;
            raise ex.CONTROLLED_ERROR;
    END;
    /*******************************************************************************
     Metodo: GetCertificateByMarcas
     Descripcion:   Esto es Padre de Hijo Marcas
     Autor: Emiro Leyva
     Fecha: 14/08/2014

     Historia de Modificaciones
     Fecha          Autor - Modificacion
     ===========    ================================================================
     12/04/2014     Emirol - Creacion
    *******************************************************************************/
    PROCEDURE GetCertificateByMarcas
    (
        inuproducto        in number,
        onuCertificate           out number
    )
    IS
    BEGIN

        SELECT PLAZOS_CERT_ID INTO onuCertificate
        FROM ldc_plazos_cert
        where id_producto =
            (SELECT ID_PRODUCTO
            from ldc_marca_producto
            where id_producto = inuproducto);

        ut_trace.trace('-- Paso 20. GetCertificateByCertificateSF, onuCertificate:['||onuCertificate||']',2);

        -- Valida que el credito exista
        /*daPAG_credit.AccKey (inuCertificateSF_ID);

        -- Obtiene el dato del asociado en el registro del credito
        onuCertificate := daPAG_credit.fnuGetAssociate_id(inuCertificateSF_ID);*/

    EXCEPTION
        when ex.CONTROLLED_ERROR then
        -- Si falla retorna nulo
            onuCertificate := null;

        when others then
            ERRORS.seterror;
            raise ex.CONTROLLED_ERROR;
    END;


END LDC_BofwCertfRevPeriod;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOFWCERTFREVPERIOD
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOFWCERTFREVPERIOD', 'ADM_PERSON');
END;
/

PROMPT Otorgando permisos de ejecucion sobre LDC_BOFWCERTFREVPERIOD para reportes
GRANT EXECUTE ON adm_person.LDC_BOFWCERTFREVPERIOD TO rexereportes;
/
