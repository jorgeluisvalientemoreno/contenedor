CREATE OR REPLACE PROCEDURE adm_person.ldc_prcargrecl(inucontratoid IN mo_motive.subscription_id%TYPE,
                                                      orfcursordata OUT constants.tyrefcursor) 
IS
    /**************************************************************************
    Autor       : Horbath
    Fecha       : 24-06-2020
    CASO      : 275
    Descripcion: Servicio que retorna un cursor obteniendo los cargos reclamados relacionados a el tramite
    
    INUCONTRATOID   Identificacion del Contrato
    
    Valor de salida
    ORFCURSORDATA        Cursor que tiene el resutado de la consulta a nivel de contrato
    
    
    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR          DESCRIPCION
    17/04/2024   PAcosta        OSF-2532: Se crea el objeto en el esquema adm_person  
                                Se retira la referencia al esquema open (open.)
    08/05/2021   HORBATH        275_13: Se agrego logica para estabelcer el estado Activo (Si o No) de la solicitud de recurso
                                    de la 1ra sentencia con relacion al JOB.
    07/01/2021   HORBATH        275_5: Se agrego logica para estabelcer el estado Activo (Si o No) de la solicitud de recurso.    
    ***************************************************************************/

    sbsql VARCHAR2(32767);
    
    CURSOR cumopackges IS
    SELECT COUNT(mp.package_id) cantidad
    FROM mo_packages mp
    WHERE mp.package_id = inucontratoid
    AND mp.package_type_id IN
       (SELECT to_number(COLUMN_VALUE)
          FROM TABLE(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('COD_TIP_SOL_RECLAMOS',
                                                                                   NULL),
                                                  ',')));
    
    nucumopackges NUMBER;    
    sbactivo VARCHAR2(100) := 'Si';
BEGIN

    ut_trace.TRACE('Inicio LDC_PRCARGRECL', 1);
    
    OPEN cumopackges;
    FETCH cumopackges
    INTO nucumopackges;
    CLOSE cumopackges;
    
    IF nvl(nucumopackges, 0) > 0 THEN
    
        --Inicio CASO 275_13
        BEGIN
            /*select decode(mp.motive_status_id, 13, 'Si', 'No')
            into SbActivo
            from mo_packages mp
            where mp.package_id = INUCONTRATOID;*/
            SELECT decode(nvl(ls.package_recurso,0), 0, 'Si', 'No')
            INTO sbactivo
            FROM ldc_solprocjob ls
            WHERE ls.package_recurso = inucontratoid;
        EXCEPTION
            WHEN OTHERS THEN
                sbactivo := 'Si';
        END;
        --Fin CASO 275_13
        
        sbsql := 'select /*+ leading a b c
                    index(a, IDX_MO_MOTIVE_02)
                    index(b, IX_CARGTRAM13)
                    index(c, PK_CONCEPTO )
                     */
                     b.catrcons,
                     b.catrcuco,
                     b.catrnuse,
                     b.catrconc || '' - '' || c.concdesc concept,
                     b.catrunid,
                     b.catrunre,
                     b.catrvalo,
                     b.catrvare,
                     b.catrfecr,
                     b.catrcoll,
                     b.catrdoso,
                     b.catrsign,
                     a.package_id parent_id,
                     Decode(nvl((select nvl(lr.package_id_recu, 0)
                        from ldc_reclamos lr
                       where lr.package_id_recu = a.package_id
                         and lr.reconcep = b.catrconc
                         and lr.cucocodi = b.catrcuco
                         and lr.revaloreca = b.catrvare
                         and rownum = 1),0),0,''' || sbactivo ||''',''No'') Activo,
                     a.package_id Origen,
                     (select decode(nvl(lr.package_id, 0), 0, ''NA'', lr.package_id)
                        from ldc_reclamos lr
                       where lr.package_id_recu = a.package_id
                         and lr.reconcep = b.catrconc
                         and lr.cucocodi = b.catrcuco
                         and lr.revaloreca = b.catrvare
                         and rownum = 1) Destino
                      from mo_motive a, cargtram b, concepto c /*+ CC_BOSearchClaims.GetClaimChargPartQuery */
                     where a.motive_id = b.catrmoti(+)
                       and b.catrconc = c.conccodi
                       and a.package_id = :package_id';
    
    ELSE
    
        --Inicio CASO 275_5
        BEGIN
            /*select decode(mp.motive_status_id, 13, 'Si', 'No')
            into SbActivo
            from mo_packages mp
            where mp.package_id = INUCONTRATOID;*/
            SELECT decode(nvl(ls.package_recurso,0), 0, 'Si', 'No')
            INTO sbactivo
            FROM ldc_solprocjob ls
            WHERE ls.package_recurso = inucontratoid;
        EXCEPTION
            WHEN OTHERS THEN
                sbactivo := 'Si';
        END;
        --Fin CASO 275_5
        
        sbsql := 'select /*+ leading a b c
                        index(a, IDX_MO_MOTIVE_02)
                        index(b, IX_CARGTRAM13)
                        index(c, PK_CONCEPTO )
                         */
                         b.catrcons,
                         b.catrcuco,
                         b.catrnuse,
                         b.catrconc || '' - '' || c.concdesc concept,
                         b.catrunid,
                         b.catrunre,
                         b.catrvalo,
                         b.catrvare,
                         b.catrfecr,
                         b.catrcoll,
                         b.catrdoso,
                         b.catrsign,
                         a.package_id parent_id, '''
                         || sbactivo ||''' Activo,
                         (select decode(nvl(lr.package_id_recu, 0), 0, ''NA'', lr.package_id_recu)
                            from ldc_reclamos lr
                           where lr.package_id = a.package_id
                             and lr.reconcep = b.catrconc
                             and lr.cucocodi = b.catrcuco
                             and lr.revaloreca = b.catrvare
                             and rownum = 1) Origen,
                          a.package_id Destino
                          from mo_motive a, cargtram b, concepto c /*+ CC_BOSearchClaims.GetClaimChargPartQuery */
                         where a.motive_id = b.catrmoti(+)
                           and b.catrconc = c.conccodi
                           and a.package_id = :package_id';
        
    END IF;
    
    dbms_output.put_line('Sentencia: ' || CHR(10) || sbsql);
    ut_trace.TRACE('Sentencia: ' || CHR(10) || sbsql, 2);
    OPEN orfcursordata FOR sbsql
    USING inucontratoid;
    
    ut_trace.TRACE('Fin de LDC_PRCARGRECL', 1);

EXCEPTION
    WHEN ex.controlled_error THEN
        RAISE ex.controlled_error;
    WHEN OTHERS THEN
        ERRORS.seterror;
        RAISE ex.controlled_error;
END ldc_prcargrecl;
/
PROMPT Otorgando permisos de ejecucion a LDC_PRCARGRECL
BEGIN
  pkg_utilidades.praplicarpermisos('LDC_PRCARGRECL','ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre ldc_prcargrecl para reportes
GRANT EXECUTE ON adm_person.ldc_prcargrecl TO rexereportes;
/
