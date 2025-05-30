select ga.*, rowid from open.ge_acta ga where ga.id_acta = 228714;
--/*
Update open.ge_acta ga
   set ga.FECHA_CIERRE       = null,
       ga.ESTADO             = 'A',
       ga.IS_PENDING         = null,
       ga.EXTERN_PAY_DATE    = null,
       ga.EXTERN_INVOICE_NUM = null
 where ga.id_acta = 228714;

--Luego retirar ordenes verificadas en acta CTCCO / Acta de Obligaciones / Verificacion y Modificacion de Ordenes

--*/
