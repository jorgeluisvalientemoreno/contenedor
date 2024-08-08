PL/SQL Developer Test script 3.0
247
declare
inuPackageId open.mo_packages.package_id%type:=-1;
inuContrato  open.mo_motive.subscription_id%type:=-1;
inuCausal    open.mo_motive.causal_id%type:=-1;
inuPackType  open.mo_packages.package_type_id%type:=-1;
idtRequest   open.mo_packages.request_date%type;
isbComment   open.mo_packages.comment_%type;
 /*****************************************************************
  Propiedad intelectual de Gascaribe (c).

  Unidad         : LDC_ENVIANOTIFSOLEMERGENCIA
  Descripcion    : Notifica solicitudes de emergencia
  Autor          : dsaltarin
  Fecha          : 31/05/2022

  Parametros              Descripcion
  ============         ===================
  nuPackageId          Numero de la solicitud a notificar

  Fecha             Autor             Modificacion
  =========       =========           ====================
  ******************************************************************/

    sbAsunto   varchar2(200) := 'NOTIFICACION DE EMERGENCIAS';
    sbMensaje  varchar2(4000);
    sbInstance varchar2(32767);
    sbAddress  varchar2(32767);
    v_out number := 1;
    sbCorreo   ge_person.e_mail%type;
    nuContra   mo_motive.subscription_id%type;
    sender     open.ld_parameter.value_chain%type:=DALD_PARAMETER.fsbGetValue_Chain('LDC_SMTP_SENDER', null);
    sbMailAt   open.ld_parameter.value_chain%type:=DALD_PARAMETER.fsbGetValue_Chain('MAIL_ATLANTICO_EMER', null);
    sbMailMg   open.ld_parameter.value_chain%type:=DALD_PARAMETER.fsbGetValue_Chain('MAIL_MAGDALENA_EMER', null);
    sbMailCe   open.ld_parameter.value_chain%type:=DALD_PARAMETER.fsbGetValue_Chain('MAIL_CESAR_EMER', null);
    nuLoca     open.ge_geogra_location.geograp_location_id%type;
    nuDepa     open.ge_geogra_location.geograp_location_id%type;
    nuPackageId open.mo_packages.package_id%type;
    nuContrato  open.mo_motive.subscription_id%type;
    nuCausal    open.mo_motive.causal_id%type;
    nuPackType  open.mo_packages.package_type_id%type;
    dtRequest   open.mo_packages.request_date%type;
    sbComment   open.mo_packages.comment_%type;
    nuError     number;
    sbError     varchar2(4000);
    nuSend      number;
    sbTipoIns    varchar2(4000);

    sbfromdisplay Varchar2(4000) := 'Open SmartFlex';
    --Destinatarios
    sbtodisplay Varchar2(4000) := '';
    sbcc        ut_string.tytb_string;
    sbccdisplay ut_string.tytb_string;
    sbbcc       ut_string.tytb_string;
    sbfilename    Varchar2(255);
    sbfileext     Varchar2(10);
    sbcontenttype Varchar2(100) := 'text/html';
    adjunto       Blob; --file type del archivo final a enviar



    cursor cuMail(sbMail varchar2) is
    select column_value mail
        from table (ldc_boutilities.SPLITstrings(sbMail,','));

    cursor cuDatos is
    select p.package_id,
           p.package_type_id,
           s.package_type_id sol_tab,
           m.causal_id,
           nvl(m.subscription_id, (select sesususc from open.servsusc ss where ss.sesunuse=m.product_id)) contrato,
           p.request_date fecha_sol,
           p.comment_     comentario,
           di.geograp_location_id localidad,
           di.address_id,
           di.address_parsed,
           a.order_id,
           s.rowid
    from open.ldc_solemernot s
    left join open.mo_packages p on s.package_id = p.package_id
    left join open.mo_motive m on p.package_id = m.package_id
    left join open.mo_address ma on ma.package_id =m.package_id
    left join open.ab_address di on di.address_id = nvl(sbAddress, ma.parser_address_id)
    left join open.or_order_activity a on a.package_id = p.package_id;



    function fnuGetMailxDepa(nuCodLoca open.ge_geogra_location.geograp_location_id%type)
         return varchar2 is

    begin
       nuDepa  := open.dage_geogra_location.fnugetgeo_loca_father_id(nuCodLoca);
       if nuDepa = 2 then
         return sbMailCe;
       elsif nuDepa = 3 then
        return sbMailAt;
       elsif nuDepa = 4 then
        return sbMailMg;
       else
        return null;
       end if;
    end;


begin

    sbTipoIns := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;
    if sbTipoIns !='P' then
       sbAsunto :='BD PRUEBAS: '||sbAsunto;
    end if;
    if inuPackageId != -1 then
       if inuPackType = 308 then
           GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);

            if GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK('WORK_INSTANCE', NULL, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', v_out) = GE_BOCONSTANTS.GETTRUE THEN
              GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( 'WORK_INSTANCE', NULL, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', sbAddress );
            else
              if GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, NULL, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', v_out) = GE_BOCONSTANTS.GETTRUE THEN
                GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE( sbInstance, NULL, 'MO_PROCESS','ADDRESS_MAIN_MOTIVE', sbAddress );
              end if;
            end if;

       else
         --se tomala direcci?n del producto
         begin
           select p.address_id
             into sbAddress
             from open.pr_product p
            where p.subscription_id =  inuContrato
              and p.product_type_id = 7014;
         exception
           when others then
               sbAddress :=null;
         end;

       end if;
       nuLoca := open.daab_address.fnugetgeograp_location_id(sbAddress, null);
       nuPackageId := inuPackageId;
       nuContrato  := inuContrato;
       nuCausal    := inuCausal;
       nuPackType  := inuPackType;
       dtRequest   := idtRequest;
       sbComment   := isbComment;
       sbMensaje := '<p style="font-family:verdana">Se requiere dar prioridad en el menor tiempo posible al siguiente requerimiento: '||nuCausal||' '||open.dacc_causal.fsbgetdescription(nuCausal, null)||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Teniendo en cuenta que los datos del cliente son:'||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'CONTRATO: '||nvl(nuContrato,-1)||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Numero de la solicitud: '||nuPackageId||' Nombre de la solicitud: '||nuPackType||' '||open.daps_package_type.fsbgetdescription(nuPackType,  null)||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Fecha de Registro: '||dtRequest||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Direcci'||chr(243)||'n: '||daab_address.fsbgetaddress_parsed(sbAddress, null)||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Localidad: '||nuLoca||' '||open.dage_geogra_location.fsbgetdescription(nuLoca, null)||chr(13)||chr(13)||'</br>';
       sbMensaje := substr(sbMensaje ||'Observaci'||chr(243)||'n:'||sbComment||'</p>',0,2000);
       sbcorreo := fnuGetMailxDepa(nuLoca);
       for mail in cuMail(sbcorreo) loop
         begin
           if mail.mail is not null then
               ut_mailpost.sendmailblobattachsmtp(sender,
                                                 sbfromdisplay,
                                                 mail.mail ,
                                                 sbtodisplay,
                                                 sbcc,
                                                 sbccdisplay,
                                                 sbbcc,
                                                 sbAsunto,
                                                 sbMensaje,
                                                 sbcontenttype,
                                                 sbfilename,
                                                 sbfileext,
                                                 adjunto);
           end if;
         exception
           when others then
              ERRORS.SETERROR;
              ERRORS.GETERROR(nuError, sbError);
         end;
       end loop;
    else
      for reg in cuDatos loop
        begin
          if reg.package_id is null or reg.package_type_id!=reg.sol_tab then
            delete ldc_solemernot where rowid=reg.rowid;
            commit;
          else

            nuLoca := reg.Localidad;
            nuPackageId := reg.Package_Id;
            nuContrato  := reg.Contrato;
            nuCausal    := reg.Causal_Id;
            nuPackType  := reg.Package_Type_Id;
            dtRequest   := reg.Fecha_Sol;
            sbComment   := reg.Comentario;
            sbAddress   := reg.address_id;
            sbMensaje := '<p style="font-family:verdana">Se requiere dar prioridad en el menor tiempo posible al siguiente requerimiento: '||nuCausal||' '||open.dacc_causal.fsbgetdescription(nuCausal, null)||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Teniendo en cuenta que los datos del cliente son:'||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Contrato: '||nvl(nuContrato,-1)||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Numero de la solicitud: '||nuPackageId||'  Nombre de la solicitud: '||nuPackType||' '||open.daps_package_type.fsbgetdescription(nuPackType,  null)||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Numero de la orden: '||reg.order_id||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Fecha de Registro: '||dtRequest||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Direcci'||chr(243)||'n: '||reg.address_parsed||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Localidad: '||nuLoca||' '||open.dage_geogra_location.fsbgetdescription(nuLoca, null)||chr(13)||chr(13)||'</br>';
            sbMensaje := substr(sbMensaje ||'Observaci'||chr(243)||'n:'||reg.Comentario||'</p>',0,2000);
            nuSend := 0;
            sbcorreo := fnuGetMailxDepa(nuLoca);
            for mail in cuMail(sbcorreo) loop
             begin
               if mail.mail is not null then
                 ut_mailpost.sendmailblobattachsmtp(sender,
                                                 sbfromdisplay,
                                                 mail.mail ,
                                                 sbtodisplay,
                                                 sbcc,
                                                 sbccdisplay,
                                                 sbbcc,
                                                 sbAsunto,
                                                 sbMensaje,
                                                 sbcontenttype,
                                                 sbfilename,
                                                 sbfileext,
                                                 adjunto);

                 nuSend := nuSend+1;
               end if;
             exception
               when others then
                  ERRORS.SETERROR;
                  ERRORS.GETERROR(nuError, sbError);
             end;
           end loop;
           if nuSend>0 then
             delete ldc_solemernot where rowid=reg.rowid;
             commit;
           end if;
          end if;
       exception
         when others then
             ERRORS.SETERROR;
             ERRORS.GETERROR(nuError, sbError);
       end;
      end loop;
    end if;
EXCEPTION
 WHEN ex.Controlled_error then
    ERRORS.GETERROR(nuError, sbError);
    ut_trace.trace('LDC_TRBISOL_EMER->Exc controlada:'||sbError,99);
  WHEN OTHERS THEN
    ERRORS.SETERROR;
    ERRORS.GETERROR(nuError, sbError);
    ut_trace.trace('LDC_TRBISOL_EMER->Exc no controlada:'||sbError,99);
end;
0
0
