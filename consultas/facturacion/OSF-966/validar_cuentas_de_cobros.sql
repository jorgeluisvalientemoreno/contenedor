select l.cucocodi cuenta_cobro,
       l.cucovato valor_total_cuenta_cobro ,
       l.cucofepa fecha_pago ,
       l.cuconuse producto,
       l.cucosacu saldo_cuenta_cobro ,
       l.cucofact numero_factura,
       l.cucofaag fact_agrupadora,
       l.cucofeve fecha_vencimiento
from open.cuencobr l 
where  l.cuconuse= 17186740
order by l.cucofeve desc 