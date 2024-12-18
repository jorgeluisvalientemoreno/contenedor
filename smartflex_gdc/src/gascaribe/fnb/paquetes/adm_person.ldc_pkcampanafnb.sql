CREATE OR REPLACE PACKAGE ADM_PERSON.LDC_PKCAMPANAFNB is

  TYPE tyRefCursor IS REF CURSOR;

  /**************************************************************************
   Propiedad intelectual de GDC - EFIGAS.
   Nombre del Paquete: LDC_PKCAMPANAFNB
   Descripcion : Paquete para manejo de campa?as en FNB

   Autor       : JM.
   Fecha       : 05 - Febrero - 2019
   Historia de Modificaciones
     Fecha             Autor                Modificaci?n
   =========         =========          ====================
  **************************************************************************/

  /**************************************************************************
  Propiedad Intelectual de PETI
  Funcion     :  FNUARTISUBLPROV
  Descripcion :  Valida si el ARTICULO a registrar en la venta de FIFAP es del proveedor y esta configurados
                 en una de las sublineas configurados en el forma LDCPSC registrada en al tabal LDC_PROVSINCODE.
  Autor       :  Jorge Valiente
  Fecha       :  05-02-2019

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/

  FUNCTION FNULINEACAMPANA(InuARTICLE_ID     IN OPEN.LD_ARTICLE.ARTICLE_ID%TYPE,
                           InuID_CONTRATISTA GE_CONTRATISTA.ID_CONTRATISTA%TYPE,
                           InuSUSCCODI       IN OPEN.SUSCRIPC.SUSCCODI%TYPE)
    RETURN tyRefCursor;

  /**************************************************************************
  Propiedad Intelectual de PETI
  Funcion     :  FNUDATOSCAMPANA
  Descripcion :
  Autor       :  Jorge Valiente
  Fecha       :  08-02-2019

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/

  FUNCTION FNUDATOSCAMPANA(InuSolicitudVenta mo_packages.package_id%TYPE)

   RETURN tyRefCursor;

End LDC_PKCAMPANAFNB;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.LDC_PKCAMPANAFNB AS

  /**************************************************************************
   Propiedad intelectual de GDC - EFIGAS.
   Nombre del Paquete: LDC_PKCAMPANAFNB
   Descripcion : Paquete para manejo de campa?as en FNB

   Autor       : JM.
   Fecha       : 05 - Febrero - 2019
   Historia de Modificaciones
     Fecha             Autor                Modificaci?n
   =========         =========          ====================
  **************************************************************************/

  /**************************************************************************
  Propiedad Intelectual de PETI
  Funcion     :  FNULINEACAMPANA
  Descripcion :
  Autor       :  Jorge Valiente
  Fecha       :  05-02-2019

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/

  FUNCTION FNULINEACAMPANA(InuARTICLE_ID     IN OPEN.LD_ARTICLE.ARTICLE_ID%TYPE,
                           InuID_CONTRATISTA GE_CONTRATISTA.ID_CONTRATISTA%TYPE,
                           InuSUSCCODI       IN OPEN.SUSCRIPC.SUSCCODI%TYPE)

   RETURN tyRefCursor IS

    rfQuery tyRefCursor;

    cursor cuConfCampFNB is
      select lc.id_contratista PROVEEDOR,
             lc.geograp_location_id UBICACION,
             lc.line_id LINEA,
             lc.pldicodi PLANFINAN,
             (select nvl(lp.numeric_value, 0)
                from open.ld_parameter lp
               where lp.parameter_id = 'PRI_MEN_MIN_CARDIF_CAMP_FNB') PRIMACARDIFCAMPANA,
             (select pd.pldicumi
                from open.plandife pd
               where pd.pldicodi = lc.pldicodi
                 and rownum = 1) CUOTAMINIMA,
             nvl(lc.confcampfnb_montominimo, 0) MONTOMINIMO,
             (select lp.value_chain
                from open.ld_parameter lp
               where lp.parameter_id = 'SUBLIN_EXCLU_CAMP_FNB') SUBLINEAEXCLUIDACAMPANA,
             (select nvl(cgp.max_grace_days, cgp.min_grace_days)
                from cc_grace_period cgp
               where cgp.grace_period_id =
                     (select nvl(p.pldipegr, 0)
                        from plandife p
                       where p.pldicodi = lc.pldicodi
                         and rownum = 1)
                 and rownum = 1) DIAS_PERIODO_GRACIA
        from LDC_CONFCAMPFNB lc
       where (lc.id_contratista = InuID_CONTRATISTA or
             nvl(lc.id_contratista, -1) = -1)
         and (lc.line_id in
             (select ls.line_id
                 from ld_subline ls
                where ls.subline_id in (select la.subline_id
                                          from ld_article la
                                         where la.article_id = InuARTICLE_ID
                                           and rownum = 1)
                  and rownum = 1) or nvl(lc.line_id, -1) = -1)
         and (lc.geograp_location_id =
             (select a.geograp_location_id
                 from ge_geogra_location a, ab_address b, suscripc c
                where a.geograp_location_id = b.geograp_location_id
                  and b.address_id = c.susciddi
                  and c.susccodi = InuSUSCCODI) or
             lc.geograp_location_id =
             (select a.geo_loca_father_id
                 from ge_geogra_location a, ab_address b, suscripc c
                where a.geograp_location_id = b.geograp_location_id
                  and b.address_id = c.susciddi
                  and c.susccodi = InuSUSCCODI) or
             nvl(lc.geograp_location_id, -1) = -1)
         and (trunc(sysdate) >= trunc(lc.confcampfnb_fecini) and
             trunc(sysdate) <= trunc(lc.confcampfnb_fecfin))
       order by 1, 2, 3;

    rfcuConfCampFNB cuConfCampFNB%rowtype;

    vPlanfinan               number;
    vPrimacardifcampana      number;
    vCuotaminima             number;
    vMontominimo             number;
    vSublineaexcluidacampana varchar2(4000);
    vDias_Periodo_Gracia     number;

  BEGIN

    open cuConfCampFNB;
    fetch cuConfCampFNB
      into rfcuConfCampFNB;
    if cuConfCampFNB%found then
      open rfQuery for
        select rfcuConfCampFNB.Planfinan               Planfinan,
               rfcuConfCampFNB.Primacardifcampana      Primacardifcampana,
               rfcuConfCampFNB.Cuotaminima             Cuotaminima,
               rfcuConfCampFNB.Montominimo             Montominimo,
               rfcuConfCampFNB.Sublineaexcluidacampana Sublineaexcluidacampana,
               rfcuConfCampFNB.Dias_Periodo_Gracia     Dias_Periodo_Gracia
          from dual;
    else
      open rfQuery for
        select lc.id_contratista PROVEEDOR,
             lc.geograp_location_id UBICACION,
             lc.line_id LINEA,
             lc.pldicodi PLANFINAN,
             (select nvl(lp.numeric_value, 0)
                from open.ld_parameter lp
               where lp.parameter_id = 'PRI_MEN_MIN_CARDIF_CAMP_FNB') PRIMACARDIFCAMPANA,
             (select pd.pldicumi
                from open.plandife pd
               where pd.pldicodi = lc.pldicodi
                 and rownum = 1) CUOTAMINIMA,
             nvl(lc.confcampfnb_montominimo, 0) MONTOMINIMO,
             (select lp.value_chain
                from open.ld_parameter lp
               where lp.parameter_id = 'SUBLIN_EXCLU_CAMP_FNB') SUBLINEAEXCLUIDACAMPANA,
             (select nvl(cgp.max_grace_days, cgp.min_grace_days)
                from cc_grace_period cgp
               where cgp.grace_period_id =
                     (select nvl(p.pldipegr, 0)
                        from plandife p
                       where p.pldicodi = lc.pldicodi
                         and rownum = 1)
                 and rownum = 1) DIAS_PERIODO_GRACIA
        from LDC_CONFCAMPFNB lc
       where (lc.id_contratista = InuID_CONTRATISTA or
             nvl(lc.id_contratista, -1) = -1)
         and (lc.line_id in
             (select ls.line_id
                 from ld_subline ls
                where ls.subline_id in (select la.subline_id
                                          from ld_article la
                                         where la.article_id = InuARTICLE_ID
                                           and rownum = 1)
                  and rownum = 1) or nvl(lc.line_id, -1) = -1)
         and (lc.geograp_location_id =
             (select a.geograp_location_id
                 from ge_geogra_location a, ab_address b, suscripc c
                where a.geograp_location_id = b.geograp_location_id
                  and b.address_id = c.susciddi
                  and c.susccodi = InuSUSCCODI) or
             lc.geograp_location_id =
             (select a.geo_loca_father_id
                 from ge_geogra_location a, ab_address b, suscripc c
                where a.geograp_location_id = b.geograp_location_id
                  and b.address_id = c.susciddi
                  and c.susccodi = InuSUSCCODI) or
             nvl(lc.geograp_location_id, -1) = -1)
         and (trunc(sysdate) >= trunc(lc.confcampfnb_fecini) and
             trunc(sysdate) <= trunc(lc.confcampfnb_fecfin))
       order by 1, 2, 3;
    end if;
    close cuConfCampFNB;

    return rfQuery;

  EXCEPTION

    when ex.CONTROLLED_ERROR then
      return null;

    when others then
      return null;

  END FNULINEACAMPANA;

  /**************************************************************************
  Propiedad Intelectual de PETI
  Funcion     :  FNUDATOSCAMPANA
  Descripcion :
  Autor       :  Jorge Valiente
  Fecha       :  08-02-2019

  Historia de Modificaciones
    Fecha          Autor                   Modificacion
  =========       =========                ====================
  **************************************************************************/

  FUNCTION FNUDATOSCAMPANA(InuSolicitudVenta mo_packages.package_id%TYPE)

   RETURN tyRefCursor IS

    rfQuery tyRefCursor;

  BEGIN

    open rfQuery for
      select nvl(A.TAKE_GRACE_PERIOD, 'N') PERIODO_GRACIA
        from open.LD_NON_BA_FI_REQU A
       where A.non_ba_fi_requ_id = InuSolicitudVenta
         and rownum = 1;

    return rfQuery;

  EXCEPTION

    when ex.CONTROLLED_ERROR then
      return null;

    when others then
      return null;

  END FNUDATOSCAMPANA;

END LDC_PKCAMPANAFNB;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKCAMPANAFNB
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKCAMPANAFNB', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LDC_PKCAMPANAFNB para reportes
GRANT EXECUTE ON ADM_PERSON.LDC_PKCAMPANAFNB TO REXEREPORTES;
/
BEGIN
	pkg_utilidades.prCrearSinonimos('LDC_PKCAMPANAFNB', 'ADM_PERSON');
END;
/