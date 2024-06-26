SELECT (select 'Ubicacion Geografica: ' || a.geograp_location_id ||
               ' - Codigo: ' || ab.address_id || ' - Direccion:' ||
               a.address
          from ab_address a
         where ab.address_id = a.address_id) address,
       count(1)
  FROM fm_possible_ntl ab
 WHERE status in ('P', 'R')
 group by ab.address_id;

--210 - KR GENERICA CL GENERICA - 0

SELECT possible_ntl_id
  FROM fm_possible_ntl
 WHERE address_id = inuAddressId
   AND product_type_id = inuProductType
   AND status in (fm_boconstants.csbPendingNTLStatus,
                  fm_boconstants.csbProjectNTLStatus)
   AND rownum = 1;
