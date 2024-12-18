column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX OSF-1661');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

	nuErrorCode 	NUMBER;
    sbErrorMessage 	VARCHAR2(4000);
    
    cursor cuPoblacion is
        select  sesususc contrato,
				trunc(sesufein) fecha_instalacion,
                sesunuse as producto
        from    open.servsusc
        where sesususc in (66284764, 66281188, 66386009, 66493304, 66500302, 66500380, 66500386, 66500657, 66536430, 66536427, 66502998, 
                           66538767, 66542287, 66509881, 66509879, 66543485, 66542495, 66549686, 66555995, 66554238, 48240113, 66574616, 66574613,
                           66503544, 66572145, 66550027, 66550017, 66564714, 66554623, 66554665, 66554646, 66554632, 66554652, 66510210, 66573969,
                           66575436, 66600434, 66581795, 66581822, 66693156, 66692892, 66690732, 66698680, 66698915, 66694571, 66700115, 66699522, 
                           66702920, 66702835, 66707051, 66703169, 66707032, 66700215, 66702664, 66712202, 66714171, 66702913, 66711493, 66709241,
                           66716992, 66717495, 66707809, 66675298, 66709066, 66717642, 66667827, 66720390, 66720220, 66708049, 66713588, 66494921,
                           66700171, 66718693, 66699918, 66714821, 66716395, 66710563, 66734293, 66734282, 66643804, 66701349, 66729376, 66692907, 
                           66747157, 66750213, 66752486, 66749857, 66752550, 66752568, 66752526, 66752586, 66752566, 66684653, 66573101, 66756982,
                           66780583, 66785522, 66777985, 66764628, 66786257, 66788116, 66777996, 66793134, 66794886, 66792194, 66792184, 66798158,
                           66792210, 66657889, 66809192, 66805162, 66806688, 66853336, 66843262, 66846673, 66854460, 66843647, 66859700, 66863723,
                           66864297, 66873104, 66871899, 66876766, 66880163, 66887495, 66887788, 66896980, 66902107, 66901440, 66910423, 66887709,
                           66922454, 66906419)   
		and sesuserv = 7014;

    CURSOR cuExisteCertificado(nuProducto open.LDC_PLAZOS_CERT.id_producto%type)
    IS
    select  count(1)
    from    open.pr_certificate pc
    where   pc.PRODUCT_ID = nuProducto;
    
    PROCEDURE ldcInsrtaCertificado_JEHM(
                                        inuProduct_id    open.pr_certificate.product_id%type,
                                        idtFechaRevision open.pr_certificate.register_date%type
                                     )
    IS
        nuOrderActivity     number;
        NUDURATIONREVIEW    NUMBER := NVL(GE_BOPARAMETER.FNUGET('REVIEW_DURATION', null), 5) * 12;
        rcCertificate       dapr_certificate.stypr_certificate;
        
    cursor cuGetOrder_acti_id(inuProduct_id  open.pr_certificate.product_id%type)
    IS
        select  oa.order_activity_id
        from    open.or_order oo
                inner join open.or_order_activity oa on oo.order_id = oa.order_id
                inner join open.ge_causal c on oo.causal_id = c.causal_id
        where   oa.product_id = inuProduct_id
        and     oo.task_type_id in ( 10500, 12162 )
        and     c.CLASS_CAUSAL_ID = 1
		and 	not exists (select * from ct_item_novelty where items_id = oa.activity_id);
		
	cursor cuGetOrder_acti_id_2(inuProduct_id  open.pr_certificate.product_id%type)
    IS
        select  oa.order_activity_id
        from    open.or_order oo
                inner join open.or_order_activity oa on oo.order_id = oa.order_id
                inner join open.ge_causal c on oo.causal_id = c.causal_id
        where   oa.product_id = inuProduct_id
        and     oo.task_type_id in (12150, 12152, 12153)
        and     c.CLASS_CAUSAL_ID = 1
		and 	not exists (select * from ct_item_novelty where items_id = oa.activity_id);
    
    BEGIN
        nuOrderActivity := null;
		
		open cuGetOrder_acti_id(inuProduct_id);
        fetch cuGetOrder_acti_id into nuOrderActivity;
        close cuGetOrder_acti_id;
		
		IF (nuOrderActivity is null) THEN 
			open cuGetOrder_acti_id_2(inuProduct_id);
			fetch cuGetOrder_acti_id_2 into nuOrderActivity;
			close cuGetOrder_acti_id_2;
		END IF;
        
        IF (nuOrderActivity is not null) THEN
            --Insertar un registro en la entidad PR_CERTIFICATE
            rcCertificate.Certificate_Id := seq_pr_certificate_156806.nextval;
            rcCertificate.Product_Id     := inuProduct_id;
            rcCertificate.PACKAGE_ID     := -1;
        
            rcCertificate.Order_Act_Certif_Id := nuOrderActivity;
            rcCertificate.Register_Date       := idtFechaRevision;
            rcCertificate.Review_Date         := idtFechaRevision;
            rcCertificate.Estimated_End_Date  := ADD_MONTHS(idtFechaRevision, NUDURATIONREVIEW);
            rcCertificate.Order_Act_Review_Id := nuOrderActivity;
            rcCertificate.END_DATE            := NULL;

            --Se genera el nuevo certificado
            dapr_certificate.insrecord(ircpr_certificate => rcCertificate);
            
            DBMS_OUTPUT.PUT_LINE('OK pr_certificate - se crea el certificado para el producto '||inuProduct_id);
        END IF;
		
    EXCEPTION
        When pkg_error.controlled_error Then
			Pkg_Error.GetError(nuErrorCode, sbErrorMessage);
            DBMS_OUTPUT.PUT_LINE('ERROR ldcInsrtaCertificado_JEHM: El producto '||inuProduct_id||' no cuenta con una orden 10500, 12162, 12150, 12152, 12153 legalizada con exito');
			DBMS_OUTPUT.PUT_LINE('ERROR ldcInsrtaCertificado_JEHM: nuErrorCode: '||nuErrorCode||' sbErrorMessage: ' || sbErrorMessage);
            raise;
        WHEN OTHERS THEN
            DBMS_OUTPUT.PUT_LINE('ERROR ldcInsrtaCertificado_JEHM: AL INSERTAR CERTIFICADO ' || sqlerrm);
    end ldcInsrtaCertificado_JEHM;
    
BEGIN
    dbms_output.put_line('---- Inicia OSF-1661 ----');
	
    FOR reg_poblacion IN cuPoblacion
    LOOP
		
		-- 1. Crea el certificado
        BEGIN
			ldcInsrtaCertificado_JEHM(inuProduct_id    => reg_poblacion.producto,
                                      idtFechaRevision => reg_poblacion.fecha_instalacion );
        EXCEPTION
			WHEN OTHERS THEN
				rollback;
				DBMS_OUTPUT.PUT_LINE('ERROR [PR_CERTIFICATE] - '
                                    ||' Producto ['||reg_poblacion.producto||']'
                                    ||' Fecha Instalación ['||reg_poblacion.fecha_instalacion||']'
                                    ||' Error --> '||sqlerrm);
        END; 
        
		COMMIT;
              
    END LOOP;

  dbms_output.put_line('---- Fin OSF-1661 ----');
  
EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('---- Error OSF-1661 ----');
    DBMS_OUTPUT.PUT_LINE('Error no controlado --> '||sqlerrm);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/