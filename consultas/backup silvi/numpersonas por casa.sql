select t.*  ,PERSON_QUANTITY from GE_SUBS_HOUSING_DATA  h ,GE_HOUSE_TYPE t
where h.house_type_id = t.HOUSE_TYPE_ID
