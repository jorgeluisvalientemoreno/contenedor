CREATE OR REPLACE Package ld_bcequivalreport Is

  -- Author  : LUDYCOM
  -- Created : 17/09/2012 07:55:11 p.m.
  -- Purpose : En este paquete se agruparan los diversos procesos o funciones
  --           que permitirán ingresar la configuración de las centrales de riesgos
  --           con sus respectivos tipos de reportes y formatos.

  Type nuref_cursor Is Ref Cursor;
  Type cucentralriesgo_cursor Is Ref Cursor;

  -- Constantes públicas del paquete:
  cnunull_attribute Constant Number := 2126;

  -- Public function and procedure declarations

  Function fnugetmethodpayment(sbesfina servsusc.sesuesfn%Type)
    Return Number;

  Function fsbgetaccountstatuscf(sbesfina servsusc.sesuesfn%Type)
    Return Varchar2;

  Function fsbgetaccountstatusdc(sbesfina Number) Return Varchar2;

  Function fnugettypeportfol(nuservice servsusc.sesuserv%Type) Return Number;

  Function fnugetlinecredit(nuservice servsusc.sesuserv%Type) Return Number;

  Function fnugetdefaultage(nudebt cuencobr.cucosacu%Type) Return Number;

  Function fsbgetinfopackage(nuservice servsusc.sesuserv%Type)
    Return Varchar2;

  Function fsbgetcodepackage(nusector ld_type_sector.type_id%Type)
    Return Number;

  Function fsbgetsiglpackage(nusector ld_type_sector.type_id%Type)
    Return Varchar2;

  Function fsbgettypecontract(nuservice servsusc.sesuserv%Type)
    Return Varchar2;

  Function fsbgettypecontractsc(nusector ld_type_sector.type_id%Type)
    Return Varchar2;

  Function fnugetstateobligation(sbesfina servsusc.sesuesfn%Type,
                                 sbsector ld_type_sector.type_id%Type,
                                 sbestcor servsusc.sesuesco%Type,
                                 nudebt   cuencobr.cucosacu%Type)
    Return Number;

  Function fsbgettermcontractsc(nusector ld_type_sector.type_id%Type)
    Return Varchar2;

  Function fnugetidentificationtypedc(ninidentype ge_subscriber.ident_type_id%Type)
    Return Number;

  Function fnugetidentificationtypecf(ninidentype ge_subscriber.ident_type_id%Type)
    Return Number;

  Function fnugetcreditbureaudesc(ninidentype ld_credit_bureau.credit_bureau_id %Type)
    Return Varchar2;

  Function fnugetservicecateg(insector ld_service_category_cf.sector_id %Type)
    Return Varchar2;

  Function fsbversion Return Varchar2;
End ld_bcequivalreport;
/
CREATE OR REPLACE Package Body ld_bcequivalreport Is

  -- Esta constante se debe modificar cada vez que se entregue el
  -- paquete con un SAO

  -- Author  : LUDYCOM
  -- Created : 22/09/2012 02:49:43 p.m.
  -- Purpose : Componente de negocio que lleva a cabo la generacion de los archivos de la central de riesgo
  /***************************************************************************************
   Historia de Modificaciones

    Fecha           IDEntrega

    16-08-2013      slemusSAO214733
    Se realiza creacion de función para extraer la sigla de la tabla ld_information_packets_cf, esto con el fin de incluirla
    en el encabezado del archivo.

    DD-MM-2013      usuarioSAO######
    Descripción breve, precisa y clara de la modificación realizada.
  ****************************************************************************************/

  csbversion Constant Varchar2(250) := '214733';

  /******************************************************************
  Propósito:  Obtiene forma de pago de la tabla ld_method_payment_dc

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugetmethodpayment(sbesfina servsusc.sesuesfn%Type)
    Return Number Is

    Cursor cumethpaymen Is
      Select c.method_payment_id
        From ld_method_payment_dc c
       Where upper(c.financial_status) = upper(sbesfina);

    regmethpaym ld_method_payment_dc.method_payment_id%Type;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fnugetmethodpayment');
    Open cumethpaymen;
    Fetch cumethpaymen
      Into regmethpaym;

    pkerrors.pop;
    If cumethpaymen%Notfound Then
      Return(-1);
    Else
      Return regmethpaym;

    End If;
  Exception
    When too_many_rows Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return - 1;
    When no_data_found Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return - 1;

  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de la tabla Estado de
              cuenta de la tabla ld_account_status_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fsbgetaccountstatuscf(sbesfina servsusc.sesuesfn%Type)
    Return Varchar2 Is

    Cursor cuaccounstats Is
      Select *
        From ld_account_status_cf
       Where upper(financial_status) = upper(sbesfina);

    regaccoustats ld_account_status_cf%Rowtype;
    gsberrmsg     ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fsbgetaccountstatuscf');
    Open cuaccounstats;
    Fetch cuaccounstats
      Into regaccoustats;
    pkerrors.pop;
    If regaccoustats.account_state_id Is Null Then
      Return(-1);
    Else
      Return regaccoustats.account_state_id;
    End If;
  Exception
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de la tabla Estado de
              cuenta de la tabla ld_account_status_dc

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fsbgetaccountstatusdc(sbesfina Number) Return Varchar2 Is

    Cursor cuaccoustatdc Is
      Select *
        From ld_account_status_dc
       Where financial_status = to_char(sbesfina);

    regaccstat ld_account_status_dc%Rowtype;
    gsberrmsg  ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fsbgetaccountstatusdc');
    Open cuaccoustatdc;
    Fetch cuaccoustatdc
      Into regaccstat;

    pkerrors.pop;
    If regaccstat.account_state_id Is Null Then
      Return(-1);
    Else
      Return regaccstat.account_state_id;
    End If;

  Exception
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de la tabla tipo de cartera
               de la tabla ld_type_portfolio_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugettypeportfol(nuservice servsusc.sesuserv%Type) Return Number Is

    Cursor cutype_portcf Is
      Select * From ld_type_portfolio_cf Where servcodi = nuservice;

    regtypeport ld_type_portfolio_cf%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fnugettypeportfol');
    Open cutype_portcf;
    Fetch cutype_portcf
      Into regtypeport;

    pkerrors.pop;
    If regtypeport.type_portfolio_id Is Null Then
      Return(-1);
    Else
      Return regtypeport.type_portfolio_id;
    End If;
  Exception
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de linea de credito para Cifin
               de la tabla ld_line_credit_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugetlinecredit(nuservice servsusc.sesuserv%Type) Return Number Is

    Cursor culinecredit Is
      Select * From ld_line_credit_cf Where servcodi = nuservice;

    reglinecred ld_line_credit_cf%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fnugetlinecredit');
    Open culinecredit;
    Fetch culinecredit
      Into reglinecred;
    pkerrors.pop;
    If reglinecred.line_credit_id Is Null Then
      Return(-1);
    Else
      Return reglinecred.line_credit_id;
    End If;
  Exception
    When too_many_rows Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return - 1;
    When Others Then
      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return - 1;
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de edad para Cifin
               de la tabla ld_default_age_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugetdefaultage(nudebt cuencobr.cucosacu%Type) Return Number Is

    Cursor cudefaultage Is
      Select * From ld_default_age_cf Where crit_cuen_sald = nudebt;

    regdefage ld_default_age_cf%Rowtype;
    gsberrmsg ge_error_log.description%Type;

  Begin
    pkerrors.push('ld_bcequivalreport.fnugetdefaultage');
    Open cudefaultage;
    Fetch cudefaultage
      Into regdefage;

    pkerrors.pop;
    If regdefage.default_age_id Is Null Then
      Return(-1);
    Else
      Return regdefage.default_age_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente del codigo de paquetes de informacion para Cifin
               dependiendo del sector de la tabla ld_information_packets_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fsbgetinfopackage(nuservice servsusc.sesuserv%Type)
    Return Varchar2 Is

    Cursor cuinfopackcf Is
      Select * From ld_information_packets_cf Where servcodi = nuservice;

    reginfopack ld_information_packets_cf%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fsbgetinfopackage');
    Open cuinfopackcf;
    Fetch cuinfopackcf
      Into reginfopack;
    pkerrors.pop;
    If reginfopack.information_packets_id Is Null Then
      Return(-1);
    Else
      Return reginfopack.information_packets_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente del codigo de paquetes de informacion para Cifin
               dependiendo del sector de la tabla ld_information_packets_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fsbgetcodepackage(nusector ld_type_sector.type_id%Type)
    Return Number Is

    Cursor cuinfopackcf Is
      Select * From ld_information_packets_cf Where sector = nusector;

    reginfopack ld_information_packets_cf%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fsbgetinfopackage');
    Open cuinfopackcf;
    Fetch cuinfopackcf
      Into reginfopack;
    pkerrors.pop;
    If reginfopack.information_packets_id Is Null Then
      Return('07');
    Else
      Return reginfopack.information_packets_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de la sigla de paquetes de informacion para Cifin
               dependiendo del sector de la tabla ld_information_packets_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fsbgetsiglpackage(nusector ld_type_sector.type_id%Type)
    Return Varchar2 Is

    Cursor cuinfopackcf Is
      Select * From ld_information_packets_cf Where sector = nusector;

    reginfopack ld_information_packets_cf%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fsbgetinfopackage');
    Open cuinfopackcf;
    Fetch cuinfopackcf
      Into reginfopack;
    pkerrors.pop;
    If reginfopack.information_packets_id Is Null Then
      Return('SR');
    Else
      Return reginfopack.acronym;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;
  /******************************************************************
  Propósito:  Obtiene el equivalente de tipo de paquete para Cifin
               de la tabla ld_type_contract_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fsbgettypecontract(nuservice servsusc.sesuserv%Type)
    Return Varchar2 Is

    Cursor cutypecontract Is
      Select * From ld_type_contract_cf Where servcodi = nuservice;

    regtypecont ld_type_contract_cf%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fsbgettypecontract');
    Open cutypecontract;
    Fetch cutypecontract
      Into regtypecont;
    pkerrors.pop;
    If regtypecont.type_contract_id Is Null Then
      Return(-1);
    Else
      Return regtypecont.type_contract_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de tipo de contrato para Cifin
              de la tabla ld_type_contract_cf, por sector

  Historia de Modificaciones

  17-08-2013      slemusSAO213076
  Creación.
  ******************************************************************/

  Function fsbgettypecontractsc(nusector ld_type_sector.type_id%Type)
    Return Varchar2 Is

    Cursor cutypecontract Is
      Select * From ld_type_contract_cf Where sector_id = nusector;

    regtypecont ld_type_contract_cf%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fsbgettypecontract');
    Open cutypecontract;
    Fetch cutypecontract
      Into regtypecont;
    pkerrors.pop;
    If regtypecont.type_contract_id Is Null Then
      Return(-1);
    Else
      Return regtypecont.type_contract_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de termina o vigencia contrato para Cifin
              de la tabla ld_status_contract_cf, por sector

  Historia de Modificaciones

  17-08-2013      slemusSAO213076
  Creación.
  ******************************************************************/

  Function fsbgettermcontractsc(nusector ld_type_sector.type_id%Type)
    Return Varchar2 Is

    Cursor cutypecontract Is
      Select *
        From ld_status_contract_cf
       Where equivalence_sector = nusector;

    regtypecont ld_status_contract_cf%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fsbgettypecontract');
    Open cutypecontract;
    Fetch cutypecontract
      Into regtypecont;
    pkerrors.pop;
    If regtypecont.status_contract_id Is Null Then
      Return(1);
    Else
      Return regtypecont.status_contract_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente de estado de la obligacion
               de la tabla ld_status_finan, ld_state_obligation_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugetstateobligation(sbesfina servsusc.sesuesfn%Type,
                                 sbsector ld_type_sector.type_id%Type,
                                 sbestcor servsusc.sesuesco%Type,
                                 nudebt   cuencobr.cucosacu%Type)
    Return Number Is

    Cursor custateobliga Is
      Select t.state_obligation_id
        From ld_state_obligation_cf t
       Where t.financial_status = sbesfina
         And t.product_status = decode(sbestcor, 96, 96, -1);

    Cursor custateobligb Is
      Select t.state_obligation_id
        From ld_state_obligation_cfb t
       Where t.financial_status = sbesfina
         And t.product_status = decode(sbestcor, 96, 96, -1)
         And debt_to_dc = decode(nudebt, Null, -1, 0, 0, 1);

    --regstateobl ld_state_obligation_cf%Rowtype;
    regstateobl ld_state_obligation_cf.state_obligation_id%Type;
    gsberrmsg   ge_error_log.description%Type;

  Begin
    pkerrors.push('ld_bcequivalreport.fnugetstateobligation');

    If sbsector = 2 Then

      Open custateobliga;
      Fetch custateobliga
        Into regstateobl;
      pkerrors.pop;
      If regstateobl /*.state_obligation_id*/
         Is Null Then
        Return(1);
      Else
        Return regstateobl; --.state_obligation_id;
      End If;

    Elsif sbsector = 1 Then
      Open custateobligb;
      Fetch custateobligb
        Into regstateobl;
      pkerrors.pop;
      If regstateobl /*.state_obligation_id*/
         Is Null Then
        Return(1);
      Else
        Return regstateobl; --.state_obligation_id;
      End If;
    End If;

  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(-1);
  End;

  /******************************************************************
  Propósito:   Obtiene el equivalente del tipo de identificación de la tabla ld_type_identificat_dc

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugetidentificationtypedc(ninidentype ge_subscriber.ident_type_id%Type)
    Return Number Is

    Cursor cuidentitype Is
      Select type_identificacion_id
        From ld_type_identificat_dc
       Where type_identification_equi = ninidentype;

    --regstateobl ld_state_obligation_cf%Rowtype;
    regidentype cuidentitype%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fnugetidentificationtypedc');
    Open cuidentitype;
    Fetch cuidentitype
      Into regidentype;
    pkerrors.pop;
    If cuidentitype%Notfound Then
      /*.state_obligation_id*/
      Return(0);
    Else
      Return(regidentype.type_identificacion_id); --.state_obligation_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(0);
  End;

  /******************************************************************
  Propósito:  Obtiene el equivalente del tipo de identificación de la tabla ld_type_identificat_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugetidentificationtypecf(ninidentype ge_subscriber.ident_type_id%Type)
    Return Number Is

    Cursor cuidentitype Is
      Select type_identificacion_id
        From ld_type_identificat_cf
       Where type_identification_equi = ninidentype;

    --regstateobl ld_state_obligation_cf%Rowtype;
    regidentype cuidentitype%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fnugetidentificationtypecf');
    Open cuidentitype;
    Fetch cuidentitype
      Into regidentype;
    pkerrors.pop;
    If cuidentitype%Notfound Then
      /*.state_obligation_id*/
      Return(0);
    Else
      Return(regidentype.type_identificacion_id); --.state_obligation_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(0);
  End;
  /******************************************************************
  Propósito:  Obtiene la descripcion de la Central de la tabla ld_credit_bureau

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugetcreditbureaudesc(ninidentype ld_credit_bureau.credit_bureau_id %Type)
    Return Varchar2 Is

    Cursor cuidentitype Is
      Select credit_bureau_desc
        From ld_credit_bureau
       Where credit_bureau_id = ninidentype;

    --regstateobl ld_state_obligation_cf%Rowtype;
    regidentype cuidentitype%Rowtype;
    gsberrmsg   ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fnugetcreditbureaudesc');
    Open cuidentitype;
    Fetch cuidentitype
      Into regidentype;
    pkerrors.pop;
    If cuidentitype%Notfound Then
      Return('Sin Descripcion');
    Else
      Return(regidentype.credit_bureau_desc); --.state_obligation_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(0);
  End;

  /******************************************************************
  Propósito:  Obtiene la descripcion de la Central de la tabla ld_service_category_cf

  Historia de Modificaciones

  15-06-2013      slemus
  Creación.
  ******************************************************************/

  Function fnugetservicecateg(insector ld_service_category_cf.sector_id %Type)
    Return Varchar2 Is

    Cursor cuservcateg Is
      Select service_category_id
        From ld_service_category_cf
       Where sector_id = insector;

    --regstateobl ld_state_obligation_cf%Rowtype;
    regsercat cuservcateg%Rowtype;
    gsberrmsg ge_error_log.description%Type;
  Begin
    pkerrors.push('ld_bcequivalreport.fnugetcreditbureaudesc');
    Open cuservcateg;
    Fetch cuservcateg
      Into regsercat;
    pkerrors.pop;
    If cuservcateg%Notfound Then
      Return('0');
    Else
      Return(regsercat.service_category_id); --.state_obligation_id;
    End If;
  Exception
    When Others Then

      pkerrors.notifyerror(pkerrors.fsblastobject, Sqlerrm, gsberrmsg);
      pkerrors.pop;
      raise_application_error(pkconstante.nuerror_level2, gsberrmsg);
      Return(0);
  End;

  /****************************************************************************
    Funcion       :  fsbVersion

    Descripcion :  Obtiene el SAO que identifica la version asociada a la
                     ultima entrega del paquete

    Retorno     :  csbVersion - Version del Paquete
  *****************************************************************************/

  Function fsbversion Return Varchar2 Is
  Begin
    --{
    -- Retorna el SAO con que se realizó la última entrega del paquete
    Return(csbversion);
    --}
  End fsbversion;
End ld_bcequivalreport;
/
GRANT EXECUTE on LD_BCEQUIVALREPORT to SYSTEM_OBJ_PRIVS_ROLE;
GRANT EXECUTE on LD_BCEQUIVALREPORT to REXEOPEN;
GRANT EXECUTE on LD_BCEQUIVALREPORT to RSELSYS;
/
