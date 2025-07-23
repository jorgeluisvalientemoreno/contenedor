DECLARE

    CURSOR cuInfoPromociones
    IS
    SELECT  
            mp.package_id,
            p.product_id,
            p.initial_date,
            p.final_date    
    FROM    pr_promotion p
    LEFT JOIN (
        SELECT mp.product_id,
              mp.package_id
        FROM (
            SELECT s.package_id,
                  m.product_id,
                  ROW_NUMBER() OVER (
                      PARTITION BY m.product_id 
                      ORDER BY s.request_date DESC
                  ) AS rn
            FROM mo_packages s
            JOIN mo_motive m ON m.package_id = s.package_id
            WHERE s.package_type_id = 100267
        ) mp
        WHERE mp.rn = 1
    ) mp ON mp.product_id = p.product_id
    WHERE p.asso_promotion_id = 73
      AND TRUNC(p.initial_date) <= TRUNC(SYSDATE)
      AND TRUNC(p.final_date) > TRUNC(SYSDATE);
BEGIN
  dbms_output.put_line('Inicia Datafix OSF-4171!');

  FOR rgPromocion IN cuInfoPromociones LOOP

      dbms_output.put_line('Registra producto: '||rgPromocion.package_id);
      INSERT INTO EXENCION_COBRO_FACTURA
      (
        SOLICITUD,
        PRODUCTO,
        FECHA_INI_VIGENCIA,
        FECHA_FIN_VIGENCIA
      )
      VALUES
      (
        rgPromocion.package_id,
        rgPromocion.product_id,
        rgPromocion.initial_date,
        rgPromocion.final_date
      );
  END LOOP;

  dbms_output.put_line('Inicia Datafix OSF-4171!');
  commit;
END;
/