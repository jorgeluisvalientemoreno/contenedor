CREATE OR REPLACE procedure ADM_PERSON.LDC_ENVIANOTIFSOLEMERGENCIA(inuPackageId in mo_packages.package_id%type,
																	inuContrato  in mo_motive.subscription_id%type,
																	inuCausal    in mo_motive.causal_id%type,
																	inuPackType  in mo_packages.package_type_id%type,
																	idtRequest   in mo_packages.request_date%type,
																	isbComment   in mo_packages.comment_%type
																	) is
 /*****************************************************************
  Propiedad intelectual de Gascaribe (c).

  Unidad         : LDC_ENVIANOTIFSOLEMERGENCIA
  Descripcion    : Notifica solicitudes de emergencia
  Autor          : dsaltarin
  Fecha          : 31/05/2022

  Parametros              Descripcion
  ============         ===================
  nuPackageId          Numero de la solicitud a notificar

  Fecha             Autor               Modificacion
  =========         =========           ====================
  27/06/2024        jpinedc             OSF-2606: * Se usa pkg_Correo
                                        * Ajustes por estándares
  ******************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) := 'ADM_PERSON.LDC_ENVIANOTIFSOLEMERGENCIA';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    sbAsunto   varchar2(200) := 'NOTIFICACION DE EMERGENCIAS';
    sbMensaje  varchar2(4000);
    sbInstance varchar2(32767);
    sbAddress  varchar2(32767);
    v_out number := 1;
    sbCorreo   ld_parameter.value_chain%type;
    nuContra   mo_motive.subscription_id%type;
    sbMailAt   ld_parameter.value_chain%type:=pkg_BCLD_Parameter.fsbObtieneValorCadena('MAIL_ATLANTICO_EMER');
    sbMailMg   ld_parameter.value_chain%type:=pkg_BCLD_Parameter.fsbObtieneValorCadena('MAIL_MAGDALENA_EMER');
    sbMailCe   ld_parameter.value_chain%type:=pkg_BCLD_Parameter.fsbObtieneValorCadena('MAIL_CESAR_EMER');
    nuLoca     ge_geogra_location.geograp_location_id%type;
    nuDepa     ge_geogra_location.geograp_location_id%type;
    nuPackageId mo_packages.package_id%type;
    nuContrato  mo_motive.subscription_id%type;
    nuCausal    mo_motive.causal_id%type;
    nuPackType  mo_packages.package_type_id%type;
    dtRequest   mo_packages.request_date%type;
    sbComment   mo_packages.comment_%type;
    nuError     number;
    sbError     varchar2(4000);
    nuSend      number;
    sbTipoIns    varchar2(4000);

    sbfromdisplay Varchar2(4000) := 'Open SmartFlex';

    cursor cuMail(sbMail varchar2) is
    SELECT regexp_substr(sbMail,'[^,]+', 1,LEVEL) mail
    FROM dual
    CONNECT BY regexp_substr(sbMail, '[^,]+', 1, LEVEL) IS NOT NULL;

    cursor cuDatos is
    select p.package_id,
           p.package_type_id,
           s.package_type_id sol_tab,
           m.causal_id,
           nvl(m.subscription_id, (select sesususc from servsusc ss where ss.sesunuse=m.product_id)) contrato,
           p.request_date fecha_sol,
           p.comment_     comentario,
           di.geograp_location_id localidad,
           di.address_id,
           di.address_parsed,
           a.order_id,
           s.rowid
    from ldc_solemernot s
    left join mo_packages p on s.package_id = p.package_id
    left join mo_motive m on p.package_id = m.package_id
    left join mo_address ma on ma.package_id =m.package_id
    left join ab_address di on di.address_id = nvl(sbAddress, ma.parser_address_id)
    left join or_order_activity a on a.package_id = p.package_id;



    function fnuGetMailxDepa(nuCodLoca ge_geogra_location.geograp_location_id%type)
         return varchar2 is

    begin
       nuDepa  := dage_geogra_location.fnugetgeo_loca_father_id(nuCodLoca);
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

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
    
    sbTipoIns := UT_DBINSTANCE.FSBGETCURRENTINSTANCETYPE;

    if inuPackageId != -1 then
        if inuPackType = 308 then
           GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(sbInstance);

            if GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK('WORK_INSTANCE', NULL, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', v_out) = CONSTANTS_PER.GETTRUE THEN
              prc_ObtieneValorInstancia( 'WORK_INSTANCE', NULL, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', sbAddress );
            else
              if GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(sbInstance, NULL, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', v_out) = CONSTANTS_PER.GETTRUE THEN
                prc_ObtieneValorInstancia( sbInstance, NULL, 'MO_PROCESS','ADDRESS_MAIN_MOTIVE', sbAddress );
              end if;
            end if;

        else
            --se tomala direcci?n del producto
            begin
                select p.address_id
                 into sbAddress
                 from pr_product p
                where p.subscription_id =  inuContrato
                  and p.product_type_id = 7014;
            exception
                when others then
                   sbAddress :=null;
            end;
       end if;
       nuLoca := daab_address.fnugetgeograp_location_id(sbAddress, null);
       nuPackageId := inuPackageId;
       nuContrato  := inuContrato;
       nuCausal    := inuCausal;
       nuPackType  := inuPackType;
       dtRequest   := idtRequest;
       sbComment   := isbComment;
       sbMensaje := '<p style="font-family:verdana">Se requiere dar prioridad en el menor tiempo posible al siguiente requerimiento: '||nuCausal||' '||dacc_causal.fsbgetdescription(nuCausal, null)||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Teniendo en cuenta que los datos del cliente son:'||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'CONTRATO: '||nvl(nuContrato,-1)||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Numero de la solicitud: '||nuPackageId||' Nombre de la solicitud: '||nuPackType||' '||daps_package_type.fsbgetdescription(nuPackType,  null)||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Fecha de Registro: '||dtRequest||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Direcci'||chr(243)||'n: '||daab_address.fsbgetaddress_parsed(sbAddress, null)||chr(13)||chr(13)||'</br>';
       sbMensaje := sbMensaje ||'Localidad: '||nuLoca||' '||dage_geogra_location.fsbgetdescription(nuLoca, null)||chr(13)||chr(13)||'</br>';
       sbMensaje := substr(sbMensaje ||'Observaci'||chr(243)||'n:'||sbComment||'</p>',0,2000);
       sbcorreo := fnuGetMailxDepa(nuLoca);
       for mail in cuMail(sbcorreo) loop
         begin
            if mail.mail is not null then
           
                pkg_Correo.prcEnviaCorreo
                (
                    isbDestinatarios    => mail.mail,
                    isbAsunto           => sbAsunto,
                    isbMensaje          => sbMensaje,
                    isbDescRemitente    => sbfromdisplay
                );            
           
           end if;
         exception
           when others then
              pkg_Error.setError;
              pkg_Error.getError(nuError, sbError);
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
            sbMensaje := '<p style="font-family:verdana">Se requiere dar prioridad en el menor tiempo posible al siguiente requerimiento: '||nuCausal||' '||dacc_causal.fsbgetdescription(nuCausal, null)||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Teniendo en cuenta que los datos del cliente son:'||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Contrato: '||nvl(nuContrato,-1)||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Numero de la solicitud: '||nuPackageId||'  Nombre de la solicitud: '||nuPackType||' '||daps_package_type.fsbgetdescription(nuPackType,  null)||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Numero de la orden: '||reg.order_id||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Fecha de Registro: '||dtRequest||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Direcci'||chr(243)||'n: '||reg.address_parsed||chr(13)||chr(13)||'</br>';
            sbMensaje := sbMensaje ||'Localidad: '||nuLoca||' '||dage_geogra_location.fsbgetdescription(nuLoca, null)||chr(13)||chr(13)||'</br>';
            sbMensaje := substr(sbMensaje ||'Observaci'||chr(243)||'n:'||reg.Comentario||'</p>',0,2000);
            nuSend := 0;
            sbcorreo := fnuGetMailxDepa(nuLoca);
            for mail in cuMail(sbcorreo) loop
             begin
                if mail.mail is not null then
                    pkg_Correo.prcEnviaCorreo
                    (
                        isbDestinatarios    => mail.mail,
                        isbAsunto           => sbAsunto,
                        isbMensaje          => sbMensaje,
                        isbDescRemitente    => sbfromdisplay
                    );                             
                 nuSend := nuSend+1;
               end if;
             exception
               when others then
                  pkg_Error.setError;
                  pkg_Error.getError(nuError, sbError);
             end;
           end loop;
           if nuSend>0 then
             delete ldc_solemernot where rowid=reg.rowid;
             commit;
           end if;
          end if;
       exception
         when others then
             pkg_Error.setError;
             pkg_Error.getError(nuError, sbError);
       end;
      end loop;
    end if;
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);    
EXCEPTION
 WHEN pkg_Error.CONTROLLED_ERROR then
    pkg_Error.getError(nuError, sbError);
    pkg_Traza.Trace('LDC_TRBISOL_EMER->Exc controlada:'||sbError,csbNivelTraza);
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuError, sbError);
    pkg_Traza.Trace('LDC_TRBISOL_EMER->Exc no controlada:'||sbError,csbNivelTraza);
end;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_ENVIANOTIFSOLEMERGENCIA', 'ADM_PERSON');
END;
/

