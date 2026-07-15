select *
                      from open.GE_LIST_UNITARY_COST
                      where OPERATING_UNIT_ID is null
                        and contractor_id is null
                        and GEOGRAP_LOCATION_ID is null
                        --and  VALIDITY_START_DATE >='01/01/2024'
                        and  VALIDITY_FINAL_DATE >='01/06/2024'
                        and LIST_UNITARY_COST_ID != 1 for update 
