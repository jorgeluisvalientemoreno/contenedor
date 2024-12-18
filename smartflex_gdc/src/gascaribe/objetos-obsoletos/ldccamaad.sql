CREATE OR REPLACE PROCEDURE LDCCAMAAD(inuProgramacion in ge_process_schedule.process_schedule_id%type) IS

/*******************************************************************************
    Propiedad Intelectual de Gases del Caribe
    
	Programa 	: LDCCAMAAD
	Autor       : 
    Fecha       : 
    Descripcion : Programación de actualizacion masiva de datos de clientes
                  ejecutable LDCCAMAAD
    
	Modificaciones  :
    Autor       Fecha       Caso     Descripcion
  	jsoto		    18/01/2024	OSF-2024 Reemplazar API OS_REGISTERREQUESTWITHXML por API_REGISTERREQUESTBYXML
                                     OS_CUSTOMERREGISTER por API_CUSTOMERREGISTER
*******************************************************************************/

nuerror                NUMBER(3) := 0;
sbmensa                VARCHAR2(4000);
sbParametros           ge_process_schedule.parameters_%TYPE;
nuparano               NUMBER(4);
nuparmes               NUMBER(2);
nutsess                NUMBER;
sbparuser              VARCHAR2(30);
nuHilos                NUMBER := 1;
nuLogProceso           ge_log_process.log_process_id%TYPE;
sbdirectory            open.ge_directory.path%TYPE;
sbnomarch              ge_subscriber.e_mail%TYPE;
nuiddirectorio         ge_directory.directory_id%TYPE;
sbruradirectorio       ge_directory.path%TYPE;
cadena                 VARCHAR2(10000);
sbrequestxml1          VARCHAR2(10000);
nupackageid            mo_packages.package_id%TYPE;
numotiveid             mo_motive.motive_id%TYPE;
nuerrorcode            NUMBER;
sberrormessage         VARCHAR2(2000);
dtfechasoli            mo_packages.request_date%TYPE;
numere                 mo_packages.reception_type_id%TYPE;
sbcomment              mo_packages.comment_%TYPE;
vfile                  utl_file.file_type;
vfileinco              utl_file.file_type;
nuregenco              NUMBER(10) DEFAULT 0;
nuregprok              NUMBER(10) DEFAULT 0;
nuregpnok              NUMBER(10) DEFAULT 0;
nulineaarch            NUMBER(10) DEFAULT 0;
sbnomarchres           VARCHAR2(100);
sbmensajeinco          VARCHAR2(4000);
v_ident_type_id        ge_subscriber.ident_type_id%TYPE;
v_identification       ge_subscriber.identification%TYPE;
v_subscriber_type_id   ge_subscriber.subscriber_type_id%TYPE;
v_address              ge_subscriber.address%TYPE;
v_phone                ge_subscriber.phone%TYPE;
v_subscriber_name      ge_subscriber.subscriber_name%TYPE;
v_subs_last_name       ge_subscriber.subs_last_name%TYPE;
v_e_mail               ge_subscriber.e_mail%TYPE;
nunuevcli              mo_packages.package_id%TYPE;
nucliecrea             ge_subscriber.subscriber_id%TYPE;
sbtelcel               ge_subs_phone.phone%TYPE;
sbtelcont              ge_subs_phone.phone%TYPE;
dtfechnam              ge_subs_general_data.date_birth%TYPE;
sbgenero               ge_subs_general_data.gender%TYPE;
nuprofesion            ge_subs_general_data.profession_id%TYPE;
nuniveling             ge_subs_general_data.debit_scale_id%TYPE;
nuestcivil             ge_subs_general_data.civil_state_id%TYPE;
sbeneant               ge_subs_general_data.old_operator%TYPE;
nrohabcas              ge_subs_housing_data.person_quantity%TYPE;
tipovivi               ge_subs_housing_data.house_type_id%TYPE;
nutiempvivi            ge_subs_housing_data.years_living_in_town%TYPE;
nuactivi               ge_subs_work_relat.activity_id%TYPE;
sbarealab              ge_subs_work_relat.work_area%TYPE;
sbemplab               ge_subs_work_relat.company%TYPE;
sbtieveh               ge_subs_family_data.has_vehicule%TYPE;
nutemaint              ge_subs_interest.interest_data_id%TYPE;
nuhobbis               ge_subs_hobbies.hobbies_id%TYPE;
sbnomener              ge_third_part_serv.service_name%TYPE;
nucostmen              ge_third_part_serv.monthly_cost%TYPE;
nutiemene              ge_third_part_serv.service_time%TYPE;
nuestley               ldc_proteccion_datos.cod_estado_ley%TYPE;
nurefper               ge_subs_referen_data.reference_type_id%TYPE;
sbnombref              ge_subs_referen_data.name_%TYPE;
sbapellref             ge_subs_referen_data.last_name%TYPE;
sbtelref               ge_subs_referen_data.phone%TYPE;
nuconta                NUMBER(8) DEFAULT 0;
execptionvalida        EXCEPTION;
nucontrato             suscripc.susccodi%TYPE;
nuclientetram          ge_subscriber.subscriber_id%TYPE;
BEGIN
 nuerror := -1;
 SELECT to_number(to_char(SYSDATE,'YYYY')),to_number(to_char(SYSDATE,'MM')),userenv('SESSIONID'),USER
   INTO nuparano,nuparmes,nutsess,sbparuser
   FROM dual;
  -- Se inicia log del programa
 nuerror := -2;
 ldc_proinsertaestaprog(nuparano,nuparmes,'LDCCAMAAD','En ejecucion',nutsess,sbparuser);
  -- Se adiciona al log de procesos
 nuerror := -3;
 ge_boschedule.AddLogToScheduleProcess(inuProgramacion,nuHilos,nuLogProceso);
  -- se obtiene parametros
 sbParametros := open.dage_process_schedule.fsbgetparameters_(inuProgramacion);
 sbdirectory  := TRIM(open.ut_string.getparametervalue(sbParametros,'PATH','|','='));
 sbnomarch    := TRIM(open.ut_string.getparametervalue(sbParametros,'SUBSCRIBER_NAME','|','='));
 -- Obtenemos la ruta del directorio
 nuerror := -4;
 nuiddirectorio := to_number(sbdirectory);
   SELECT di.path INTO sbruradirectorio
     FROM open.ge_directory di
    WHERE di.directory_id = nuiddirectorio;
 -- Abrimos el archivo para lectura
 nuerror := -5;
 sbnomarchres := 'resultado_act_datos'||to_char(SYSDATE, 'YYYY_MM_DD_HH_MI_SS')||'.txt';
 sbruradirectorio := TRIM(sbruradirectorio);
 sbnomarch        := lower(TRIM(sbnomarch));
 vfile            := utl_file.fopen(sbruradirectorio,sbnomarch,'R');
 vfileinco        := utl_file.fopen(sbruradirectorio,sbnomarchres,'W');
 -- Recorre el archivo
 nuerror := -6;
 nuregenco   := 0;
 nuregprok   := 0;
 nuregpnok   := 0;
 nulineaarch := 0;
 LOOP
  cadena := NULL;
  BEGIN
   nulineaarch := nulineaarch + 1;
   utl_file.get_line(vfile,cadena);
   nuregenco := nuregenco + 1;
  EXCEPTION
   WHEN no_data_found THEN
    EXIT;
  END;
   dtfechasoli   := SYSDATE;
   numere        := dald_parameter.fnuGetNumeric_Value('MEDIO_RECE_100318');
   sbcomment     := dald_parameter.fsbGetValue_Chain('COMENTARIO_100318'); 
   nuclientetram := NULL;
   nucontrato    := to_number(nvl(TRIM(substr(cadena,16,8)),'-1'));
   IF nucontrato >= 1 THEN
    BEGIN
     SELECT scx.suscclie INTO nuclientetram
       FROM suscripc scx
      WHERE susccodi = nucontrato;
    EXCEPTION
     WHEN no_data_found THEN
      nuclientetram := NULL;
    END;
   ELSE
    nucontrato := NULL; 
   END IF;
   v_ident_type_id      := to_number(nvl(TRIM(substr(cadena,24,4)),-1));
   v_identification     := TRIM(substr(cadena,28,20));
   v_subscriber_type_id := TRIM(substr(cadena,48,4));
   v_address            := TRIM(substr(cadena,52,50));
   v_phone              := TRIM(substr(cadena,102,30));
   v_subscriber_name    := TRIM(substr(cadena,132,50));
   v_subs_last_name     := TRIM(substr(cadena,182,50));
   v_e_mail             := TRIM(substr(cadena,232,50));
   -- Datos ge_subs_phone
   sbtelcel             := TRIM(substr(cadena,282,30));
   -- Datos ge_subs_general_data
   dtfechnam            := to_date(TRIM(substr(cadena,312,10)),'DD/MM/YYYY');
   sbgenero             := TRIM(substr(cadena,322,1));
   IF sbgenero = '-' THEN
    sbgenero := NULL;
   END IF;
   nuprofesion          := to_number(nvl(TRIM(substr(cadena,323,15)),-1));
   nuniveling           := to_number(nvl(TRIM(substr(cadena,338,15)),-1));
   nuestcivil           := to_number(nvl(TRIM(substr(cadena,353,4)),-1));
   -- Datos ge_subs_housing_data
   nrohabcas            := to_number(nvl(TRIM(substr(cadena,357,4)),-1));
   tipovivi             := to_number(nvl(TRIM(substr(cadena,361,4)),-1));
   nutiempvivi          := to_number(nvl(TRIM(substr(cadena,365,4)),-1));
   -- Datos ge_subs_work_relat
   nuactivi             := to_number(nvl(TRIM(substr(cadena,369,15)),-1));
   sbarealab            := TRIM(substr(cadena,384,50));
   sbemplab             := TRIM(substr(cadena,434,50));
   -- Datos ge_subs_family_data
   sbtieveh             := TRIM(substr(cadena,484,1));
   -- Datos ge_subs_interest
   nutemaint            := to_number(nvl(TRIM(substr(cadena,485,15)),-1));
   -- Datos ge_subs_hobbies
   nuhobbis             := to_number(nvl(TRIM(substr(cadena,500,15)),-1));
   sbeneant             := TRIM(substr(cadena,515,50));
   -- Datos ge_third_part_serv
   sbnomener            := TRIM(substr(cadena,565,50));
   nucostmen            := to_number(nvl(TRIM(substr(cadena,615,11)),-1));
   nutiemene            := to_number(nvl(TRIM(substr(cadena,626,4)),-1));
   -- Datos ldc_proteccion de datos
   nuestley             := to_number(nvl(TRIM(substr(cadena,630,15)),-1));
   -- Datos ge_subs_referen_data
   nurefper             := to_number(nvl(TRIM(substr(cadena,645,4)),-1));
   sbnombref            := TRIM(substr(cadena,649,50));
   sbapellref           := TRIM(substr(cadena,699,50));
   sbtelref             := TRIM(substr(cadena,749,30));
   sbtelcont            := TRIM(substr(cadena,779,30));
     -- Consultamos la identificacion para saber si el cliente essubs nuevo o no
    BEGIN
     SELECT MAX(cln.subscriber_id) INTO nunuevcli
       FROM ge_subscriber cln
      WHERE TRIM(cln.identification) = v_identification;
    EXCEPTION
      WHEN no_data_found THEN
          nunuevcli := NULL;
      END;
   -- Validamos si el cliente es nuevo para crearlo
   IF nunuevcli IS NULL THEN
      nuerrorcode    := NULL;
      sberrormessage := NULL;
      nucliecrea     := NULL;
      api_customerregister(
                           nucliecrea
                          ,v_ident_type_id
                          ,v_identification
                          ,NULL
                          ,v_subscriber_type_id
                          ,v_address
                          ,v_phone
                          ,v_subscriber_name
                          ,v_subs_last_name
                          ,v_e_mail
                          ,NULL
                          ,NULL
                          ,NULL
                          ,NULL
                          ,NULL
                          ,NULL
                          ,NULL
                          ,NULL
                          ,NULL
                          ,NULL
                          ,nuerrorcode
                          ,sberrormessage
                          );
      IF nucliecrea IS NOT NULL THEN
        nunuevcli     := nucliecrea;
      ELSE
        ROLLBACK;
        sbmensajeinco := 'Linea archivo : '||to_char(nulineaarch)||' cliente no generado : '||to_char(nupackageid)||' mensaje : '||to_char(nuerrorcode)||' - '||sberrormessage;
        utl_file.put_line(vfileinco,sbmensajeinco);
       END IF;
   ELSE
      IF v_address IS NOT NULL THEN
          UPDATE ge_subscriber cl
             SET cl.address = v_address
           WHERE cl.subscriber_id = nunuevcli;
        END IF;
        IF v_phone IS NOT NULL THEN
          UPDATE ge_subscriber cl
             SET cl.phone = v_phone
           WHERE cl.subscriber_id = nunuevcli;
        END IF;
        IF v_e_mail IS NOT NULL THEN
          UPDATE ge_subscriber cl
             SET cl.e_mail = v_e_mail
           WHERE cl.subscriber_id = nunuevcli;
        END IF;
   END IF;
     nucliecrea    := nunuevcli;
     nuclientetram := nunuevcli;
   -- Registramos telefono celular
   IF sbtelcel IS NOT NULL THEN
      SELECT COUNT(1) INTO nuconta
        FROM ge_subs_phone sp
       WHERE sp.subscriber_id = nucliecrea
         AND TRIM(sp.phone) = sbtelcel;
           IF nuconta = 0 THEN
              INSERT INTO ge_subs_phone
                (subscriber_id, subs_phone_id, phone,description,phone_type_id)
              VALUES
                (nucliecrea,seq_ge_subs_phone.nextval,sbtelcel,'TELEFONO CELULAR',1);
           END IF;
   END IF;
   -- Registramos telefono fijo
   IF sbtelcont IS NOT NULL THEN
    SELECT COUNT(1) INTO nuconta
        FROM ge_subs_phone sp
       WHERE sp.subscriber_id = nucliecrea
         AND TRIM(sp.phone) = sbtelcont;
       IF nuconta = 0 THEN
        INSERT INTO ge_subs_phone
                (subscriber_id, subs_phone_id, phone,description,phone_type_id)
              VALUES
                (nucliecrea,seq_ge_subs_phone.nextval,sbtelcont,'TELEFONO CONTACTO',3);
       END IF;
   END IF;
   -- Registramos en ge_subs_general_data
   IF dtfechnam IS NOT NULL OR sbgenero <> '-' OR nuprofesion <> -1 OR nuniveling <> -1 OR nuestcivil <> -1 OR sbeneant IS NOT NULL THEN
    SELECT COUNT(1) INTO nuconta
      FROM ge_subs_general_data gd
     WHERE gd.subscriber_id = nucliecrea;
     IF nuconta = 0 THEN
      IF nuniveling = -1 THEN
       nuniveling := NULL;
      END IF;
      INSERT INTO ge_subs_general_data(subscriber_id,date_birth,gender,profession_id,debit_scale_id,civil_state_id,old_operator)
               VALUES(nucliecrea,dtfechnam,sbgenero,nuprofesion,nuniveling,nuestcivil,sbeneant);
     ELSE
       -- Actualizamos general_data
       IF dtfechnam IS NOT NULL THEN
           UPDATE ge_subs_general_data gd
              SET gd.date_birth = dtfechnam
            WHERE gd.subscriber_id = nucliecrea;
          END IF;
          IF sbgenero IS NOT NULL THEN
            UPDATE ge_subs_general_data gd
              SET gd.gender = sbgenero
            WHERE gd.subscriber_id = nucliecrea;
          END IF;
          IF nuprofesion <> -1 THEN
           UPDATE ge_subs_general_data gd
              SET gd.profession_id = nuprofesion
            WHERE gd.subscriber_id = nucliecrea;
          END IF;
          IF nuniveling <> -1 THEN
           UPDATE ge_subs_general_data gd
              SET gd.wage_scale_id = nuniveling
            WHERE gd.subscriber_id = nucliecrea;
          END IF;
          IF nuestcivil <> -1 THEN
           UPDATE ge_subs_general_data gd
              SET gd.civil_state_id = nuestcivil
            WHERE gd.subscriber_id = nucliecrea;
          END IF;
          IF sbeneant IS NOT NULL THEN
           UPDATE ge_subs_general_data gd
              SET gd.old_operator = sbeneant
            WHERE gd.subscriber_id = nucliecrea;
          END IF;
     END IF;
   END IF;
    --- Registramos en ge_subs_housing_data
   IF nrohabcas <> -1 OR tipovivi <> -1 OR nutiempvivi <> -1 THEN
    SELECT COUNT(1) INTO nuconta
      FROM ge_subs_housing_data hd
     WHERE hd.subscriber_id = nucliecrea;
     IF nuconta = 0 THEN
      IF tipovivi = -1 THEN
         tipovivi := NULL;
      END IF;
      INSERT INTO ge_subs_housing_data(subscriber_id,person_quantity,house_type_id,years_living_house)
           VALUES(nucliecrea,nrohabcas,tipovivi,nutiempvivi);
    ELSE
    -- Actualizamos en ge_subs_housing_data
       IF nrohabcas <> -1 THEN
        UPDATE ge_subs_housing_data sh
           SET sh.person_quantity = nrohabcas
         WHERE sh.subscriber_id = nucliecrea;
       END IF;
       IF tipovivi <> -1 THEN
        UPDATE ge_subs_housing_data sh
           SET sh.house_type_id = tipovivi
         WHERE sh.subscriber_id = nucliecrea;
       END IF;
       IF nutiempvivi <> -1 THEN
        UPDATE ge_subs_housing_data sh
           SET sh.years_living_house = nrohabcas
         WHERE sh.subscriber_id = nucliecrea;
       END IF;
    END IF;
   END IF;
    --- Registramos en ge_subs_work_relat
   IF nuactivi <> -1 OR sbarealab IS NOT NULL OR sbemplab IS NOT NULL THEN
    SELECT COUNT(1) INTO nuconta
      FROM ge_subs_work_relat ws
     WHERE ws.subscriber_id = nucliecrea;
     IF nuconta = 0 THEN
      IF nuactivi = -1 THEN
       nuactivi := NULL;
      END IF;
      INSERT INTO ge_subs_work_relat(subscriber_id,activity_id,work_area,company)
               VALUES(nucliecrea,nuactivi,sbarealab,sbemplab);
     ELSE
     -- Actualizamos en ge_subs_work_relat
       IF nuactivi <> -1 THEN
        UPDATE ge_subs_work_relat wr
           SET wr.activity_id = nuactivi
         WHERE wr.subscriber_id = nucliecrea;
       END IF;
       IF sbarealab IS NOT NULL THEN
        UPDATE ge_subs_work_relat wr
           SET wr.work_area = sbarealab
         WHERE wr.subscriber_id = nucliecrea;
       END IF;
       IF sbemplab IS NOT NULL THEN
        UPDATE ge_subs_work_relat wr
           SET wr.company = sbemplab
         WHERE wr.subscriber_id = nucliecrea;
       END IF;
    END IF;
   END IF;
   -- Registramos en ge_subs_family_data
   IF sbtieveh <> '-' THEN
     UPDATE ge_subs_family_data fd
        SET fd.has_vehicule = sbtieveh
      WHERE fd.subscriber_id = nucliecrea;
         IF SQL%NOTFOUND THEN
          INSERT INTO ge_subs_family_data(subscriber_id,has_vehicule)
             VALUES(nucliecrea,sbtieveh);
         END IF;
    END IF;
   -- Registramos temas de interes
    IF nutemaint <> -1 THEN
      SELECT COUNT(1) INTO nuconta
        FROM ge_subs_interest ti
       WHERE ti.subscriber_id = nucliecrea
         AND ti.interest_data_id = nutemaint;
          IF nuconta = 0 THEN
           INSERT INTO ge_subs_interest(subscriber_id,subs_interest_id,interest_data_id)
                 VALUES(nucliecrea,seq_ge_subs_interest.nextval,nutemaint);
          END IF;
    END IF;
   -- Registramos en hobbies
    IF nuhobbis <> -1 THEN
      SELECT COUNT(1) INTO nuconta
        FROM ge_subs_hobbies ti
       WHERE ti.subscriber_id = nucliecrea
         AND ti.hobbies_id = nuhobbis;
         IF  nuconta = 0 THEN
           INSERT INTO ge_subs_hobbies(subscriber_id,subs_hobbies_id,hobbies_id)
              VALUES(nucliecrea,seq_ge_subs_hobbies.nextval,nuhobbis);
         END IF;
    END IF;
   -- Registramos servicios adicionales con otras empresas
      SELECT COUNT(1) INTO nuconta
        FROM ge_third_part_serv ti
       WHERE ti.subscriber_id = nucliecrea
         AND TRIM(ti.service_name) = sbnomener;
    IF nuconta = 0  THEN
     INSERT INTO ge_third_part_serv(subscriber_id,third_part_serv_id,service_name,monthly_cost,service_time)
         VALUES(nucliecrea,seq_ge_third_part_serv.nextval,sbnomener,nucostmen,nutiemene);
    ELSE
     IF nucostmen <> -1 THEN
        UPDATE ge_third_part_serv kk
           SET kk.monthly_cost = nucostmen
         WHERE kk.subscriber_id = nucliecrea
           AND kk.service_name = sbnomener;
     END IF;
     IF nutiemene <> -1 THEN
        UPDATE ge_third_part_serv kk
           SET kk.service_time = nutiemene
         WHERE kk.subscriber_id = nucliecrea
           AND kk.service_name = sbnomener;
     END IF;
    END IF;
    -- Datos ldc_proteccion de datos
    IF nuestley <> -1 THEN
     UPDATE ldc_proteccion_datos dl
        SET dl.cod_estado_ley = nuestley
      WHERE dl.id_cliente = nucliecrea;
         IF SQL%NOTFOUND THEN
           INSERT INTO ldc_proteccion_datos(id_cliente,cod_estado_ley,estado,fecha_creacion,usuario_creacion)
               VALUES(nucliecrea,nuestley,'S',SYSDATE,USER);
         END IF;
    END IF;
    -- Datos ge_subs_referen_data
    IF nurefper <> -1 THEN
      SELECT COUNT(1) INTO nuconta
        FROM ge_subs_referen_data rd
       WHERE rd.subscriber_id     = nucliecrea
         AND rd.reference_type_id = nurefper;
       IF nuconta = 0 THEN
         INSERT INTO ge_subs_referen_data(subscriber_id,subs_reference_id,reference_type_id,name_,last_name,phone)
           VALUES(nucliecrea,seq_ge_subs_referen_data.nextval,nurefper,sbnombref,sbapellref,sbtelref);
       ELSE
        IF sbnombref IS NOT NULL THEN
         UPDATE ge_subs_referen_data rd
            SET rd.name_ = sbnombref
          WHERE rd.subscriber_id = nucliecrea
            AND rd.reference_type_id = nurefper;
        END IF;
        IF sbapellref IS NOT NULL THEN
         UPDATE ge_subs_referen_data rd
            SET rd.last_name = sbapellref
          WHERE rd.subscriber_id = nucliecrea
            AND rd.reference_type_id = nurefper;
        END IF;
        IF sbtelref IS NOT NULL THEN
         UPDATE ge_subs_referen_data rd
            SET rd.phone = sbtelref
          WHERE rd.subscriber_id = nucliecrea
            AND rd.reference_type_id = nurefper;
        END IF;
       END IF;
    END IF;
    -- Registramos el tramite
    nupackageid    := NULL;
    numotiveid     := NULL;
    nuerrorcode    := NULL;
    sberrormessage := NULL;
    sbrequestxml1 := '<P_ACTUALIZACION_DATOS_CLIENTE_XML_CAMPANA_100318 ID_TIPOPAQUETE="100318">
                        <CUSTOMER>'||nuclientetram||'</CUSTOMER>
                        <RECEPTION_TYPE_ID>'||numere||'</RECEPTION_TYPE_ID>
                        <CONTACT_ID>'||nuclientetram||'</CONTACT_ID>
                        <COMMENT_>'||sbcomment||' Actualizaci?n del cliente : '||to_char(nucliecrea)||'</COMMENT_>
                        <M_MOTIVO_ACT_DATOS_POR_CAMPANA_100301>
                         <CONTRATO>'||nucontrato||'</CONTRATO>
                        </M_MOTIVO_ACT_DATOS_POR_CAMPANA_100301>
                       </P_ACTUALIZACION_DATOS_CLIENTE_XML_CAMPANA_100318>';
    IF sbrequestxml1 IS NOT NULL THEN
      -- Ejecutamos el servision para procesar el XML y generar la solicitud
      api_registerrequestbyxml(
                                sbrequestxml1,
                                nupackageid,
                                numotiveid,
                                nuerrorcode,
                                sberrormessage
                               );
      IF nupackageid IS NOT NULL THEN
         nuregprok := nuregprok + 1;
         sbmensajeinco := 'Linea archivo : '||to_char(nulineaarch)||' solicitud generada : '||to_char(nupackageid)||' CLIENTE : '||to_char(nucliecrea)||' mensaje : '||to_char(nuerrorcode)||' - '||sberrormessage;
         utl_file.put_line(vfileinco,sbmensajeinco);
         COMMIT;
      ELSE
        nuregpnok := nuregpnok + 1;
        ROLLBACK;
        sbmensajeinco := 'Linea archivo : '||to_char(nulineaarch)||' solicitud generada : '||to_char(nupackageid)||' mensaje : '||to_char(nuerrorcode)||' - '||sberrormessage;
        utl_file.put_line(vfileinco,sbmensajeinco);
      END IF;
    END IF;
  END LOOP;
 -- Fin de archivo
  utl_file.fclose(vfile);
  utl_file.fclose(vfileinco);
 nuerror := 10;
 sbmensa := 'Proceso termino. Total registros encontrados : '||to_char(nuregenco)||'.Total registros procesados Ok : '||to_char(nuregprok)||'.Total registros no-procesados : '||to_char(nuregpnok);
 ldc_proactualizaestaprog(nutsess,sbmensa,'LDCCAMAAD','Ok');
 COMMIT;
 ge_boschedule.changelogProcessStatus(nuLogProceso,'F');
EXCEPTION
 WHEN OTHERS THEN
 ROLLBACK;
 IF nvl(nuErrorCode,0) = 0 THEN
  sbmensa := 'linea error : '||nuerror||' Error : '||nuErrorCode||' mensaje : '||sberrormessage||' '||sqlerrm;
  ldc_proactualizaestaprog(nutsess,sbmensa,'LDCCAMAAD','Termino con error.');
  sbmensajeinco := 'Linea archivo : '||to_char(nulineaarch)||' solicitud generada : '||to_char(nupackageid)||' mensaje : '||sqlerrm;--sbmensajevalida;
  utl_file.put_line(vfileinco,sbmensajeinco);
  utl_file.fclose(vfile);
  utl_file.fclose(vfileinco);
 END IF;
END;
/
grant all on LDCCAMAAD to REPORTES;
grant all on LDCCAMAAD to SYSTEM_OBJ_PRIVS_ROLE;
/