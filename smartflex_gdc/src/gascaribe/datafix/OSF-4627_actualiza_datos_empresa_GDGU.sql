DECLARE

BEGIN

UPDATE EMPRESA SET NOMBRE =  'GASES DE LA GUAJIRA S.A. E.S.P' ,
                   DIRECCION =  'Riohacha, Carrera 15 No.14C-33',
                   RESP_FISCAL_EMISOR =  'O-13;O-15',
                   DEPARTAMENTO =  8978,
                   LOCALIDAD =  9265,
                   MATRICULA_MERCANTIL =  '5174',
                   COD_TRIBUTO_EMISOR =  '01',
                   NOMBRE_TRIBUTO_EMISOR =  'IVA',
                   EMAIL_EMISOR =  'recibofacturas@gasguajira.com',
                   TELEFONO_EMISOR =  '6057270300',
                   FAX_EMISOR =  '6057270300',
                   RAZON_SOCIAL_EMISOR =  'GASES DE LA GUAJIRA S.A. EMPRESA DE SERVICIO PUBLICO. GASGUAJIRA S.A. E.S.P',
                   DIRECCION_EMISOR =  'CR 15 14 C 33'
WHERE CODIGO = 'GDGU';

COMMIT;

END;
/