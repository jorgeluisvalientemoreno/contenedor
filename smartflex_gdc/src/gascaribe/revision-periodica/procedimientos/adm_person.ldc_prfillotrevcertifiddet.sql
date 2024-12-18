CREATE OR REPLACE PROCEDURE ADM_PERSON.LDC_PRFILLOTREVCERTIFIDDET(r number,rini number,rfin number) IS
/*****************************************************************
   Propiedad intelectual de HORBATH (c).

   Unidad         : ldc_prFillOTREVcertifiDdet
   Descripcion    : Procedimiento para llenar la tabla LDC_OTREV_CERTIF con marcados 103
   Autor          :
   Fecha          : 04/04/2018

   Parametros              Descripcion
   ============         ===================

   Fecha             Autor             Modificacion
   =========       =========           ====================
   04/04/2018       jbrito             CASO 200-1871 Creacion
    09/12/2020       ljlb                CA 337 se coloca validacion de producto excluido
   ******************************************************************/


    nuMESESRPITEMESPECIAL     number := dald_parameter.fnuGetNumeric_Value('MESES_PROXIMA_RP_ITEM_ESPECIAL',
                                                                           null);
    v_id_items_estado_inv_USO number := DALD_PARAMETER.fnuGetNumeric_Value('ESTADO_ITEM_SERIADO_USO',
                                                                           NULL);
    nuitem                    number := dald_parameter.fnuGetNumeric_Value('COD_ITEM_ESPECIALES',
                                                                           NULL);
    nuCant                    number := 0;

    ---rnp2180

---josecf: por motivo de pueba se quiete el /*+ PARALLEL */

    cursor cuOTREV is
select "PRODUCT_ID",
       "CLIENTE",
       "IDENTIFICACION",
       "NOMBRE",
       "APELLIDO",
       "DIRECCION",
       "CODIGO_DEPARTAMENTO",
       "DEPARTAMENTO",
       "CODIGO_LOCALIDAD",
       "LOCALIDAD",
       "CODIGO_BARRIO",
       "BARRIO",
       "CICLO",
       "USO",
       "ESTRATO",
       "MESES"
  from (select PRODUCTO "PRODUCT_ID",
               SUBSCRIBER_ID "CLIENTE",
               IDENTIFICATION "IDENTIFICACION",
               SUBSCRIBER_NAME "NOMBRE",
               nvl(SUBS_LAST_NAME, '-') "APELLIDO",
               ADDRESS "DIRECCION",
               GEO_LOCA_FATHER_ID "CODIGO_DEPARTAMENTO",
               Departamento "DEPARTAMENTO",
               GEOGRAP_LOCATION_ID "CODIGO_LOCALIDAD",
               Localidad "LOCALIDAD",
               nvl(OPERATING_SECTOR_ID, -1) "CODIGO_BARRIO",
               DESC_BARR "BARRIO",
               Ciclo "CICLO",
               Cat "USO",
               Subc "ESTRATO",
               Meses "MESES"
          FROM (select SESUNUSE PRODUCTO,
                       A1.SUBSCRIBER_ID,
                       A1.IDENTIFICATION,
                       A1.SUBSCRIBER_NAME,
                       nvl(A1.SUBS_LAST_NAME, '-') SUBS_LAST_NAME,
                       b.ADDRESS,
                       C1.GEO_LOCA_FATHER_ID,
                       LDC_BOUTILITIES.fsbGetValorCampoTabla('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID', 'DESCRIPTION', C1.GEO_LOCA_FATHER_ID) Departamento,
                       b.GEOGRAP_LOCATION_ID,
                       C1.DESCRIPTION Localidad,
                       SE.OPERATING_SECTOR_ID,
                       LDC_BOUTILITIES.fsbGetValorCampoTabla('GE_GEOGRA_LOCATION', 'GEOGRAP_LOCATION_ID', 'DESCRIPTION', SE.OPERATING_SECTOR_ID) DESC_BARR,
                       e.sesucicl Ciclo,
                       e.SESUCATE Cat,
                       e.SESUSUCA Subc,
                       ldc_getEdadRP(e.SESUNUSE) Meses
                  from pr_product f,
                       servsusc e,
                       suscripc d,
                       ge_subscriber A1,
                       ab_address b,
                       GE_GEOGRA_LOCATION C1,
                       AB_SEGMENTS SE
                 where 7014 = e.SESUSERV AND E.SESUNUSE BETWEEN RINI AND RFIN
                   AND 1 <> -e.sesunuse
                   AND ldc_getEdadRP(e.SESUNUSE) > DALD_PARAMETER.fnuGetNUMERIC_VALUE('VALIDAR_MESES_OTREV', NULL)
                   AND EXISTS (SELECT 'X'
                                 FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('COD_CATEG_VALIDOS_OTREV', NULL), ','))
                                WHERE e.sesucate = TO_NUMBER(COLUMN_VALUE))
                   AND d.SUSCCODI = f.subscription_id
                   AND e.sesunuse = f.product_id
                   AND 1 = f.product_status_id
                   AND e.sesuesfn not in ('C')
                   AND e.sesuesco in (SELECT TO_NUMBER(COLUMN_VALUE) FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('ESTADO_CORTE_OTREV', NULL), ',')))
                   AND d.SUSCCLIE = A1.SUBSCRIBER_ID
                   AND 'Y' = A1.ACTIVE
                   AND f.ADDRESS_ID = b.ADDRESS_ID
                   AND SE.SEGMENTS_ID = B.SEGMENT_ID
                   AND b.GEOGRAP_LOCATION_ID = C1.GEOGRAP_LOCATION_ID
                   AND f.product_id <> -1
                   AND ldc_getEdadRP(f.product_id) > DALD_PARAMETER.fnuGetNUMERIC_VALUE('VALIDAR_MESES_OTREV', NULL)
                   AND NOT exists (select 1
                                     from mo_packages A2,
                                          ps_motive_status C2,
                                          mo_motive x
                                    WHERE EXISTS (SELECT 'X' FROM TABLE (LDC_BOUTILITIES.SPLITSTRINGS(DALD_PARAMETER.fsbGetValue_Chain('VAL_TIPO_PAQUETE_OTREV', NULL), ',')) WHERE A2.PACKAGE_TYPE_ID = TO_NUMBER(COLUMN_VALUE))
                                      AND A2.MOTIVE_STATUS_ID = C2.MOTIVE_STATUS_ID
                                      AND 2 = C2.MOTI_STATUS_TYPE_ID
                                      AND C2.MOTIVE_STATUS_ID not in (14, 32, 51)
                                      AND A2.PACKAGE_ID = x.PACKAGE_ID
                                      AND f.product_id = x.PRODUCT_ID
                                      AND A2.MOTIVE_STATUS_ID not in (14, 32, 51))
                   AND NOT exists (select 1
                                     from ldc_trab_cert,
                                          or_order_activity,
                                          or_order,
                                          mo_packages
                                    where f.product_id = or_order_activity.PRODUCT_ID
                                      AND or_order_activity.task_type_id = id_trabcert
                                      AND or_order_activity.order_id = or_order.order_id
                                      AND order_status_id in (0, 5, 7)
                                      AND or_order_activity.package_id = mo_packages.package_id
                                      AND 100101 = mo_packages.package_type_id)
                   AND exists (select 1 from ldc_marca_producto where e.sesunuse = ldc_marca_producto.id_producto
                                                                      and ldc_marca_producto.SUSPENSION_TYPE_ID = 103)
                   AND e.sesunuse <> -f.product_status_id
				   --inicio ca 337
					and LDC_PKGESTPREXCLURP.FUNVALEXCLURP(f.PRODUCT_ID) = 0
					--fin ca 337

				   )) l;


   --Mmejia 23/06/2015
   --Aranda.7434
   --4.Se debe adicionar una validacion para los productos que tengan
   --ordenes con  tipos de trabajo 10444 - Visita Identificacion Certificado
   --o 12161 - REVISION PERIODICA
   CURSOR cuValOrdRP(nuproduct_id NUMBER) IS
    select
            1 valor
  from
        or_order_activity,
        or_order,
        mo_packages,
        LDC_PLAZOS_CERT
  where or_order_activity.PRODUCT_ID = nuproduct_id
    and or_order.order_id =
        or_order_activity.order_id
    and order_status_id in (0,5,8)
    AND or_order.task_type_id IN(10444,12161)
    AND LDC_PLAZOS_CERT.id_producto  =nuproduct_id
    AND or_order.created_date >  LDC_PLAZOS_CERT.plazo_min_revision
    and mo_packages.package_id =
    or_order_activity.package_id
    AND mo_packages.motive_status_id  IN(13,14);

    rccuValOrdRP cuValOrdRP%ROWTYPE;


    sbQuery varchar2(2000);
    --<<
    -- Tipo de dato cuOTREV Spacheco ara 7808 optimizacion
    -->>
    TYPE tycuOTREV IS TABLE OF cuOTREV%ROWTYPE;

    --<<
    -- Variable del tipo de dato tycuOTREV Spacheco ara 7808 optimizacion
    -->>
    vtycuOTREV tycuOTREV := tycuOTREV();

  BEGIN
    update ldc_rangogenint set inicia=sysdate where codrango=r;
    commit;
    pkErrors.Push('ldc_prFillOTREVcertifiDdet');
    --/*
    sbQuery := 'truncate table LDC_OTREV_CERTIF';
--    execute immediate sbQuery;
 -- ESTA INSTRUCCION AHORA SE EJECUTA DESDE EL PROCEDIMIENTO PRINCIPAL
    dbms_output.put_line('Inicio ldc_prFillOTREVcertifiDdet - ' ||
                         sysdate);

    ---spacheco ara 7808 optimizcion de proceso
    -- <<
    -- Apertura cursor cuOTREV
    -->>
    OPEN cuOTREV;

    LOOP

      --<<
      -- Borrar tabla PL vtycuOTREV
      -->>
      vtycuOTREV.DELETE;

      --<<
      -- Carga controlada de registros
      -->>
      FETCH cuOTREV BULK COLLECT
        INTO vtycuOTREV LIMIT 1000;

      --<<
      -- Recorrido de registros de la tabla pl tbl_datos
      -->>
      FOR nuindice IN 1 .. vtycuOTREV.COUNT LOOP
        --Aranda 7434
        --Validar las ordes de RP
        rccuValOrdRP := NULL;



          BEGIN

            --<<
            -- Inserta registros en la tabla LDC_OTREV_CERTIF
            -->>
            INSERT INTO /*+ append */
            LDC_OTREV_CERTIF
            VALUES
              (vtycuOTREV(nuindice).PRODUCT_ID,
              vtycuOTREV(nuindice).CLIENTE,
              vtycuOTREV(nuindice).IDENTIFICACION,
              vtycuOTREV(nuindice).NOMBRE,
              vtycuOTREV(nuindice).APELLIDO,
              vtycuOTREV(nuindice).DIRECCION,
              vtycuOTREV(nuindice).CODIGO_DEPARTAMENTO,
              vtycuOTREV(nuindice).DEPARTAMENTO,
              vtycuOTREV(nuindice).CODIGO_LOCALIDAD,
              vtycuOTREV(nuindice).LOCALIDAD,
              vtycuOTREV(nuindice).CODIGO_BARRIO,
              vtycuOTREV(nuindice).BARRIO,
              vtycuOTREV(nuindice).CICLO,
              vtycuOTREV(nuindice).USO,
              vtycuOTREV(nuindice).ESTRATO,
              vtycuOTREV(nuindice).MESES);

          EXCEPTION
            WHEN OTHERS THEN
              NULL;
          END;

        END LOOP;
        COMMIT;--commit cada 1000 registros

      EXIT WHEN cuOTREV%NOTFOUND;

    END LOOP;

    --<<
    -- Cierre del cursor cuOTREV.
    -->>
    IF (cuOTREV%ISOPEN) THEN

      CLOSE cuOTREV;

    END IF;
    COMMIT;

    --fin modificacion spacheco ara 7808 optimizacion

    --*/

    --inicio rnp2180
   -- sbQuery := 'truncate table ldc_otrev_items_especiales';
   -- EXECUTE IMMEDIATE sbQuery;

    COMMIT;


    dbms_output.put_line('Fin ldc_prFillOTREVcertifiDdet - ' ||
                         sysdate);
    pkErrors.Pop;
    update ldc_rangogenint set finaliza=sysdate,ejecutado=0,OBSERVACION='TERMINO' where codrango=r;
  EXCEPTION
    when others then
      update ldc_rangogenint set finaliza=sysdate,ejecutado=0,OBSERVACION='CON ERRORES' where codrango=r;
      dbms_output.put_line('Error ldc_prFillOTREVcertifiDdet ' ||
                           sqlcode || ' - ' || sqlerrm);
      raise;
END ldc_prFillOTREVcertifiDdet;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PRFILLOTREVCERTIFIDDET', 'ADM_PERSON');
END;
/
