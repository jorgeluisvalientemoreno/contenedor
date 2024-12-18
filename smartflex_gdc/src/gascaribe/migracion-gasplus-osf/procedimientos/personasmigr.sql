CREATE OR REPLACE PROCEDURE      PERSONASMIGR(NUMINICIO NUMBER,
                                         NUMFINAL  NUMBER,
                                         pbd       NUMBER) AS
  n number;
  vprograma   VARCHAR2(100);
  nuLogError  NUMBER;
  NUTOTALREGS NUMBER := 0;
  NUERRORES   NUMBER := 0;
  nusubs_id number := 0;

  CURSOR cupersonas IS
    SELECT * FROM migra.ldc_temp_personas_sge WHERE basedato = pbd ;

  nuvar NUMBER;
  nucli NUMBER;

  cocli          NUMBER;
  nuerrorcode    NUMBER;
  sberrormessage VARCHAR2(800);
  
FUNCTION existe_cliente(p_identification VARCHAR2,p_sbNombre varchar2,p_sbApellido1 varchar2,p_sbApellido2 varchar2)
   return number is
    CURSOR cucliente IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre
    AND subs_last_name = p_sbApellido1
    AND subs_second_last_name = p_sbApellido2;
    CURSOR cucliente_1 IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre
    AND subs_last_name = p_sbApellido1;
    CURSOR cucliente_2 IS
    SELECT subscriber_id
    FROM ge_subscriber
    WHERE identification = p_identification
    AND subscriber_name = p_sbNombre;
    nusubscriber_id number;
   BEGIN
    if cucliente%isopen then
        close cucliente;
    END if;
    if cucliente_1%isopen then
        close cucliente_1;
    END if;
    nusubscriber_id := null;
    if ( p_sbNombre IS not null AND p_sbApellido1 IS not null AND p_sbApellido2 IS not null ) then
        open cucliente;
        fetch cucliente INTO nusubscriber_id;
        close cucliente;
    elsif ( p_sbNombre IS not null AND p_sbApellido1 IS not null AND p_sbApellido2 IS null ) then
        open cucliente_1;
        fetch cucliente_1 INTO nusubscriber_id;
        close cucliente_1;
    elsif ( p_sbNombre IS not null AND p_sbApellido1 IS null AND p_sbApellido2 IS null ) then
        open cucliente_2;
        fetch cucliente_2 INTO nusubscriber_id;
        close cucliente_2;
    END if;
    if   nusubscriber_id IS null then
        nusubscriber_id := 0;
    END if;
    return nusubscriber_id;
   END;
   ----------------------------------------------

BEGIN

  --ldc_actualiza_sa_tab

  PKLOG_MIGRACION.prInsLogMigra(3650,
                                3650,
                                1,
                                vprograma,
                                0,
                                0,
                                'Inicia Proceso',
                                'INICIO',
                                nuLogError);

  UPDATE migr_rango_procesos
  SET    raprfein = SYSDATE,
         RAPRTERM = 'P'
  WHERE  raprcodi = 3650
  AND    raprbase = pbd
  AND    raprrain = numinicio
  AND    raprrafi = NUMFINAL;
  COMMIT;

  FOR r IN cupersonas LOOP
    cocli := NULL;
    BEGIN
      -- SMUNOZ 25-09-2014 - Inicio 
      nusubs_id := existe_cliente(r.identificacion, r.nombre, r.apellido, NULL);
      /*SELECT count(1) INTO nuvar FROM
            ge_subscriber
            where  subscriber_name=r.nombre
            AND subs_last_name=r.apellido
            AND identification=r.identificacion;
      
      
            if nuvar =0 then
      */
    
      -- SMUNOZ 25-09-2014 - Fin
    
      IF nusubs_id = 0 THEN
      
        SELECT seq_ge_subscriber.nextval INTO cocli FROM dual;
      
        GSI_MIG_RegistraCliente(cocli, --tbl_datos (nuindice).susccodi,
                                r.ident_type_id, -- Tipo de Id ge_identifica_type
                                r.identificacion, -- Identificaci¿n
                                NULL, -- Parent_id
                                1, -- Subscriber Type   ge_subscriber_type
                                r.direccion, -- Direcci¿n cadena
                                r.telefono, -- Telefono
                                r.nombre, -- Nombre del cliente
                                r.apellido, -- Apellido 1
                                NULL, -- Apellido 2
                                NULL, --tbl_datos (nuindice).PERSFENA,               -- Fecha de Nacimiento
                                SYSDATE, -- FEcha de la ultima actualizacion
                                r.mail, --tbl_datos (nuindice).PERSMAIL,          -- Email
                                NULL, -- 'www.prueba/api.net',                       -- URL
                                NULL, --'3319999', -- ID del contacto 3090
                                NULL, -- Actividad economica ge_economic_activity
                                1, -- ID del segmento de mercado cc_marketing_segment
                                2, -- Satus ID   ge_subs_status
                                'Y', -- Esta activo, SI=Y NO=N
                                1, -- ID de la dir parseada SELECT address_id, address FROM ab_address
                                1, -- Tipo de contribuyente fa_tipocont
                                'N', -- DATA_SEND
                                NULL, -- Fecha de vinculaci¿n
                                NULL,
                                NULL,
                                'N',
                                nuErrorCode,
                                sbErrorMessage);
      
        IF dage_subscriber.fblexist(cocli) THEN
       
          if r.fecha_nacimiento is not null then
             
             UPDATE ge_subs_general_data
             SET    date_birth       = r.fecha_nacimiento
             WHERE  subscriber_id = cocli
             and date_birth is null;
          
          end if;
          
          if r.gender is not null then
             
             UPDATE ge_subs_general_data
             SET    gender       = r.gender
             WHERE  subscriber_id = cocli
             and gender is null;
          
          end if;
          
            if r.civil_state_id is not null then
             
             UPDATE ge_subs_general_data
             SET    civil_state_id       = r.civil_state_id
             WHERE  subscriber_id = cocli
             and civil_state_id is null;
          
          end if;
         
           if r.school_degree_id is not null then
             
             UPDATE ge_subs_general_data
             SET    school_degree_id       = r.school_degree_id
             WHERE  subscriber_id = cocli
             and school_degree_id is null ;
          
          end if;
           
             if r.wage_scale_id  is not null then
             
             UPDATE ge_subs_general_data
             SET    wage_scale_id        = r.wage_scale_id 
             WHERE  subscriber_id = cocli
             and wage_scale_id is null;
          
          end if;
          
           if r.DEBIT_SCALE_ID  is not null then
             
             UPDATE ge_subs_general_data
             SET    debit_scale_id        = r.debit_scale_id 
             WHERE  subscriber_id = cocli
             and debit_scale_id is null;
          
          end if;
          
          
          begin
            select subscriber_id into n from  GE_SUBS_FAMILY_DATA where subscriber_id=cocli;
          exception
          when others then
          
          INSERT INTO GE_SUBS_FAMILY_DATA
            (HAS_VEHICULE,
             COUPLE_ACTIVITY_ID,
             COUPLE_IDENTIFY,
             COUPLE_NAME,
             COUPLE_WAGE_SCALE,
             NUMBER_DEPEND_PEOPLE,
             SUBSCRIBER_ID,
             VEHICULE_BRAND,
             VEHICULE_MODEL)
          VALUES
            (NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             r.NUMBER_DEPEND_PEOPLE,
             cocli,
             NULL,
             NULL);
           end;
           
          begin
            select subscriber_id into n from GE_SUBS_WORK_RELAT where subscriber_id=cocli;
          exception
          when others then
          INSERT INTO GE_SUBS_WORK_RELAT
            (SUBSCRIBER_ID,
             COMPANY,
             HIRE_DATE,
             PHONE_OFFICE,
             ACTIVITY_ID,
             TITLE,
             WORKED_TIME,
             EXPERIENCE,
             PREVIOUS_ACTIVITY_ID,
             PREVIOUS_COMPANY,
             PREVIOUS_WORK_TIME,
             OCCUPATION,
             PREVIOUS_OCCUPATION,
             ADDRESS_ID,
             PHONE_EXTENSION,
             WORK_AREA)
          VALUES
            (cocli,
             r.company,
             NULL,
             r.teleofic,
             NULL,
             NULL,
             r.worked_time,
             NULL,
             NULL,
             NULL,
             NULL,
             r.occupation,
             NULL,
             NULL,
             NULL,
             NULL);
           end;
           
          if ltrim(r.telefono) is not null then
          n:=null;          
          select count(subscriber_id) into n from GE_SUBS_PHONE where phone=r.telefono and subscriber_id=cocli;
          if  n =0 then
            INSERT INTO GE_SUBS_PHONE
                (SUBSCRIBER_ID,
                SUBS_PHONE_ID,
                PHONE,
                COMPANY_PHONE,
                DESCRIPTION,
                PHONE_TYPE_ID,
                COUNTRY_ID,
                 AREA_ID,
                 TECHNICAL_SMS,
                 ADMINISTRATIVE_SMS,
                 COMERCIAL_SMS,
                 FULL_PHONE_NUMBER,
                 AREA_LOCATION_ID,
                 COUNTRY_LOCATION_ID,
                 AREA_CODE)
              VALUES
                (cocli,
                 seq_ge_subs_phone.nextval,
                 r.telefono,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL,
                 NULL);
           end if;      
          end if;
        
          IF r.tipo_referencia IS NOT NULL THEN
          
            INSERT INTO GE_SUBS_REFEREN_DATA
              (ACCOUNT,
               ACCOUNT_TYPE,
               ACTIVITY_ID,
               ADDRESS_ID,
               BANK_ID,
               COMMENT_,
               DEBIT_NOW,
               HAS_BEEN_DEBIT,
               IDENTIFICATION,
               IDENT_TYPE_ID,
               LAST_NAME,
               MONTH_DUE,
               NAME_,
               NO_DEBIT,
               PHONE,
               REFERENCE_TYPE_ID,
               RELATIONSHIP,
               SUBSCRIBER_ID,
               SUBS_REFERENCE_ID,
               TIME_KNOW)
            VALUES
              (NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               NULL,
               r.APELLIDO_REFERENCIA_FAMILIAR,
               NULL,
               r.NAME_REFERENCIA_FAMILIAR,
               NULL,
               r.PHONE_REFERENCIA_FAMILIAR,
               r.tipo_referencia,
               NULL,
               cocli,
               seq_GE_SUBS_REFEREN_DATA.nextval,
               NULL);
          END IF;
        
          INSERT INTO LDC_PROTECCION_DATOS
            (ID_CLIENTE,
             COD_ESTADO_LEY,
             ESTADO,
             FECHA_CREACION,
             USUARIO_CREACION,
             PACKAGE_ID)
          VALUES
            (cocli,
             r.AUTO_INFO,
             'S',
             r.FECHA_AUIN,
             'MIGRACION',
             4);
          COMMIT;
        
          IF ((r.PRODUCTO_RELACIONADO IS NOT NULL) AND (r.codeudor IS NULL)) THEN
            INSERT INTO pr_subs_type_prod
            VALUES
              (SEQ_PR_SUBS_TYPE_PROD.nextval,
               r.producto_relacionado,
               cocli,
               2,
               SYSDATE);
          END IF;
        
          IF ltrim(r.telefax) IS NOT NULL THEN
          n:=null;          
          select count(subscriber_id) into n from GE_SUBS_PHONE where phone=r.telefax and subscriber_id=cocli;
              if  n =0 then
          
                  INSERT INTO ge_subs_phone
                    VALUES
                      (cocli,
                       SEQ_ge_SUBS_phone.nextval,
                       r.telefax,
                       NULL,
                       NULL,
                       4,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL);
              end if;
           END IF;
                
           IF ltrim(r.teleofic) IS NOT NULL THEN
             n:=null;          
              select count(subscriber_id) into n from GE_SUBS_PHONE where phone=r.teleofic and subscriber_id=cocli;
              if  n =0 then
          
                   INSERT INTO ge_subs_phone
                    VALUES
                      (cocli,
                       SEQ_ge_SUBS_phone.nextval,
                       r.teleofic,
                       NULL,
                       NULL,
                       4,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL);
              end if;     
          END IF;
        
          IF ltrim(r.telecelu) IS NOT NULL THEN
              n:=null;          
              select count(subscriber_id) into n from GE_SUBS_PHONE where phone=r.telecelu and subscriber_id=cocli;
              if  n =0 then
          
                    INSERT INTO ge_subs_phone
                    VALUES
                      (cocli,
                       SEQ_ge_SUBS_phone.nextval,
                       r.telecelu,
                       NULL,
                       NULL,
                       1,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL,
                       NULL);
               end if;
          END IF;
        
        END IF;
      
        COMMIT;
      
      ELSE
        -- SMUNOZ. 25-09-2014 - Inicio
        cocli := nusubs_id;
        
        /*
        SELECT subscriber_id
        INTO   cocli
        FROM   ge_subscriber
        WHERE  subscriber_name = r.nombre
        AND    subs_last_name = r.apellido
        AND    identification = r.identificacion;
        */
        -- SMUNOZ. 25-09-2014 - Fin
        
      
        UPDATE ge_subs_general_data
        SET    date_birth       = r.fecha_nacimiento,
               gender           = r.gender,
               civil_state_id   = r.civil_state_id,
               school_degree_id = r.school_degree_id,
               wage_scale_id    = r.wage_scale_id,
               DEBIT_SCALE_ID   = r.debit_scale_id
        WHERE  subscriber_id = cocli;
      
        
        begin
        select subscriber_id into n from GE_SUBS_FAMILY_DATA where subscriber_id=cocli;
        exception
            when others then
            INSERT INTO GE_SUBS_FAMILY_DATA
          (HAS_VEHICULE,
           COUPLE_ACTIVITY_ID,
           COUPLE_IDENTIFY,
           COUPLE_NAME,
           COUPLE_WAGE_SCALE,
           NUMBER_DEPEND_PEOPLE,
           SUBSCRIBER_ID,
           VEHICULE_BRAND,
           VEHICULE_MODEL)
        VALUES
          (NULL,
           NULL,
           NULL,
           NULL,
           NULL,
           r.NUMBER_DEPEND_PEOPLE,
           cocli,
           NULL,
           NULL);
        end;
      
      
        begin
        select subscriber_id into n from GE_SUBS_WORK_RELAT where subscriber_id=cocli;
        exception
          when others then
         INSERT INTO GE_SUBS_WORK_RELAT
          (SUBSCRIBER_ID,
           COMPANY,
           HIRE_DATE,
           PHONE_OFFICE,
           ACTIVITY_ID,
           TITLE,
           WORKED_TIME,
           EXPERIENCE,
           PREVIOUS_ACTIVITY_ID,
           PREVIOUS_COMPANY,
           PREVIOUS_WORK_TIME,
           OCCUPATION,
           PREVIOUS_OCCUPATION,
           ADDRESS_ID,
           PHONE_EXTENSION,
           WORK_AREA)
        VALUES
          (cocli,
           r.company,
           NULL,
           r.teleofic,
           NULL,
           NULL,
           r.worked_time,
           NULL,
           NULL,
           NULL,
           NULL,
           r.occupation,
           NULL,
           NULL,
           NULL,
           NULL);
        end;      
      
        if r.telefono is  not null then
            n:=null;          
              select count(subscriber_id) into n from GE_SUBS_PHONE where phone=r.telefono and subscriber_id=cocli;
              
              if  n =0 then
    
                INSERT INTO GE_SUBS_PHONE
                  (SUBSCRIBER_ID,
                   SUBS_PHONE_ID,
                   PHONE,
                   COMPANY_PHONE,
                   DESCRIPTION,
                   PHONE_TYPE_ID,
                   COUNTRY_ID,
                   AREA_ID,
                   TECHNICAL_SMS,
                   ADMINISTRATIVE_SMS,
                   COMERCIAL_SMS,
                   FULL_PHONE_NUMBER,
                   AREA_LOCATION_ID,
                   COUNTRY_LOCATION_ID,
                   AREA_CODE)
                VALUES
                  (cocli,
                   seq_ge_subs_phone.nextval,
                   r.telefono,
                   NULL,
                   NULL,
                   3,
                   NULL,
                   NULL,
                   NULL,
                   NULL,
                   NULL,
                   NULL,
                   NULL,
                   NULL,
                   NULL);
            end if;
         end if;
        
        IF r.tipo_referencia IS NOT NULL THEN
       
         begin
           select subscriber_id into n from GE_SUBS_REFEREN_DATA where subscriber_id=cocli;
         exception
         when others then
          INSERT INTO GE_SUBS_REFEREN_DATA
            (ACCOUNT,
             ACCOUNT_TYPE,
             ACTIVITY_ID,
             ADDRESS_ID,
             BANK_ID,
             COMMENT_,
             DEBIT_NOW,
             HAS_BEEN_DEBIT,
             IDENTIFICATION,
             IDENT_TYPE_ID,
             LAST_NAME,
             MONTH_DUE,
             NAME_,
             NO_DEBIT,
             PHONE,
             REFERENCE_TYPE_ID,
             RELATIONSHIP,
             SUBSCRIBER_ID,
             SUBS_REFERENCE_ID,
             TIME_KNOW)
          VALUES
            (NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             NULL,
             r.APELLIDO_REFERENCIA_FAMILIAR,
             NULL,
             r.NAME_REFERENCIA_FAMILIAR,
             NULL,
             r.PHONE_REFERENCIA_FAMILIAR,
             r.tipo_referencia,
             NULL,
             cocli,
             seq_GE_SUBS_REFEREN_DATA.nextval,
             NULL);
          end;
        END IF;
      
      
        INSERT INTO LDC_PROTECCION_DATOS
          (ID_CLIENTE,
           COD_ESTADO_LEY,
           ESTADO,
           FECHA_CREACION,
           USUARIO_CREACION,
           PACKAGE_ID)
        VALUES
          (cocli,
           r.AUTO_INFO,
           'S',
           r.FECHA_AUIN,
           'MIGRACION',
           4);
        COMMIT;
       
        IF ((r.PRODUCTO_RELACIONADO IS NOT NULL) AND (r.codeudor IS NULL)) THEN
          INSERT INTO pr_subs_type_prod
          VALUES
            (SEQ_PR_SUBS_TYPE_PROD.nextval,
             r.producto_relacionado,
             cocli,
             2,
             SYSDATE);
        END IF;
      
        IF r.telefax IS NOT NULL THEN
            n:=null;          
           select count(subscriber_id) into n from GE_SUBS_PHONE where phone=r.telefax and subscriber_id=cocli;
              if  n =0 then
    
                  INSERT INTO ge_subs_phone
                  VALUES
                    (cocli,
                     SEQ_ge_SUBS_phone.nextval,
                     r.telefax,
                     NULL,
                     NULL,
                     4,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL);
              end if;
        END IF;
      
        IF r.teleofic IS NOT NULL THEN
            n:=null;          
              select count(subscriber_id) into n from GE_SUBS_PHONE where phone=r.teleofic and subscriber_id=cocli;
              if  n =0 then

                  INSERT INTO ge_subs_phone
                  VALUES
                    (cocli,
                     SEQ_ge_SUBS_phone.nextval,
                     r.teleofic,
                     NULL,
                     NULL,
                     4,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL);
             end if;
        END IF;
      
        IF r.telecelu IS NOT NULL THEN
            n:=null;          
              select count(subscriber_id) into n from GE_SUBS_PHONE where phone=r.telecelu and subscriber_id=cocli;
              if  n =0 then
                  INSERT INTO ge_subs_phone
                  VALUES
                    (cocli,
                     SEQ_ge_SUBS_phone.nextval,
                     r.telecelu,
                     NULL,
                     NULL,
                     1,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL,
                     NULL);
           end if;
        END IF;
      
        COMMIT;
      END IF;
    
    EXCEPTION
      WHEN OTHERS THEN
        BEGIN
      
         NUERRORES := NUERRORES + 1;
          PKLOG_MIGRACION.prInsLogMigra(3650,
                                        3650,
                                        2,
                                        vprograma || 0,
                                        0,
                                        0,
                                        'Cliente : ' || cocli || ' - Error: ' || SQLERRM,
                                        to_char(SQLCODE),
                                        nuLogError);
        END;
    END;
  END LOOP;

  PKLOG_MIGRACION.PRINSLOGMIGRA(3650,
                                3650,
                                3,
                                VPROGRAMA,
                                NUTOTALREGS,
                                NUERRORES,
                                'TERMINO PROCESO #regs: ' || 0,
                                'FIN',
                                NULOGERROR);

  UPDATE migr_rango_procesos
  SET    raprfefi = SYSDATE,
         raprterm = 'T'
  WHERE  raprcodi = 3650
  AND    raprbase = pbd
  AND    raprrain = numinicio
  AND    raprrafi = NUMFINAL;
  COMMIT;
END; 
/
