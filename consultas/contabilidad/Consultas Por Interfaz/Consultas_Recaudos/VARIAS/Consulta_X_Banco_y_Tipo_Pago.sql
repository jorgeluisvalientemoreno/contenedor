select trunc(fecha_grabacion), tipo, banco, (select bancnomb from open.banco where banccodi = banco ) banconomb, 
       --sucursal, (select subanomb from open.sucubanc where subacodi = sucursal and subabanc = banco ) subanomb, 
       sum(valor_pago) valor_pago
  from (
         SELECT a.PAGOFEGR fecha_grabacion, (SELECT cupotipo FROM open.cupon WHERE cuponume = a.pagocupo) tipo,
                a.pagobanc banco, a.pagosuba sucursal, a.PAGOVAPA valor_pago
          FROM open.pagos a
         WHERE pagofegr >= '10-02-2015' AND pagofegr < '11-02-2015'
       )
group by trunc(fecha_grabacion), tipo, banco--, sucursal
