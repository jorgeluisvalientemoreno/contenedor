WITH NotasFact AS (
            SELECT *
            FROM notas
            WHERE  notatino IN ('C', 'D')
               AND notaprog NOT IN  ( 700, 2016)
			  AND pkg_boconsultaempresa.fsbObtEmpresaFactura(notas.notafact) = 'GDCA'
             AND notas.notafecr BETWEEN sysdate - 120 AND  sysdate

           ), NotaIngreso AS
              (SELECT *
               FROM NotasFact
               WHERE EXISTS ( SELECT 1
                              FROM cargos, cuencobr, concepto
                              WHERE cargos.cargcuco = cuencobr.cucocodi 
                                AND cuencobr.cucofact = NotasFact.notafact
								AND cargos.cargcodo = NotasFact.notanume
                                AND (cargos.cargprog = NotasFact.notaprog )
								AND concepto.concticl <> 4
								AND cargos.cargconc NOT IN (  196, 37, 167, 142, 108, 596, 717, 832,895,936,1006)
                                AND cargos.cargcaca IN (1,3,4,86)) ),
		  NotasAReportar AS (
			  SELECT  NotaIngreso.notanume, 
                     TO_CHAR(SYSDATE, 'YYYY') pefaano, 
                     TO_CHAR(SYSDATE, 'MM') pefames, 
                     -1 pefacodi,
                     NVL((  SELECT 'N'
                            FROM facturas_emitidas
                            WHERE facturas_emitidas.tipo_documento <> 3--pkg_bcfactuelectronicagen.cnuTipoDocuNotas
                               AND facturas_emitidas.documento = factura.factcodi
                               AND ROWNUM < 2 ),'S') Notarefe
			  FROM NotaIngreso, factura, servsusc, cuencobr
			  WHERE  factura.factcodi = NotaIngreso.notafact
				AND factura.factsusc = servsusc.sesususc
				AND cuencobr.cucofact = factura.factcodi
				AND cuencobr.cuconuse = servsusc.sesunuse
				AND servsusc.sesuserv NOT IN (  7053,7056 )  )
			SELECT unique NotasAReportar.notanume, NotasAReportar.pefaano, NotasAReportar.pefames, NotasAReportar.pefacodi, Notarefe
            FROM NotasAReportar            
			WHERE NOT EXISTS (
                                SELECT  1
                                  FROM factura_elect_general
                                  WHERE factura_elect_general.tipo_documento = 3--pkg_bcfactuelectronicagen.cnuTipoDocuNotas
                                    AND factura_elect_general.documento = NotasAReportar.notanume
								 UNION ALL
								 SELECT 1
								 FROM facturas_emitidas
								 WHERE facturas_emitidas.tipo_documento = 3--pkg_bcfactuelectronicagen.cnuTipoDocuNotas
								   AND facturas_emitidas.documento = NotasAReportar.notanume);
