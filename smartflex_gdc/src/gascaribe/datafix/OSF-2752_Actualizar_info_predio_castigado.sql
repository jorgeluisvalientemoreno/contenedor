DECLARE
    CURSOR cuOtieneProductosCastigados
    IS
    SELECT  b.product_id,
        c.address_id,
        d.premise_id
    FROM    servsusc    a, 
            pr_product  b,
            ab_address  c,
            ab_premise  d
    WHERE   b.product_id = a.sesunuse
    AND     c.address_id = b.address_id 
    AND     d.premise_id = c.estate_number 
    AND     a.sesuesfn = 'C';

    CURSOR cuObtieneInfoPredio
    (
        inuPredio IN ldc_info_predio.premise_id%TYPE
    )
    IS
    SELECT  * 
    FROM    ldc_info_predio
    WHERE   premise_id = inuPredio;

    rcInfoPredio        cuObtieneInfoPredio%ROwTYPE;
    rcInfoPredioVacio   cuObtieneInfoPredio%ROwTYPE;
BEGIN
  dbms_output.put_line('Inicia Actualización de Productos Castigados!');

  FOR rcProductosCastigados IN cuOtieneProductosCastigados LOOP
      rcInfoPredio := rcInfoPredioVacio;

      IF (cuObtieneInfoPredio%ISOPEN) THEN
          CLOSE cuObtieneInfoPredio;
      END IF;

      OPEN cuObtieneInfoPredio(rcProductosCastigados.premise_id);
      FETCH cuObtieneInfoPredio INTO rcInfoPredio;
      CLOSE cuObtieneInfoPredio;

      IF(rcInfoPredio.premise_id IS NOT NULL AND rcInfoPredio.predio_castigado = 'N' ) THEN
          UPDATE ldc_info_predio SET predio_castigado = 'S' WHERE ldc_info_predio_id = rcInfoPredio.ldc_info_predio_id;
          COMMIT;
      END IF;
  END LOOP;

  dbms_output.put_line('Fin Actualización de Productos Castigados!');  
END;
/