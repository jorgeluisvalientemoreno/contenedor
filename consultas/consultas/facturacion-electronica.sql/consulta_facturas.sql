SELECT factura.factcodi
        FROM factura
        WHERE factura.factpefa = inuPeriodo
           AND factprog = 6
           AND NOT EXISTS ( SELECT 1
                            FROM factura_elect_general
                            WHERE factura_elect_general.tipo_documento = inuTipoDocu
                             AND factura_elect_general.documento = factura.factcodi )
           AND mod(factura.factcodi, inuTotalHilo )+ 1 = inuHilo;