with clasexcl as(
   select ',245,246,303,311,314,302,267,265,414,262,312,' as casevalo 
)
,clasificador as(
   select tt.IdClasificadorContable , tt.IdTipoTrabajo , cl.Descripcion
   from InterfazContable.DimClasifContTipoTrab tt,
        InterfazContable.DimClasificadorContable cl 
   where tt.IdTipoTrabajo !=11227 and tt.IdClasificadorContable Not in (245,246,303,311,314,302,267,265,414,262,312) and cl.IdClasificadorContable = tt.IdClasificadorContable)
, cuenta as(
   select distinct cl.IdClasificador, lc.IdCtaContable, lc.DescCtaContable 
   from InterfazContable.DimCtaCostoGastoClasif cl, 
        InterfazContable.DimCtaContableIntegracion lc, 
        clasificador c 
   where c.IdClasificadorContable = cl.IdClasificador 
   and   CAST(cl.IdCuentaCosto AS VARCHAR) = lc.IdCtaContable)
, ceco as(
   select cc.IdCentroCosto, cc.IdOrdenInternaSAP, cc.IdLocalidad, cc.IdTipoTrabajo 
   from InterfazContable.DimCeCoUbicGeograTipoTrab cc) 
, localidades as (
   select lo.bkGeografiaPadre AS depa, 
          lo.Departamento AS desc_depa, 
          lo.bkGeografia AS loca, 
          lo.NombreGeografia AS desc_loca,
          cb.IdCentroBeneficio AS CEBE
    from Comun.DimGeografia lo
    left join Facturacion.DimCentroBeneficio cb on cb.IdLocalidad = lo.Bkgeografia
    where lo.TipoGeografia = 'LOCALIDAD'
    and   lo.valido = 1
    and   lo.BKGeografiaPadre <> -1)
, base as(
        select  1 as tipo1,
				o.IdOrden,
                o.IdTipoTrabajo,
                o.IdTipoTrabajoReal,
                o.FechaLegalizacion,
                o.IdUnidadOperativa,
                u.Nombre,
                u.IdContratista,
                a.IdActa acta,
                a.NumeroFactura,
                a.FechaFactura,
                sum(CASE WHEN i.IdItem = 4001293 THEN 0 ELSE d.ValorTotal END) valor_total,
                sum(CASE WHEN i.IdItem = 4001293 THEN d.ValorTotal ELSE 0 END) valor_iva,
                ct.IdClasificadorContable,
                ct.Descripcion,
                o.IdDireccionExterna,
                o.IdContratoDefinido,
                ca.IdTipoCausal
        from Comun.FactOrden o
        inner join clasificador ct on ct.IdTipoTrabajo = CASE WHEN o.IdTipoTrabajo = 10336 THEN o.IdTipoTrabajoReal ELSE o.IdTipoTrabajo END
        inner join Comun.DimUnidadOperativa u on u.BkUnidadOperativa = o.IdUnidadOperativa  and u.FlagEsExterna = 'Y' and u.Valido = 1
        inner join Comun.FactDetalleActa d on d.ValorTotal !=0 and d.IdOrden = o.IdOrden and d.Valido=1
		inner join Comun.FactActa a on a.IdActa = d.IdActa and (a.FechaFactura = '1900-01-01 00:00:00.000' or a.FechaFactura >= DATEADD(DAY,1,'2022-11-30')) and a.Valido=1
        inner join Comun.DimItem i on i.IdItem = d.IdItem and (i.IdClasificacionItem !=23 or i.IdItem = 4001293) and i.Valido = 1
        inner join Comun.DimCausal ca on ca.BkCausal = o.IdCausal
        where o.FechaLegalizacion < DATEADD(DAY,1,'2022-11-30')
          and o.FechaCreacion < DATEADD(DAY,1,'2022-11-30')
          and o.IdEstadoOrden = 8
        group by  o.IdOrden,
                o.IdTipoTrabajo,
                o.IdTipoTrabajoReal,
                o.FechaLegalizacion,
                o.IdUnidadOperativa,
                u.Nombre,
                u.IdContratista,
                a.IdActa,
                a.NumeroFactura,
                a.FechaFactura,
                ct.IdClasificadorContable,
                ct.Descripcion,
                o.IdDireccionExterna,
                o.IdContratoDefinido,
                ca.IdTipoCausal
        union
        select 2 as tipo1,
				o.IdOrden,
                o.IdTipoTrabajo,
                o.IdTipoTrabajoReal,
                o.FechaLegalizacion,
                o.IdUnidadOperativa,
                u.Nombre,
                u.IdContratista,
                null acta,
                null factura,
                null fecha_factura,
                sum( CASE WHEN oi.Signo = 'N' THEN oi.Valor*-1 ELSE oi.Valor END) valor_total,
                0 valor_iva,
                ct.IdClasificadorContable,
                ct.Descripcion,
                o.IdDireccionExterna,
                o.IdContratoDefinido,
                c.IdTipoCausal
        from Comun.FactOrden o
        inner join clasificador ct on ct.IdTipoTrabajo = CASE WHEN o.IdTipoTrabajo = 10336 THEN o.IdTipoTrabajoReal ELSE o.IdTipoTrabajo END
        inner join Comun.DimUnidadOperativa u on u.BkUnidadOperativa = o.IdUnidadOperativa  and u.FlagEsExterna = 'Y' and u.Valido = 1
        inner join Comun.FactItemOrden oi on oi.IdORden = o.IdOrden and oi.Valor != 0
        inner join Comun.DimItem i on i.IdItem = oi.IdItem and i.IdClasificacionItem not in (3,8,21) and i.Valido = 1
        inner join Comun.DimCausal c on c.BkCausal = o.IdCausal and c.IdClaseCausal = 1
        where o.FechaLegalizacion < DATEADD(DAY,1,'2022-11-30')
          and o.FechaCreacion < DATEADD(DAY,1,'2022-11-30')
          and o.IdEstadoOrden = 8
          and (o.PendienteLiquidacion in ('Y','E'))
          and not exists(select null from Comun.DimItemNovedad n where n.IdItem = oi.IdItem)
        group by o.IdOrden,
                o.IdTipoTrabajo,
                o.IdTipoTrabajoReal,
                o.FechaLegalizacion,
                o.IdUnidadOperativa,
                u.Nombre,
                u.IdContratista,
                ct.IdClasificadorContable,
                ct.Descripcion,
                o.IdDireccionExterna,
                o.IdContratoDefinido,
                c.IdTipoCausal
                
        union
        select 3 as tipo1,
			o.IdOrden,
                o.IdTipoTrabajo,
                o.IdTipoTrabajoReal,
                o.FechaLegalizacion,
                o.IdUnidadOperativa,
                u.Nombre,
                u.IdContratista,
                null acta,
                null factura,
                null fecha_factura,
                sum(a.ValorReferencia * n.SignoLiquidacion * (CASE WHEN r.IdOrden IS NULL THEN 1 ELSE -1 END)) valor,
                0 valor_iva,
                ct.IdClasificadorContable,
                ct.Descripcion,
                o.IdDireccionExterna,
                o.IdContratoDefinido,
                c.IdTipoCausal
        from Comun.FactOrden o
        inner join clasificador ct on ct.IdTipoTrabajo = CASE WHEN o.IdTipoTrabajo = 10336 THEN o.IdTipoTrabajoReal ELSE o.IdTipoTrabajo END
        inner join Comun.DimUnidadOperativa u on u.BkUnidadOperativa = o.IdUnidadOperativa  and u.FlagEsExterna = 'Y' and u.Valido = 1
        inner join Comun.FactActividad a on a.IdOrden = o.IdOrden and a.IdTipoTrabajo = o.IdTipoTrabajo and a.FechaFinalizacion = '1900-01-01 00:00:00.000'
        inner join Comun.DimItemNovedad n on n.IdItem = a.IdActividad
        inner join Comun.DimCausal c on c.BkCausal = o.IdCausal and c.IdClaseCausal = 1
        left  join Comun.FactOrdenRelacionada r on r.IdOrdenRelacionada = o.IdOrden and r.IdTipoRelacion = 15
        where o.FechaLegalizacion < DATEADD(DAY,1,'2022-11-30')
          and o.FechaCreacion < DATEADD(DAY,1,'2022-11-30')
          and o.IdEstadoOrden = 8
          and (o.PendienteLiquidacion in ('Y','E'))
          and exists(select null from Comun.DimItemNovedad n where n.IdItem = a.IdActividad)
        group by o.IdOrden,
                o.IdTipoTrabajo,
                o.IdTipoTrabajoReal,
                o.FechaLegalizacion,
                o.IdUnidadOperativa,
                u.Nombre,
                u.IdContratista,
                ct.IdClasificadorContable,
                ct.Descripcion,
                o.IdDireccionExterna,
                o.IdContratoDefinido,
                c.IdTipoCausal)
,base2 as(       
             select b.tipo1,
			case when b.acta is not null then 'ACTA_S_F' else 'SIN_ACTA' end tipo,
             a.IdProducto,
             b.acta,
             CASE WHEN b.IdTipoTrabajo = 10336 THEN b.IdTipoTrabajoReal ELSE b.IdTipoTrabajo END titr,
             --open.daor_task_type.fsbgetdescription(decode(b.task_type_id,10336,b.real_task_type_id,b.task_type_id), null) desc_titr,
             --open.daor_task_type.fnugetconcept(decode(b.task_type_id,10336,b.real_task_type_id,b.task_type_id), null) concept,
             b.valor_total total,
             ISNULL(b.valor_iva,0) total_iva,
             b.IdClasificadorContable clasificador,
             b.Descripcion,
             b.IdContratista contratista,
             (select d.NombreContratista from Contratos.DimContratista d where d.IdContratista=b.IdContratista) nombre,
             b.FechaLegalizacion FEC_LEGA,
             b.IdOrden orden, 
             a.IdActividad actividad,
             a.IdSolicitud solicitud,
             lo.depa departamento,
             lo.loca localidad,
             lo.CEBE centro_beneficio,
             (select tc.IdTipoContrato from Contratos.DimContratos tc where tc.IdContrato=b.defined_contract_id) tipo_contrato,
             IdTipoCausal tipo_causal,       
             c.IdCtaContable cuenta, 
             c.DescCtaContable nom_cuenta,
             ceco.IdCentroCosto ceco,
             ceco.IdOrdenInternaSAP o_i,
             --(select gs.Identificacion from  Comun.DimCliente gs  where gs.subscriber_id=open.dage_contratista.fnugetsubscriber_id(b.contractor_id, null)) nit,
             row_number() over ( partition by b.IdOrden order by b.IdOrden) filas
        from base b
        inner join Comun.FactActividad a on b.IdOrden = a.IdOrden and a.IdTipoTrabajo = b.IdTipoTrabajo and a.FechaFinalizacion = '1900-01-01 00:00:00.000'
        left join Comun.DimDireccion di on di.IdDireccion = ISNULL(b.IdDireccionExterna, a.IdDireccion) and di.Valido = 1
        left join localidades lo on lo.loca = di.IdUbicacionGeografica
        left join cuenta c on c.IdClasificador = b.IdClasificadorContable
        left join ceco on ceco.IdLocalidad = lo.loca and ceco.IdTipoTrabajo = CASE WHEN b.IdTipoTrabajo = 10336 THEN b.IdTipoTrabajoReal ELSE b.IdTipoTrabajo END
)
select b2.tipo1,
		b2.tipo,
       b2.IdProducto,
       b2.acta,
       b2.titr,
       --b2.desc_titr,
       --b2.concept,
       b2.total,
       b2.total_iva,
       b2.clasificador,
       b2.Descripcion,
       b2.contratista,
       --b2.nombre,
       b2.FEC_LEGA,
       b2.orden, 
       b2.actividad,
       b2.solicitud,
       b2.departamento,
       b2.localidad,
       b2.centro_beneficio,
       --b2.tipo_contrato,
       b2.tipo_causal,       
       b2.cuenta, 
       b2.nom_cuenta,
       b2.ceco,
       b2.o_i
       --b2.nit
from base2 b2
where filas=1