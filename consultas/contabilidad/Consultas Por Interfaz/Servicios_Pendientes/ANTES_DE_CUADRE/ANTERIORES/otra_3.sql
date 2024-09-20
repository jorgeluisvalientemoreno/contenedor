SELECT *--distinct OR_order_activity.package_id package_id
 FROM open.OR_order_activity, open.or_order, open.mo_packages
WHERE OR_order_activity.package_id = 11617036
  and OR_order_activity.package_id =  mo_packages.package_id
  and OR_order_activity.order_id   =  OR_order.order_id
  and mo_packages.package_type_id  in (323, 100229) 
 -- and OR_order_activity.task_type_id in (12149, 12151, 12150, 12152, 12153)
  and or_order.created_date        >= '09-02-2015' and or_order.created_date < '01-03-2015'
--  and OR_order_activity.status     not in ('40', '45', '5', '26', '32') 
  and OR_order_activity.product_id is not null
  and OR_order_activity.order_activity_id not in (4000050, 4000051)
