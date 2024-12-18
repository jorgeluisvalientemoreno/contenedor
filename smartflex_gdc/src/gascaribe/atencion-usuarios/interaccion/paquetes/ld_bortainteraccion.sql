  CREATE OR REPLACE PACKAGE "OPEN"."LD_BORTAINTERACCION" is

  /*****************************************************************
    Propiedad intelectual de OPEN SYSTEMS (c).

    Unidad         : LD_BORTAINTERACCION
    Descripcion    : Paquete donde se implementa la lógica para las Validaciones
                     de Solicitud Interna.
    Autor          : Andres Felipe Duque M
    Fecha          : 19/09/2013

    Metodos

    Nombre         :
    Parametros         Descripcion
    ============  ===================


    Historia de Modificaciones
    Fecha             Autor             Modificacion
    =========         =========         ====================
    09/11/2022        dsaltarin         OSF-679: Se agrega función fnuRecepTypeInteraccionIsWrite para validar si el medio de recpción de las solicitudes
                                        asociadas a la interacción son de medio de recepción escrito
                                        Se agrega el procedimiento prRegistraInteraSinFlujo para marcar la interacción sin flujo
  ******************************************************************/

    --------------------------------------------
    --Constantes
    --------------------------------------------
    --------------------------------------------
    -- Variables
    --------------------------------------------
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    FUNCTION fsbVersion  return varchar2;

/*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fnuValEnvioRtaElect
  Descripcion    : Función que retorna si el tipo de respuesta electrónica se
                   encuentra en el parámetro <LD_MEDREC_ENV_RTA_EL>.
  Autor          : Andrés Felipe Duque M
  Fecha          : 19/09/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  19/09/2013      AduqueSAO216722     Creación
  ******************************************************************/
    FUNCTION fnuValEnvioRtaElect
    (
       inuPackageId         in mo_packages.package_id%type
    )
    RETURN NUMBER;

/*****************************************************************
  Propiedad intelectual de Open International Systems (c).

  Unidad         : fsbGetPackageComment
  Descripcion    : Función que retorna el comentario de la Solicitud Asociada.

  Autor          : Andrés Felipe Duque M
  Fecha          : 19/09/2013

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  19/09/2013      AduqueSAO218723     Creación
  ******************************************************************/
    FUNCTION fsbGetPackageComment
    (
       inuPackageId         in mo_packages.package_id%type
    )
    RETURN VARCHAR2;
    

/*****************************************************************
  Propiedad intelectual de Gases del caribe

  Unidad         : fnuRecepTypeInteraccionIsWrite
  Descripcion    : Función que validar si el medio de recpción de las solicitudes
                   asociadas a la interacción son de medio de recepción escrito
                   Retorna 1 Si es escrito
                   Retorna 0 Si no es escrito

  Autor          : dsaltarin
  Fecha          : 09/11/2022

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  09/10/2022      dsaltarin           Creación OSF-679		
  ******************************************************************/
    FUNCTION fnuRecepTypeInteraccionIsWrite
    (
       inuPackageId         in mo_packages.package_id%type
    )
    RETURN NUMBER;  

/*****************************************************************
  Propiedad intelectual de Gases del caribe

  Unidad         : prRegistraInteraSinFlujo
  Descripcion    : procedimiento que recibe una solicitud de Interacción y la marca en la tabla
                   ldc_interaccion_sin_flujo para indicar que es una solicitud sin flujo y se debe
                   atender manualmente

  Autor          : dsaltarin
  Fecha          : 09/11/2022

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  09/10/2022      dsaltarin           Creación OSF-679		
  ******************************************************************/          
      PROCEDURE prRegistraInteraSinFlujo
    (
       inuPackageId         in mo_packages.package_id%type
    );

    /*****************************************************************
      Propiedad intelectual de Gases del caribe
    
      Unidad         : fnuTipSolPerInteraccion
      Descripcion    : Funcion que validar si el tipo de solicitud esta configurado en el parametro COD_TIP_SOL_PER_INTER para 
                       permitirle generar o no la interaccion respectiva.
                       Retorna 1 Si genera interaccion 
                       Retorna 0 No genera interaccion 
    
      Autor          : Jorge Valiente
      Fecha          : 08/12/2022
    
      Parametros              Descripcion
      ============         ===================
    
      Fecha             Autor             Modificacion
      =========       =========           ====================
    
      ******************************************************************/
    FUNCTION fnuTipSolPerInteraccion
    (
       inuPackageId         in mo_packages.package_id%type
    )
    RETURN NUMBER;  

end LD_BORTAINTERACCION;
/

CREATE OR REPLACE PACKAGE BODY "OPEN"."LD_BORTAINTERACCION" IS

    --------------------------------------------
    -- Constantes
    --------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO
    csbVersion                      CONSTANT VARCHAR2(20)  := 'SAO218723';

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    FUNCTION fsbVersion  return varchar2 IS
    BEGIN
        return csbVersion;
    END;
--------------------------------------------------------------------------------
    FUNCTION fnuValEnvioRtaElect
    (
       inuPackageId         in mo_packages.package_id%type
    )
    RETURN NUMBER
    IS
        sbParametro     ge_parameter.value%type;
        sbReceptionType varchar2(100);
        nuPackAssoId    mo_packages.package_id%type;
        rcPackages      damo_packages.styMO_PACKAGES;
        sbDescription   ps_package_type.description%type;
    BEGIN
        UT_Trace.Trace('Inicia Funcion LD_BORTAINTERACCION.fnuValEnvioRtaElect',15);

        sbParametro := ge_boparameter.fsbget('LD_MEDREC_ENV_RTA_EL');
        sbParametro := '|'||sbParametro||'|';
        UT_Trace.Trace('sbParametro: '||sbParametro,10);

        sbReceptionType := to_char(damo_packages.fnugetreception_type_id(inuPackageId));
        sbReceptionType := '|'||sbReceptionType||'|';
        UT_Trace.Trace('sbReceptionType: '||sbReceptionType,10);

        if instr(sbParametro, sbReceptionType) >0 then
            UT_Trace.Trace('Finaliza LD_BORTAINTERACCION.fnuValEnvioRtaElect Return 1',10);
            RETURN WF_BOConstants.cnuSuccess;
        else
            UT_Trace.Trace('Finaliza LD_BORTAINTERACCION.fnuValEnvioRtaElect Return 0',10);
            RETURN WF_BOConstants.cnuFail;
        END if;

    UT_Trace.Trace('Finaliza Funcion LD_BORTAINTERACCION.fnuValEnvioRtaElect',15);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
   END fnuValEnvioRtaElect;
--------------------------------------------------------------------------------
    FUNCTION fsbGetPackageComment
    (
       inuPackageId         in mo_packages.package_id%type
    )
    RETURN VARCHAR2
    IS
        sbComment      mo_packages.comment_%type;
        nuPackageId    mo_packages.package_id%type;

        rcPackages      damo_packages.styMO_PACKAGES;
        sbDescription   ps_package_type.description%type;

        CURSOR cuPackages
        IS
        SELECT PACKAGE_id
        FROM mo_packages_asso
        WHERE package_id_asso = inuPackageId;

    BEGIN
        UT_Trace.Trace('Inicia Funcion LD_BORTAINTERACCION.fsbGetPackageComment',15);

        OPEN cuPackages;
        FETCH cuPackages INTO nuPackageId;
        CLOSE cuPackages;

        IF nuPackageId IS NOT NULL THEN
            sbComment := DAMO_PACKAGES.fsbgetcomment_(nuPackageId);
        END IF;

        RETURN sbComment;

    UT_Trace.Trace('Finaliza Funcion LD_BORTAINTERACCION.fsbGetPackageComment',15);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            if cuPackages%isopen then
                close cuPackages;
            END if;
            raise ex.CONTROLLED_ERROR;
        when others then
            if cuPackages%isopen then
                close cuPackages;
            END if;
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
   END fsbGetPackageComment;
--------------------------------------------------------------------------------
    FUNCTION fnuRecepTypeInteraccionIsWrite
    (
       inuPackageId         in mo_packages.package_id%type
    )
/*****************************************************************
  Propiedad intelectual de Gases del caribe

  Unidad         : fnuRecepTypeInteraccionIsWrite
  Descripcion    : Funcion que validar si el medio de recpcion de las solicitudes
                   asociadas a la interaccion son de medio de recepcion escrito
                   Retorna 1 Si es escrito
                   Retorna 0 Si no es escrito

  Autor          : dsaltarin
  Fecha          : 09/11/2022

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  09/10/2022      dsaltarin           Creacion OSF-679		
  ******************************************************************/    
    RETURN NUMBER
    IS
        isWrite    NUMBER(1);

    BEGIN
        UT_Trace.Trace('Inicia Funcion LD_BORTAINTERACCION.fnuRecepTypeInteraccionIsWrite',15);

        SELECT Max(decode(b.is_write,'Y',1,0)) INTO isWrite  
        FROM open.mo_packages a, open.ge_reception_type b
        WHERE a.package_id in(SELECT PACKAGE_id FROM mo_packages_asso WHERE package_id_asso = inuPackageId)
        AND a.RECEPTION_TYPE_ID = b.RECEPTION_TYPE_ID
        ;

        RETURN isWrite;

    UT_Trace.Trace('Finaliza Funcion LD_BORTAINTERACCION.fnuRecepTypeInteraccionIsWrite',15);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
   END fnuRecepTypeInteraccionIsWrite;
--------------------------------------------------------------------------------
    PROCEDURE prRegistraInteraSinFlujo
    (
       inuPackageId         in mo_packages.package_id%type
    )
/*****************************************************************
  Propiedad intelectual de Gases del caribe

  Unidad         : prRegistraInteraSinFlujo
  Descripcion    : procedimiento que recibe una solicitud de Interaccion y la marca en la tabla
                   ldc_interaccion_sin_flujo para indicar que es una solicitud sin flujo y se debe
                   atender manualmente. Para atenderlas se crea el servicio LDC_prJobInteraccionSinFlujo
    |              que se programa mediate job

  Autor          : dsaltarin
  Fecha          : 09/11/2022

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================
  09/10/2022      dsaltarin           Creacion OSF-679		
  ******************************************************************/    
    IS

    nuPackageTypeId open.mo_packages.package_type_id%TYPE;
    BEGIN
        UT_Trace.Trace('Inicia Funcion LD_BORTAINTERACCION.fnuRecepTypeInteraccionIsWrite',15);
        nuPackageTypeId :=  damo_packages.fnugetpackage_type_id(inuPackageId, NULL);
        IF nuPackageTypeId = 268 THEN
            INSERT INTO ldc_interaccion_sin_flujo(PACKAGE_ID,PARCIAL,PROCESADO,CREATED_AT)
                VALUES(inuPackageId,'N','N',SYSDATE);
        ELSE
            ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error,
                                         'El tipo de solicitud no es 268');
            Raise ex.controlled_error;
        END IF;
        UT_Trace.Trace('Finaliza Funcion LD_BORTAINTERACCION.fnuRecepTypeInteraccionIsWrite',15);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
   END prRegistraInteraSinFlujo;
--------------------------------------------------------------------------------
    FUNCTION fnuTipSolPerInteraccion
    (
       inuPackageId         in mo_packages.package_id%type
    )
/*****************************************************************
  Propiedad intelectual de Gases del caribe

  Unidad         : fnuTipSolPerInteraccion
  Descripcion    : Funcion que validar si la solicitud asociada a la Solicitud Interaccion esta configurado 
                   en el parametro COD_TIP_SOL_PER_INTER para permitirle generar o no el flujo de la interaccion.
                   Retorna 1 Si genera interaccion 
                   Retorna 0 No genera interaccion 

  Autor          : Jorge Valiente
  Fecha          : 08/12/2022

  Parametros              Descripcion
  ============         ===================

  Fecha             Autor             Modificacion
  =========       =========           ====================

  ******************************************************************/    
    RETURN NUMBER
    IS
        nuExiste    NUMBER(1);

        sbTipoSol open.ld_parameter.value_chain%type := open.dald_parameter.fsbGetValue_Chain('COD_TIP_SOL_PER_INTER');

        cursor cuCod_Tip_Sol is
          SELECT count(1)
          FROM open.mo_packages a, open.ge_reception_type b
          WHERE a.package_id in(SELECT PACKAGE_id FROM mo_packages_asso WHERE package_id_asso = inuPackageId)
          AND a.RECEPTION_TYPE_ID = b.RECEPTION_TYPE_ID
          and a.package_type_id in (SELECT to_number(regexp_substr(sbTipoSol, 
                                                   '[^,]+', 
                                                   1, 
                                                   LEVEL)) 
                      FROM dual 
                    CONNECT BY regexp_substr(sbTipoSol, '[^,]+', 1, LEVEL) IS NOT NULL);

    BEGIN
        UT_Trace.Trace('Inicia Funcion LD_BORTAINTERACCION.fnuTipSolPerInteraccion',15);

        open cuCod_Tip_Sol;
        fetch cuCod_Tip_Sol into nuExiste;        
        close cuCod_Tip_Sol;        

        RETURN nuExiste;

    UT_Trace.Trace('Finaliza Funcion LD_BORTAINTERACCION.fnuTipSolPerInteraccion',15);

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
   END fnuTipSolPerInteraccion;
--------------------------------------------------------------------------------

END LD_BORTAINTERACCION;
/