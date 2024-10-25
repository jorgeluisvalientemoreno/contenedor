SELECT pkg.package_id, 
       pkg.reception_type_id, 
       tipval.value,
       pkg.request_date
        FROM mo_packages pkg, ldc_tipvaldup tipval
       WHERE pkg.package_id = 213269190
         AND pkg.reception_type_id = tipval.reception_type_id
      
