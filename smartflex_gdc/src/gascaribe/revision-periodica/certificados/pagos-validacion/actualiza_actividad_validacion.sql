begin
   UPDATE LDC_RESUINSP SET ACTIVIDAD_VALIDACION=100009515 WHERE CODIGO=1;
   UPDATE LDC_RESUINSP SET ACTIVIDAD_VALIDACION=100009515 WHERE CODIGO=2;
   UPDATE LDC_RESUINSP SET ACTIVIDAD_VALIDACION=100009516 WHERE CODIGO=3;
   UPDATE LDC_RESUINSP SET ACTIVIDAD_VALIDACION=100009515 WHERE CODIGO=4;
   UPDATE LDC_RESUINSP SET ACTIVIDAD_VALIDACION=100009516 WHERE CODIGO=5;
   COMMIT;
end;
/