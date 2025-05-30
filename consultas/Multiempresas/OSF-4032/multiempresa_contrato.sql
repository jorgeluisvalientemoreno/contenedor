select *
from multiempresa.contrato  ce
where ce.contrato in (1000895)


/*delete from multiempresa.contrato  ce1 where ce1.contrato in (1000895)*/

/*
BEGIN
   INSERT INTO multiempresa.contrato (contrato, empresa)
   VALUES (1000102, 'GDCA');
   
   COMMIT; -- opcional, depende si quieres confirmar la transacción aquí
END;
/

*/
