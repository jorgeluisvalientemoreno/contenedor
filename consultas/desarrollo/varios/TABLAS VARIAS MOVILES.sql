SELECT *
FROM OPEN.LDCI_SISTMOVILTIPOTRAB
WHERE TASK_TYPE_ID=12688;

select *
from open.LDCI_INFGESTOTMOV
where sistema_id='WS_LUDYENCUESTA'
 and fecha_procesado>='01/02/2020';


SELECT *
FROM OPEN.LDCI_MESAENVWS
WHERE MESADEFI='WS_LUDYENCUESTA'
  AND MESAFECH>='01/09/2019';
  
SELECT *
FROM OPEN.LDCI_DEFISEWE
WHERE DESECODI='WS_LUDYENCUESTA';

SELECT S.*,
(SELECT COUNT(1) FROM OPEN.FM_POSSIBLE_NTL N WHERE N.ORDER_ID=S.ORDER_ID)
FROM OPEN.LDCI_ORDENMOVILES S
--WHERE S.ORDER_ID =151354553;
WHERE S.TASK_TYPE_ID=12688;

select order_id,
             system,
             dataorder,
             initdate,
             finaldate,
             changedate,
             messagecode,
             messagetext,
             state,
             fecha_recepcion,
             fecha_procesado,
             fecha_notificado,
             veces_procesado,
             substr(DATAORDER,instr(DATAORDER,'|',1,4)+1,instr(DATAORDER,'>',1)-instr(DATAORDER,'|',1,4)-1) 
        from open.LDCI_ORDENESALEGALIZAR
       where order_id in (189249537 );
