--select l.*, rowid from open.ld_parameter l where l.parameter_id='CATEG_IDUSTRIA_NO_REG'; 
SELECT sesucate,
       (select l.value_chain
          from open.ld_parameter l
         where l.parameter_id = 'CATEG_IDUSTRIA_NO_REG') CATEG_IDUSTRIA_NO_REG,
       DECODE(instr('|' ||
                    (select l.value_chain
                       from open.ld_parameter l
                      where l.parameter_id = 'CATEG_IDUSTRIA_NO_REG') || '|',
                    '|' || sesucate || '|'),
              0,
              'NO - FALSE - 0',
              'SI - TRUE - 1') NO_REGULADO --INTO nuCategori
  FROM open.servsusc
 WHERE sesususc = 48242482
   AND sesuserv = 7014
   AND rownum = 1;
