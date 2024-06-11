DECLARE
  nuError         NUMBER;
  sbError         VARCHAR2(2000);
  oclPackage      CLOB;
  onuErrorCode    NUMBER;
  osbErrorMessage VARCHAR2(2000);
BEGIN
  GE_BODAOPackageGenerator.DataAccessPackageBuilder('LDC_INFO_PREDIO', -- isbTableName in varchar2,
                                                    1, -- inuSaoCode in number
                                                    '/smartfiles/tmp', -- Ruta con permisos
                                                    oclPackage,
                                                    onuErrorCode,
                                                    osbErrorMessage);

END;
