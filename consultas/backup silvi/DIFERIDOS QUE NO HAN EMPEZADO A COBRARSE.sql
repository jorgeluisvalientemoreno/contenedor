SELECT *
FROM FACTURA
WHERE FACTPEFA = 101559 AND EXISTS (SELECT 1 
                                    FROM DIFERIDO 
                                    inner join servsusc on difesusc = sesususc 
                                    WHERE DIFESUSC = FACTSUSC 
                                    and difenuse = sesunuse 
                                    and sesuserv = 7053
                                    AND DIFECUPA = 0
                                    and difeprog = 'GCNED')
 AND FACTPROG = 6;
