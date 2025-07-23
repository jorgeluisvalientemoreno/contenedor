 SELECT GE_FINANCIAL_PROFILE.MAX_BUDGET
      FROM GE_PERSON,
           GE_FINANCIAL_PROFILE
     WHERE GE_PERSON.USER_ID = (select s.user_id from open.sa_user  S where mask='LILCAB')
       AND GE_FINANCIAL_PROFILE.POSITION_TYPE_ID = GE_PERSON.POSITION_TYPE_ID
       AND GE_FINANCIAL_PROFILE.ACTION_AMOUNT_ID =5;
       
       SELECT *
       FROM GE_FINANCIAL_PROFILE
       WHERE ACTION_AMOUNT_ID =5;


/*
1-Monto Financianciaciones
2-Monto transaccion en Caja
3-Monto novedad a contratista
4-Montos notas de facturación
5-Monto devolucion saldo a favor
6-Monto de negocicion de deuda.
*/