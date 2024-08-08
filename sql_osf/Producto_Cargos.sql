--1.    Se consulta producto de brilla 7055, con deuda en diferido y deuda corriente.
select *
  from servsusc
 where sesuserv = 7055
   and exists (SELECT 1
          FROM diferido
         WHERE difenuse = sesunuse
           AND difetire = 'D'
           AND difesign in ('DB', 'CR')
           AND difesape > 0
           and nvl(difeenre, 'N') = 'N')
   and exists (SELECT 1
          FROM cuencobr
         WHERE cuconuse = sesunuse
           AND nvl(cucosacu, 0) > 0
           and nvl(cucovare, 0) = 0
           and nvl(CUCOVRAP, 0) = 0);
