create or replace PROCEDURE ADM_PERSON.SENDMAILCONCEPT(inuProducto_id  pr_product.product_id%type,
                                            Isboperacion    varchar2,
                                            InuDir ab_address.address_id%type default null,
                                            InuPlanc pr_product.commercial_plan_id%type default null,
                                            IdtCreate pr_product.CREATION_DATE%type default null) AS

/********************************************************************************************************
Propiedad Intelectual de Efigas.

Funcion     : SENDMAILCONCEPT
Descripcion : Procedimiento que .

Historia de Modificaciones
  Fecha               Autor                Modificacion
=========           =========          ====================
17/08/2021      	Horbath        		CA 810: Creacion.
26/06/2024          jpinedc             OSF-2606: * Se usa pkg_Correo
                                        * Ajustes por estándares
*********************************************************************************************************/
    csbMetodo        CONSTANT VARCHAR2(70) := 'ADM_PERSON.SENDMAILCONCEPT';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;

    sbmensa             VARCHAR2(10000);
    nuError             NUMBER;
	message             VARCHAR2(3000);
	sbConsept           VARCHAR2(3000);
	nuValConce			number(10);
	blenviacorreo       boolean:=false;
    sbObs               VARCHAR2(3000):= 'No envia correo';
	sbAsunto            Varchar2(100) := pkg_BCLD_Parameter.fsbObtieneValorCadena('PARASUNTOEMAELFAC');
	sbPARMAILAREAFACTUR   ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('PARMAILAREAFACTUR');

    cursor cuDatos (dir number) is
		SELECT a.ADDRESS,pr.CATEGORY_ category_id, pr.SUBCATEGORY_ subcategory_id,
                dage_geogra_location.fsbgetdescription(daab_address.fnugetgeograp_location_id (address_id,null))locali,
                dage_geogra_location.fsbgetdescription(dage_geogra_location.fnugetgeo_loca_father_id(daab_address.fnugetgeograp_location_id (
                address_id,null),null),null) dep
        FROM ab_address A, ab_segments s,ab_info_premise i, ab_premise pr
        WHERE s.segments_id = A.segment_id
          AND estate_number = i.premise_id
          AND pr.premise_id = i.premise_id
            and a.address_id=dir;

	CURSOR cuEmail is
        SELECT regexp_substr(sbPARMAILAREAFACTUR,'[^,]+', 1,LEVEL) email
        FROM dual
        CONNECT BY regexp_substr(sbPARMAILAREAFACTUR, '[^,]+', 1, LEVEL) IS NOT NULL		 
		;

	CURSOR cuConcAgen (cat number,subCat number) is
		SELECT CONCCODI concepto,CONCDESC descrip
		FROM LD_TABCONCPC, CONCEPTO ce
		where category_id=cat
		and subcategory_id=subCat
		and concept_id= CONCCODI;

	CURSOR cuConcept (plan number, concept number) is
		select count(1)
		from CONCPLSU
		where COPSCONC= concept
		and COPSPLSU=plan;

	RtcuDatos cuDatos%ROWTYPE;
    PRAGMA autonomous_transaction;

BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  

    IF upper(Isboperacion) = 'I' THEN

        INSERT INTO LD_TABPRODNOTIF
        (TABCONCPC_ID, PRODUCT_ID, STATUS)
        VALUES (SEQLD_TABPRODNOTIF.NEXTVAL, inuProducto_id, Isboperacion);
        commit;


    ELSIF upper(Isboperacion) = 'U' THEN

        OPEN cuDatos(InuDir);
        FETCH cuDatos INTO RtcuDatos;
        CLOSE cuDatos;


        FOR reg IN cuConcAgen (RtcuDatos.category_id,RtcuDatos.subcategory_id) LOOP

            OPEN cuConcept (InuPlanc,reg.concepto );
            FETCH cuConcept INTO nuValConce;
            CLOSE cuConcept;

            IF nuValConce=0 THEN
                blenviacorreo:=true;

                sbConsept:=sbConsept||reg.concepto||'- '||reg.descrip||',';
            END IF;

        END LOOP;



        IF blenviacorreo THEN

            message:='<html>
                            <head>
                                <title>Untitled Document</title>
                                <meta http-equiv="Content-Type" content="text/html; charset=iso-8859-1">
                            </head>

                            <body>

                                <h3>C¿¿digo del Producto: <COD_PRODUCTO></h3>
                                <h3>Plan Comercial asociado: <PLAN_CO></h3>
                                <h3>Fecha de Creaci¿¿n del Producto: <FECH_REG></h3>
                                <h3>Localidad: <LOCAL></h3>
                                <h3>Departamento: <DEP></h3>
                                <h3>Conceptos Faltantes: <CONCEPTOS></h3>

                            </body>

                        </html>';

            message := replace(message, '<COD_PRODUCTO>',inuProducto_id);
            message := replace(message, '<PLAN_CO>',InuPlanc);
            message := replace(message, '<FECH_REG>', TO_char(IdtCreate,'DD/MM/YYYY HH24:MI:SS'));
            message := replace(message, '<LOCAL>',RtcuDatos.locali);
            message := replace(message, '<DEP>', RtcuDatos.dep);
            message := replace(message, '<CONCEPTOS>',sbConsept);

            for e in cuEmail loop

                pkg_Correo.prcEnviaCorreo
                (
                    isbDestinatarios    => e.email,
                    isbAsunto           => sbAsunto,
                    isbMensaje          => message
                );            
            
            end loop;

            sbObs:= 'Se envio correo';

        END IF;

        begin
            UPDATE LD_TABPRODNOTIF
            SET RESPONSE = sbObs, STATUS=Isboperacion
            where PRODUCT_ID= inuProducto_id;
            commit;
        end;


    END IF;

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN); 
EXCEPTION
    WHEN OTHERS THEN
        pkg_Error.seterror;
        pkg_Error.getError( nuError, sbmensa );
        rollback;
        begin
            UPDATE LD_TABPRODNOTIF
            SET RESPONSE ='No se envio correo, error:'||sbmensa
            where PRODUCT_ID=inuProducto_id;
            commit;
        end;
        RAISE pkg_Error.controlled_error;
END SENDMAILCONCEPT;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('SENDMAILCONCEPT', 'ADM_PERSON');
END;
/

