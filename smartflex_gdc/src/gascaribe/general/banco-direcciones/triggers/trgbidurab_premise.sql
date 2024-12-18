CREATE OR REPLACE TRIGGER "TRGBIDURAB_PREMISE"
  BEFORE INSERT OR UPDATE OR DELETE ON AB_PREMISE
  REFERENCING OLD AS old NEW AS new
  FOR EACH ROW
/**************************************************************
  Propiedad intelectual de Open International Systems. (c).
  Trigger    :  trgbidurAB_PREMISE
  Descripcion    : Verifica que el usuario que puede insertar, modificar o borrar
                   registros en la entidad AB_PREMISE, sea el definido en la constante
                   csbUSER
  Autor    : Hector Cruz
  Fecha    : 10-07-2012
  Historia de Modificaciones
  Fecha          IDEntrega           Modificacion
  08-09-2012    hcruzSAO189882      Modificacion del usuario
  10-07-2012    hcruzSAO185353      Creacion
  24-09-2013    alvzapata           adicion valicacion user OPEN y new.saledate cuando se vaya actualizar la fecha de venta
  17/12/2014    jorge Valiente      NC4187: Crear un paraemtro para validar si la aplicacion
                                            que realiza los cambios viene de un ejecutable WEB
                                            llamado w3wp.exe
  14/01/2015    jorge Valiente      CAMBIO5941: Se validara el tipo de solicitud para determinar
                                                mediante un parametro si el tramite que realiza la
                                                actualizacion de direccion proviene de 100221 o 100224
  11/09/2024    Kelly Florez         Modificacion de la consiltra del programa de gis SD-22935                                                                                           
  **************************************************************/
DECLARE
  /******************************************
      Declaracion de variables y Constantes
  ******************************************/
  cnuUSER_NO_ALLOW constant ge_message.message_id%type := 901343;
  csbINSERT_ACTION constant varchar(15) := 'insercion';
  csbUPDATE_ACTION constant varchar(15) := 'actualizacion';
  csbDELETE_ACTION constant varchar(15) := 'borrado';
  csbENTITY        constant varchar(15) := 'AB_PREMISE';

  -- Tener en cuenta que el usuario debe ir mayuscula sostenida.
  csbUSER constant sa_user.mask%type := dald_parameter.fsbGetValue_Chain('USER_CONN_GIS');
  sbCurrentUser      sa_user.mask%type;
  nuPackageType      ps_package_type.package_type_id%type;
  sbName             sa_executable.name%type;
  nuExiste           number;
  sbProgram          varchar2(48); --:=UT_SESSION.Getprogram; --UT_SESSION.GETMODULE;
  sbParamModu        varchar2(48) := dald_parameter.fsbGetValue_Chain('NOM_APLICATIVO_GIS');
  inuActivity        OR_ORDER_ACTIVITY.ACTIVITY_ID%type := dald_parameter.fnuGetNumeric_Value('ACTIVIDADES_GIS');
  inuParsedAddressId OR_ORDER_ACTIVITY.ADDRESS_ID%type;
  idtExecDate        date;
  isbComment         or_order_comment.order_comment%type;
  inuReferenceValue  number := 0;
  inuOrderId         or_order.order_id%type;
  inuGeograLoca      ab_address.geograp_location_id%type;
  sbAddress          ab_address.address%type;
  onuErrorCode       number;
  osbErrorMessage    varchar2(2000);

  --NC1733 VARIABLES
  sbPackId MO_PACKAGES.PACKAGE_ID%TYPE;
  --FIN NC1733

  --NC4187 VARIABLES
  sbParamModuWeb varchar2(48) := dald_parameter.fsbGetValue_Chain('NOM_APLICATIVO_GIS_WEB');
  --FIN NC4187

  cursor cuprogramgis is
    select upper(s.program)
      from gv$session s, gv$process p
     where s.paddr = p.addr
       and s.inst_id = p.inst_id
          --and upper(s.USERNAME) = upper(user)
       and s.SID = sys_context('USERENV', 'SID')
    --and upper(s.USERNAME) = upper('GIS_SANTIAGOC')
     group by s.program;

  --rtprogramgis cuprogramgis%rowtype;
  sbprogramgis varchar2(48);

  /*****************************************************************
  Unidad      :   fnuGetPackageType
  Descripcion    :   Obtiene el identificador del tipo de solicitud Si es una
                  solicitud
  Parametros      Descripcion
  ============    ===================
  Historia de Modificaciones
  Fecha         Autor                 Modificacion
  ============  ===================   ====================
  18-11-2013    ALVZAPATA             Adicion condicion que valida si el programa que intenta registrar
                                      es SIGGAS.exe, adicionalmente se inclute API para crear una orden sin
                                      relacionarse a ninguna solicitud.
  26-08-2014    Jorge Valiente        NC1733: Se adiciono validacion para permitir que el tramite de Actualizaion de Cliente a contrato
                                              realice la actualzacion del campo SALSEDATE.
                                              Este paraemtro sera actualizado para utilizar el campo cadena
                                              por el CAMBIO 5941
  ******************************************************************/
  FUNCTION fnuGetPackageType RETURN NUMBER IS
    blExists   boolean;
    nuIndex    ge_boinstancecontrol.stynuIndex;
    sbPackType ge_boinstancecontrol.stysbValue := NULL;
  BEGIN
    -- Valida si existe la instancia
    blExists := ge_boinstancecontrol.fblAcckeyInstanceStack('WORK_INSTANCE',
                                                            nuIndex);
    IF (blExists) THEN

      -- Valida si es la instancia de una solicitud
      blExists := ge_boinstancecontrol.fblAcckeyAttributeStack('WORK_INSTANCE',
                                                               NULL,
                                                               'PS_PACKAGE_TYPE',
                                                               'PACKAGE_TYPE_ID',
                                                               nuIndex);
      IF (blExists) THEN

        -- Obtiene el identificador del tipo de solicitud
        ge_boinstancecontrol.GetAttributeNewValue('WORK_INSTANCE',
                                                  NULL,
                                                  'PS_PACKAGE_TYPE',
                                                  'PACKAGE_TYPE_ID',
                                                  sbPackType);
      END IF;
    END IF;

    RETURN to_number(sbPackType);
  EXCEPTION
    when others then
      RETURN NULL;
  END;

BEGIN
  
 
   
   
  ut_trace.trace('trgbidurAB_PREMISE', 1);

  --INICIO CAMBIO 5941
  nuPackageType := fnuGetPackageType;
  if nuPackageType is not null then
    if instr(dald_parameter.fsbGetValue_Chain('SOLI_ACTU_CLIE_CONT', null),
             nuPackageType) > 0 then
      nuExiste := 1;
    else
      nuExiste := 0;
    end if;
  else
    --FIN CAMBIO 5941

    --NC1733
    sbPackId := MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();

    select count(1)
      into nuExiste
      from MO_PACKAGES MP
    --where MP.PACKAGE_TYPE_ID =
    --      dald_parameter.fnuGetNumeric_Value('SOLI_ACTU_CLIE_CONT', null)
     where instr(dald_parameter.fsbGetValue_Chain('SOLI_ACTU_CLIE_CONT',
                                                  null),
                 MP.PACKAGE_TYPE_ID) > 0
       and MP.PACKAGE_ID = sbPackId;
    --INICIO CAMBIO 5941
  end if;
  --FIN CAMBIO 5941

  --FIN NC1733
  IF nuExiste = 1 THEN
    IF :NEW.CATEGORY_ <> :OLD.CATEGORY_ OR
       :NEW.SUBCATEGORY_ <> :OLD.SUBCATEGORY_ OR
       :NEW.CONSECUTIVE <> :OLD.CONSECUTIVE OR
       :NEW.PREMISE_TYPE_ID <> :OLD.PREMISE_TYPE_ID THEN
      sbCurrentUser := ut_session.getUSER;
      ut_trace.trace('EL TRAMITE ES DE ACTUALIZACION DE CLIENTE A CONTRATO',
                     10);
      ge_boerrors.seterrorcodeargument(cnuUSER_NO_ALLOW,
                                       sbCurrentUser || '|' || csbENTITY);

    END IF;
  ELSE

    -- Obtiene el usuario actual
    --sbCurrentUser := ut_session.getUSER;
    SBCURRENTUSER := PKG_SESSION.GETUSER;

    ut_trace.trace('CURRENT_USER    [' || sbCurrentUser || ']', 2);

   /* open cuprogramgis;
    fetch cuprogramgis
      into sbprogramgis;
    if cuprogramgis%notfound then
      sbprogramgis := 'DIFERENTE';
    end if;
    close cuprogramgis;*/
    
    SELECT UPPER(PROGRAM)
    INTO SBPROGRAM
    FROM V$SESSION
    WHERE AUDSID = SYS_CONTEXT('USERENV', 'SESSIONID');
   

    --dbms_output.put_line('Programa --> ' || sbprogramgis);
    ut_trace.trace('Programa    [' || sbProgram || ']', 10);
    --sbProgram := sbprogramgis;


    
   
    IF upper(sbProgram) <> upper(sbParamModu) and
       upper(sbProgram) <> upper(sbParamModuWeb) THEN

      if (sbCurrentUser <> csbUSER) then

        -- Obtiene el nombre del proceso
        -- sbName := fsbGetProcessName;
        -- Obtiene el tipo de solicitud
        nuPackageType := fnuGetPackageType;

        --ut_trace.trace('EXECUTABLE_NAME ['||sbName||']',2);
        ut_trace.trace('PACKAGE_TYPE    [' || nuPackageType || ']', 2);

        select count(1)
          into nuExiste
          from ps_package_type
         where package_type_id in
               (select to_number(column_value)
                  From table(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('PACK_PERMITE_ING_DIRECCION',
                                                                                           null),
                                                          ',')))
           and package_type_id = nuPackageType;

        if nuExiste = 0 then
          if (INSERTING) then
            ut_trace.trace('INSERTING', 2);
            ge_boerrors.seterrorcodeargument(cnuUSER_NO_ALLOW,
                                             sbCurrentUser || '|' ||
                                             csbINSERT_ACTION || '|' ||
                                             csbENTITY||'-'||sbProgram);
          end if;
          if (UPDATING) then
            ut_trace.trace('UPDATING', 2);
            ge_boerrors.seterrorcodeargument(cnuUSER_NO_ALLOW,
                                             sbCurrentUser || '|' ||
                                             csbUPDATE_ACTION || '|' ||
                                             csbENTITY||'-'||sbProgram);
          end if;
          if (DELETING) then
            ut_trace.trace('DELETING', 2);
            ge_boerrors.seterrorcodeargument(cnuUSER_NO_ALLOW,
                                             sbCurrentUser || '|' ||
                                             csbDELETE_ACTION || '|' ||
                                             csbENTITY||'-'||sbProgram);
          end if;
          /*        else
            inuParsedAddressId:= :new.ADDRESS_ID;
            inuGeograLoca:=      :new.geograp_location_id;
            sbAddress:=          :new.ADDRESS_PARSED;
            idtexecdate:=        sysdate;
            isbcomment:=         'Address_id:'||inuParsedAddressId||', geograp_location_id:'||inuGeograLoca||', Address:'||sbAddress;
          INSERT INTO LDC_TMP_OT_GIS (ACTIVITY_ID, ADDRESS_ID, FECHA, COMENTARIO, REFERENCIA_VALUE,GEOGRAP_LOCATION_ID)
          VALUES(inuactivity,inuParsedAddressId,sysdate, isbcomment, 0,inuGeograLoca );  */
        end if;
      end if;
    END IF;
  END IF; --FIN VALIDACION SOLCITUD ACTUALIZACION  DE CLIENTE A CONTRATO
EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END trgbirGE_ENTITY;
/