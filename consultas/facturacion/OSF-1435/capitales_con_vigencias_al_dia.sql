
select vvfccons ,v.vvfcvafc "Variable",v.vvfcubge ||' -'|| initcap (description) "Capital" ,  v.vvfcvalo  "temperatura" , vvfcfeiv "fecha inicial" ,vvfcfefv "fecha_final_vigencia" , (select sysdate   from dual) "fecha_actual"
    from open.cm_vavafaco v, open.ge_geogra_location 
    where ge_geogra_location.geograp_location_id = v.vvfcubge
    and  v.vvfcvafc = 'TEMPERATURA'
    and v.vvfcubge in (( select capital from  ldc_capilocafaco)
    and v.vvfcfefv >= sysdate;