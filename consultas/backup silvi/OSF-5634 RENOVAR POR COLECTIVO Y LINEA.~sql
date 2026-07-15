SELECT   policy_id,
         c.empresa,
         state_policy,
         launch_policy,
         collective_number,
         contratist_code,
         product_line_id,
         dt_in_policy,
         dt_en_policy,
         value_policy,
         prem_policy,
         name_insured,
         suscription_id,
         product_id,
         identification_id,
         period_policy,
         year_policy,
         month_policy,
         deferred_policy_id,
         dtcreate_policy,
         share_policy,
         dtret_policy,
         valueacr_policy,
         report_policy,
         dt_report_policy,
         dt_insured_policy,
         per_report_policy,
         policy_type_id,
         id_report_policy,
         cancel_causal_id,
         fees_to_return,
         comments,
         policy_exq,
         number_acta,
         geograp_location_id,
         validity_policy_type_id,
         policy_number
        FROM ld_policy p, contrato c
    WHERE P.suscription_id = c.contrato
    AND c.empresa = 'GDCA'
    AND state_policy = 1
  AND collective_number = 2003
    AND product_line_id = nvl(271, product_line_id)
        AND NOT EXISTS (SELECT   'x'
            FROM   ld_secure_cancella c, mo_packages s
            WHERE   p.policy_id = c.policy_id
            AND    c.secure_cancella_id = s.package_id
            AND    s.motive_status_id = 13);
