SELECT ab_address.address_id address_id,
       ab_address.geograp_location_id || ' - ' ||
       dage_geogra_location.fsbGetDescription(ab_address.geograp_location_id) geograp_location_id,
       decode(null,
              ab_address.neighborthood_id,
              null,
              ab_address.neighborthood_id || ' - ' ||
              dage_geogra_location.fsbGetDescription(ab_address.neighborthood_id,
                                                     0)) neighborthood_id,
       ab_address.address address,
       ab_address.address_parsed address_parsed,
       ab_address.cadastral_id cadastral_id,
       ab_address.estate_number estate_number,
       decode('Y', ab_address.is_main, 'Si', 'No') is_main,
       decode('Y', ab_address.is_urban, 'Si', 'No') is_urban,
       daab_address.fsbGetAddress_Parsed(ab_address.father_address_id, 0) father_address_id,
       ab_address.address_complement address_complement,
       ab_address.house_number house_number,
       ab_address.house_letter house_letter,
       ab_address.segment_id segment_id,
       decode(null,
              ab_address.way_type,
              null,
              ab_address.way_type || ' - ' ||
              daab_way_type.fsbGetDescription(ab_address.way_type, 0)) way_type,
       decode(null,
              ab_address.cross_way_type,
              null,
              ab_address.cross_way_type || ' - ' ||
              daab_way_type.fsbGetDescription(ab_address.cross_way_type, 0)) cross_way_type,
       decode('Y', ab_address.is_valid, 'Si', 'No') is_valid,
       decode('Y', ab_address.verified, 'Si', 'No') verified
--, :parent_id parent_id
  FROM open.AB_Address
 WHERE 1 = 1 /*and -1 = :geograp_location_id
              AND -1 = :neighborthood_id
              AND '-1' = :cadastral_id
              AND -1 = :address_id*/
   AND address_parsed like 'CL 7 KR 9 - 39' || '%'
