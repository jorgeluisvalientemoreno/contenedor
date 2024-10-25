SELECT          unidad_operativa,
                 localidad,
                 gruptitr grupo_producto,
                 grupo_categoria grupo_categoria,
                 COUNT(producto) usu_recu,
                 sum(nvl(deuda_normalizada, 0)) deuda_normalizada,
                 sum(nvl(recaudo, 0)) recaudo
            FROM ldc_deta_prodrecu
           WHERE nuano = 2024
             AND numes = 8
 GROUP BY localidad, unidad_operativa, gruptitr, grupo_categoria;
