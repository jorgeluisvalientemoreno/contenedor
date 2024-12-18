CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_BOPROCESSLDCLT
IS

    sbLectura      ge_boInstanceControl.stysbValue;
    sbObservacion  ge_boInstanceControl.stysbValue;
    sbLeemcons     ge_boInstanceControl.stysbValue;
    sbOrden        ge_boInstanceControl.stysbValue;
    sbTaskTypeId   varchar2(100);
    sbParameter    ld_parameter.value_chain%type;
    nuLeemleto     lectelme.leemleto%type;
    rcHileelme     hileelme%rowtype;
    nuLectura      number;
    nuObservacion  number;
    nuLeemcons     number;
    nuOrden        number;
    nuTaskTypeId   number;
    nuUserID       number;
    nuCount        number;

BEGIN
    sbLeemcons     := ge_boInstanceControl.fsbGetFieldValue ('LECTELME', 'LEEMCONS');
    sbLectura      := ge_boInstanceControl.fsbGetFieldValue ('LECTELME', 'LEEMLEAN');
    sbObservacion  := ge_boInstanceControl.fsbGetFieldValue ('LECTELME', 'LEEMOBLE');
    sbOrden        := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID');

    ------------------------------------------------
    -- User code
    ------------------------------------------------

    BEGIN
        nuLectura := ut_convert.fnuchartonumber(sbLectura);
    EXCEPTION
       when OTHERS then
            gi_boerrors.seterrorcodeargument(-1,'La lectura ingresada no es válida!');
    END;

    nuLeemcons      :=  ut_convert.fnuchartonumber(sbLeemcons);
    nuObservacion   :=  ut_convert.fnuchartonumber(sbObservacion);
    nuOrden         :=  ut_convert.fnuchartonumber(sbOrden);
    -- Obtiene lectura anterior
    nuLeemleto      := pktbllectelme.fnugetleemleto(nuLeemcons);

    -- Valida que la lectura no sea negativa
    if  nuLectura < 0 OR nuLectura = nuLeemleto then
           gi_boerrors.seterrorcodeargument(-1,'La lectura ingresada no es válida!');
    END if;

    -- Valida que la órden no sea -1 cuando no existe órden asociada a la lectura
    if nuOrden = -1 then
           gi_boerrors.seterrorcodeargument(-1,'No se permite actualizar lectura a la órden '||nuOrden);
    END if;

    nuTaskTypeId := daor_order.fnugettask_type_id(nuOrden);

    -- Valida que el tipo de trabajo de la órden de lectura permita actualización
    sbTaskTypeId := ut_convert.fsbnumbertochar(nuTaskTypeId);
    sbParameter  := dald_parameter.fsbGetValue_Chain('LDC_TIPO_TRABAJO_LDCLT');

    if instr(sbParameter,sbTaskTypeId) = 0 then
          gi_boerrors.seterrorcodeargument(-1,'No se permite actualizar lectura para el tipo de trabajo ['||sbTaskTypeId||']');
    END if;

    /* Obtiene datos para insertar en histórico de lecturas */
    /* Lectura Actual */
    rcHileelme.hlemcons := SQ_HILEELME_HLEMCONS.nextval;
    rcHileelme.hlemelme := nuLeemcons;
    rcHileelme.hlemtcon := 1;
    rcHileelme.hlemleto := nuLectura;
    rcHileelme.hlemoble := nuObservacion;
    rcHileelme.hlemfele := sysdate;
    rcHileelme.hlemdocu := pktbllectelme.fnugetleemdocu(nuLeemcons);
    -- Obtiene Usuario
    nuUserID := PKLD_FA_REGLAS_DEFINIDAS.FNUGETUSERS;
    -- Obtiene persona asociada al usuario
    rcHileelme.hlempetl := GE_BCPERSON.FNUGETFIRSTPERSONBYUSERID(nuUserID);
    rcHileelme.hlemusua := dasa_user.fsbgetmask(nuUserID);
    rcHileelme.hlemprog := 'LDCLT';

    -- Verifica si en el histórico de lecturas existen registros, en ese caso
    -- sólo inserta el registro nuevo, en caso contrario inserta el registro nuevo
    -- y el anterior.

    -- Verifica si ya existen registros en el histórico de lecturas

    SELECT count(*) INTO nuCount FROM hileelme WHERE  hlemelme = nuLeemcons;

    -- Inserta en el histórico de lecturas la lectura actual
    pktblhileelme.insrecord(rcHileelme);

    if nuCount = 0 then
        /* Datos de la lectura anterior */
        rcHileelme.hlemcons := SQ_HILEELME_HLEMCONS.nextval;
        rcHileelme.hlemelme := nuLeemcons;
        rcHileelme.hlemtcon := 1;
        rcHileelme.hlemleto := nuLeemleto;
        rcHileelme.hlemoble := pktbllectelme.fnugetleemoble(nuLeemcons);
        rcHileelme.hlemfele := pktbllectelme.fdtgetleemfele(nuLeemcons);
        rcHileelme.hlemdocu := pktbllectelme.fnugetleemdocu(nuLeemcons);
        rcHileelme.hlempetl := pktbllectelme.fnugetleempetl(nuLeemcons);
        rcHileelme.hlemusua := null;
        rcHileelme.hlemprog := null;
        -- Inserta en el histórico de lecturas la lectura anterior
        pktblhileelme.insrecord(rcHileelme);
    END if;

    -- Actualiza la nueva lectura en LECTELME
    pktbllectelme.updleemleto(nuLeemcons,nuLectura);

    -- Actualiza la observación de Lectura
    pktbllectelme.updleemoble(nuLeemcons,nuObservacion);

    -- Asienta cambios en la BD
    pkgeneralservices.committransaction;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_BOPROCESSLDCLT;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_BOPROCESSLDCLT', 'ADM_PERSON');
END;
/
