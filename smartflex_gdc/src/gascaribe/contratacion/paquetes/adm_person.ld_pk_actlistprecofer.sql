CREATE OR REPLACE PACKAGE adm_person.ld_pk_actlistprecofer AS
/*********************************************************************************************************
    Propiedad intelectual de HORBATH TECNOLOGIES

    Unidad         : ld_pk_actlistprecofer
    Descripcion    : paquete para la actualizacion de listas de precios de ofertados

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 21-01-2019

    Historia de Modificaciones
    Fecha           Autor                           Modificacion
    ==========      ==========================      =================================================
    12-01-2022      hahenao.HORBATH                 Se ajusta funcion LDC_FNCRETORNATAROFERTADAS para quitar filtro 
                                                    por fecha final de vigencia en sentencia de seleccion.
    28-01-2022      hahenao.HORBATH                 *Se ajusta funcion LDC_FNCRETORNATAROFERTADAS para volver a incluir filtro 
                                                    por fecha final de vigencia en sentencia de seleccion, que se abia quitado
                                                    por error
                                                    Se ajusta funcion ldc_fncretornalistprecofer para quitar filtro 
                                                    por fecha final de vigencia en sentencia de seleccion.
	10-08-2022		cgonzalez						OSF-486: Se modifican los servicios <ldc_fncretornatarofertadas> <ldc_procactfechasvigenciasofer>
    19/06/2024      PAcosta                         OSF-2845: Cambio de esquema ADM_PERSON  
**************************************************************************************************************/
FUNCTION ldc_fncretornacontratoofer(nupacontrato ge_contrato.id_contrato%TYPE) RETURN VARCHAR2;
FUNCTION ldc_fncretornatarofertadas(nupacontrato ge_contrato.id_contrato%TYPE,dtpafechafin DATE) RETURN NUMBER;
FUNCTION ldc_fncretornalistprecofer(nupacontrato ge_contrato.id_contrato%TYPE,dtpafechafin DATE) RETURN NUMBER;
PROCEDURE ldc_procactfechasvigenciasofer(nupacontrato ge_contrato.id_contrato%TYPE,dtpacufechfin DATE,dtpacufechfinact DATE,sbpaerror OUT VARCHAR2);
END ld_pk_actlistprecofer;
/
CREATE OR REPLACE PACKAGE BODY adm_person.ld_pk_actlistprecofer IS
/*********************************************************************************************************
    Propiedad intelectual de HORBATH TECNOLOGIES

    Unidad         : ld_pk_actlistprecofer
    Descripcion    : paquete para la actualizacion de listas de precios de ofertados

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 21-01-2019

    Historia de Modificaciones
    Fecha             Autor                         Modificacion
    ==========        ==========================    =================================================
**************************************************************************************************************/
FUNCTION ldc_fncretornacontratoofer(nupacontrato ge_contrato.id_contrato%TYPE) RETURN VARCHAR2 IS
/*********************************************************************************************************
    Propiedad intelectual de HORBATH TECNOLOGIES

    Unidad         : ldc_fncretornacontratoofer
    Descripcion    : Funcion que verifica si el contrato tiene unidades operativas ofertadas

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 21-01-2019

    Historia de Modificaciones
    Fecha             Autor                         Modificacion
    ==========        ==========================    =================================================
**************************************************************************************************************/
 nuconta NUMBER(6);
BEGIN
SELECT COUNT(1) INTO nuconta
FROM ldc_const_unoprl u
WHERE u.contrato = nupacontrato;
 IF nuconta >= 1 THEN
  RETURN 'S';
 ELSE
  RETURN 'N';
 END IF;
EXCEPTION
 WHEN OTHERS THEN
  RETURN -1;
END ldc_fncretornacontratoofer;
FUNCTION ldc_fncretornatarofertadas
(
    nupacontrato ge_contrato.id_contrato%TYPE,
    dtpafechafin DATE
) 
RETURN NUMBER 
IS
 /*********************************************************************************************************
    Propiedad intelectual de HORBATH TECNOLOGIES

    Unidad         : ldc_fncretornatarofertadas
    Descripcion    : Funcion que verifica si tiene tarifas ofertadas con la fecha final del contrato a modificar

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 21-01-2019

    Historia de Modificaciones
    Fecha           Autor                           Modificacion
    ==========      ==========================      =================================================
    12-01-2022      hahenao.HORBATH                 Se ajusta funcion LDC_FNCRETORNATAROFERTADAS para quitar filtro 
                                                    por fecha final de vigencia en sentencia de seleccion.
    28-01-2022      hahenao.HORBATH                 *Se ajusta funcion LDC_FNCRETORNATAROFERTADAS para volver a incluir filtro 
                                                    por fecha final de vigencia en sentencia de seleccion, que se abia quitado
                                                    por error
	10-08-2022	 	cgonzalez						Se ajusta para que valide si la unidad del contrato tiene listas de descuentos 
													sin importar que la fecha final de la lista no sea igual que la fecha final del contrato.
**************************************************************************************************************/
 nuconta NUMBER(6);
BEGIN
 -- Tarifas ofertadas
 SELECT COUNT(1) INTO nuconta
   FROM ldc_const_liqtarran h
  WHERE h.unidad_operativa IN(
                              SELECT unidad_operativa
                                FROM ldc_const_unoprl
                               WHERE contrato = nupacontrato
                             );
 RETURN nuconta;
EXCEPTION
 WHEN OTHERS THEN
  RETURN 0;
END ldc_fncretornatarofertadas;
FUNCTION ldc_fncretornalistprecofer(nupacontrato ge_contrato.id_contrato%TYPE,dtpafechafin DATE) RETURN NUMBER IS
 /*********************************************************************************************************
    Propiedad intelectual de HORBATH TECNOLOGIES

    Unidad         : ldc_fncretornatarofertadas
    Descripcion    : Funcion que verifica si tiene listas de precios ofertadas con la fecha final del contrato a modificar

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 21-01-2019

    Historia de Modificaciones
    Fecha             Autor                         Modificacion
    ==========        ==========================    =================================================
    28-01-2022      hahenao.HORBATH                 Se quita filtro por fecha final de vigencia en sentencia
                                                    de seleccion.
**************************************************************************************************************/
 nuconta NUMBER(6);
BEGIN
 -- Listas de precios unidades ofertadas
 SELECT COUNT(1) INTO nuconta
   FROM ldc_const_unoprl u,ge_list_unitary_cost c
  WHERE u.contrato                   = nupacontrato
    AND u.unidad_operativa           = c.operating_unit_id;
 RETURN nuconta;
EXCEPTION
 WHEN OTHERS THEN
  RETURN 0;
END ldc_fncretornalistprecofer;
PROCEDURE ldc_procactfechasvigenciasofer
(
    nupacontrato ge_contrato.id_contrato%TYPE,
    dtpacufechfin DATE,
    dtpacufechfinact DATE,
    sbpaerror OUT VARCHAR2
) 
IS
/**************************************************************************************************************
    Propiedad intelectual de HORBATH TECNOLOGIES

    Unidad         : ldc_procactfechasvigenciasofer
    Descripcion    : Procedimiento que actualiza las vigencias en las tarifas ofertados y listas de precio

    Autor          : John Jairo Jimenez Marimon
    Fecha          : 21-01-2019

    Historia de Modificaciones
    Fecha           Autor                   Modificacion
    ==========      ==================      =================================================
    31/08/2020      OLSOFTWARE              CA 475 
                                            se cambia la forma de busqueda de la ultima lista de descuento
                                            y lista de costo
    20/09/2021      dsaltarin               809: Se mejora control de errores
    12-01-2022      hahenao.HORBATH         CA 921.
                                            Se cambia de lugar condicion de validacion de aplicacion de CA475 y
                                            se indenta el procedimiento
    10-08-2022	 	cgonzalez				Se ajusta para eliminar el aplica del caso 475 y los cursores de
											actualizacion de lista de costos y de descuentos
**************************************************************************************************************/
    sbflagofer        VARCHAR2(1);
    nucontatarofer    NUMBER(10);
    nucontaliprecofer NUMBER(10);
    nuError        number;--809
BEGIN
    sbpaerror := NULL;
    -- Consultamos si el contrato tiene unidades ofertadas
    sbflagofer := ldc_fncretornacontratoofer(nupacontrato);
    IF sbflagofer = 'S' THEN
        /* Consultamos si las unidades ofertadas del contrato, tienen tarifas de descuentos para actualizar para
        actualizar fecha final de vigencia*/
        nucontatarofer := ldc_fncretornatarofertadas(nupacontrato,dtpacufechfin);
        IF nucontatarofer >= 1 THEN
			--CA 475 OL --se cambia forma de buscar la ultima lista de descuento
			-- Actualizamos las tarifas de descuentos
			UPDATE 	ldc_const_liqtarran l
			SET 	l.fecha_fin_vige = dtpacufechfinact
			WHERE 	l.unidad_operativa IN ( SELECT uy.unidad_operativa
											FROM ldc_const_unoprl uy
											INNER JOIN open.or_operating_unit u on u.operating_unit_id=uy.unidad_operativa
											INNER JOIN open.ge_contrato co on co.id_contrato= uy.contrato and co.id_contratista = u.contractor_id
											WHERE uy.contrato = nupacontrato
										  )
			AND 	l.fecha_fin_vige =  (select max(fecha_fin_vige)
										from ldc_const_liqtarran l1
										where l.unidad_operativa = l1.unidad_operativa);
        END IF;
        -- Consultamos si tenemos listas de precio para actualizar fecha final de vigencia
        nucontaliprecofer := ldc_fncretornalistprecofer(nupacontrato,dtpacufechfin);
        IF nucontaliprecofer >= 1 THEN
            
			UPDATE 	ge_list_unitary_cost c
			SET 	c.validity_final_date = dtpacufechfinact
			WHERE 	c.operating_unit_id IN (SELECT uy.unidad_operativa
											FROM ldc_const_unoprl uy
											INNER JOIN open.or_operating_unit u on u.operating_unit_id=uy.unidad_operativa
											INNER JOIN open.ge_contrato co on co.id_contrato= uy.contrato and co.id_contratista = u.contractor_id
											WHERE uy.contrato = nupacontrato
										  )
			AND c.validity_final_date = (select max(c1. validity_final_date)
										  from ge_list_unitary_cost c1
										  where c1. operating_unit_id = c.operating_unit_id);
		END IF;
	END IF;
    sbpaerror := NULL;
EXCEPTION
    WHEN OTHERS THEN
        errors.seterror;
        errors.geterror(nuError, sbpaerror);
END ldc_procactfechasvigenciasofer;

END ld_pk_actlistprecofer;
/
PROMPT Otorgando permisos de ejecucion a LD_PK_ACTLISTPRECOFER
BEGIN
    pkg_utilidades.praplicarpermisos('LD_PK_ACTLISTPRECOFER', 'ADM_PERSON');
END;
/