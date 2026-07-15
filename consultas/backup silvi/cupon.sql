   CURSOR cuCuponaPagar IS
    SELECT cuponume, cupovalo, cupoflpa, cuposusc
    FROM CUPON
    WHERE CUPODOCU =11234313
     AND cuposusc = '66282357'
     AND cupoflpa = 'S'
     AND cupovalo > 0;

select *
from LDC_SOLIANECO
where SOLICITUD =156099534
estado = 'T'

select *  from cargos c
where c.cargnuse = 51684966

select *
from cupon
where   cuposusc = '67251025'
     AND cupoflpa = 'N'
