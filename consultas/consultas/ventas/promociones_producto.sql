SELECT *
  FROM PR_PROMOTION, 
  CC_PROMOTION, 
  SERVICIO, 
  PR_COMPONENT, 
  PS_COMPONENT_TYPE, 
  PS_CLASS_SERVICE /*+ cc_boOssPromotion.GetPromotion */
   WHERE pr_promotion.promotion_id = :inuPromotion   
     AND pr_promotion.asso_promotion_id = cc_promotion.promotion_id   
     AND cc_promotion.product_type_id = servicio.servcodi   
     AND pr_promotion.component_id = pr_component.component_id (+)  
     AND pr_component.component_type_id = ps_component_type.component_type_id (+) 
     AND pr_component.class_service_id = ps_class_service.class_service_id (+) ;
     
     
 SELECT *
 FROM PR_PROMOTION, CC_PROMOTION, SERVICIO, PR_COMPONENT, PS_COMPONENT_TYPE, PS_CLASS_SERVICE /*+ cc_boOssProduct.GetPromotions */
WHERE pr_promotion.PRODUCT_ID = :inuProduct
AND  pr_promotion.ASSO_PROMOTION_ID = cc_promotion.PROMOTION_ID
AND  pr_promotion.COMPONENT_ID = pr_component.COMPONENT_ID (+)
AND  cc_promotion.PRODUCT_TYPE_ID = servicio.SERVCODI
AND  pr_component.COMPONENT_TYPE_ID = ps_component_type.COMPONENT_TYPE_ID (+)
AND  pr_component.CLASS_SERVICE_ID = ps_class_service.CLASS_SERVICE_ID (+) ;    