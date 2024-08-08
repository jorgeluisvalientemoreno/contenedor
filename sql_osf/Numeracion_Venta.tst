PL/SQL Developer Test script 3.0
44
-- Created on 23/02/2023 by JORGE VALIENTE 
declare

  nuPackageId    number;
  dtSysdate      date;
  sbNumForm      varchar2(100);
  nuFormType     number;
  sbVendido      varchar2(1);
  nuMotiveId     number;
  status_product number;
begin
  nuPackageId := 195398817; --MO_BOINSTANCE_DB.FNUGETPACKIDINSTANCE();
  dbms_output.put_line('Solicitud: ' || nuPackageId);

  dtSysdate := to_date('15/02/2023 09:25:00', 'DD/MM/YYYY HH24:MI:SS');
  dbms_output.put_line('Fecha Registro: ' || dtSysdate);

  sbNumForm := "OPEN".MO_BODATA.FSBGETVALUE('MO_PACKAGES',
                                            'DOCUMENT_KEY',
                                            nuPackageId);
  dbms_output.put_line('Numero Formulario: ' || sbNumForm);

  nuFormType := "OPEN".MO_BODATA.FNUGETVALUE('MO_PACKAGES',
                                             'DOCUMENT_TYPE_ID',
                                             nuPackageId);
  dbms_output.put_line('Tipo Formulario: ' || nuFormType);

  sbVendido := 'V';
  dbms_output.put_line('Vendido: ' || sbVendido);

  "OPEN".PKCONSECUTIVEMGR.CHANGESTSALEAUTHNUMBER(sbNumForm,nuFormType,sbVendido);
  /*nuMotiveId = MO_BOPACKAGES.FNUGETMOTIBYMOTITYPE(nuPackageId, 8, "Y", "N");
  MO_BOMOTPROMOTION.ASSIGNPROMOTION(nuMotiveId);nuproduct = MO_BOMOTIVE.FNUGETPRODUCTID(nuMotiveId);
  status_product = PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTSTATUS(nuproduct);
  if (status_product = 2
    ,
    MO_BOATTENTION.ATTENDCREATIONPRODBYPACKMASS(nuPackageId,60,status_product);
    LDCI_PKREVISIONPERIODICAWEB.PRSUSPPRODWITHOUTCERTIFICATE(nuproduct);
    ,
    MO_BOATTENTION.ATTENDCREATIONPRODBYPACKMASS(nuPackageId,60,PR_BOPARAMETER.FNUGETPRODACTI());
    )*/
    

end;
0
0
