SELECT
    ga.id_acta                                   AS acta,
    ga.nombre                                   AS nombre_acta,
    ga.fecha_creacion                           AS fecha_creacion_acta,

    (
        SELECT pe.nombre
        FROM open.ge_periodo_cert pe
        WHERE pe.id_periodo = ga.id_periodo
    )                                           AS periodo,

    ga.id_contrato                              AS contrato,
    co.descripcion                              AS descripcion_contrato,
    co.id_tipo_contrato                         AS tipo_contrato,

    (
        SELECT tc.descripcion
        FROM open.ge_tipo_contrato tc
        WHERE tc.id_tipo_contrato = co.id_tipo_contrato
    )                                           AS descripcion_tipo_contrato,

    ga.estado                                   AS estado_acta,
    co.id_contratista                           AS contratista,

    (
        SELECT gc.nombre_contratista
        FROM open.ge_contratista gc
        WHERE gc.id_contratista = co.id_contratista
    )                                           AS nombre_contratista,

    (
        SELECT ci.identification
        FROM open.ge_contratista gc,
             open.ge_subscriber  ci
        WHERE gc.id_contratista = co.id_contratista
          AND gc.subscriber_id  = ci.subscriber_id
    )                                           AS nit,

    ga.extern_invoice_num                       AS factura,
    NVL(valor_aui_admin, 0)
  + NVL(valor_aui_util, 0)
  + NVL(valor_aui_imprev, 0)                    AS aiu,

    valor_total                                 AS neto_pagar

FROM open.ge_acta     ga,
     open.ge_contrato co
WHERE ga.id_acta     = 258453
  AND ga.id_contrato = co.id_contrato
