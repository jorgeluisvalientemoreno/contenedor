--Variable de Presión por localidad y usuario
select a.*, rowid from OPEN.CM_VAVAFACO a;
--Presión Calculada por usuario 
--Si necesitas saber la presión que calculo al final al funcional por periodo se debe usar CM_FACOCOSS
select a.*, rowid from OPEN.CM_FACOCOSS a;
