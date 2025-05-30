select dbms_metadata.get_ddl('PACKAGE',upper('AB_BCAddress')) FROM DUAL;
/*
    INICIO AB_BCAddress.GetChildAddress
    FIN AB_BCAddress.GetChildAddress
[GetAlternateAddressByAddress] INICIO
    [FillAddressAttributes] INICIO
[GetAlternateAddressByAddress] Fin
    Inicio: ab_boParser.CheckIfAddressExistsInDB(KR 4 CL 22 - 44)
    Busca la direccion antes de parsear
    Direccion ID antes de parsear [330343]
    Fin: ab_boParser.CheckIfAddressExistsInDB
*/
select a.*, rowid from OPEN.AB_ADDRESS a where a.address ='KR 4 CL 22 - 44';

            SELECT /*+ INDEX (ab_address IDX_AB_ADDRESS_013)*/
                   --count(1)---
                   AB_ADDRESS.*, ROWID
            FROM   /*+ AB_BCAddress.GetChildAddress */
                   AB_ADDRESS
            CONNECT BY PRIOR AB_ADDRESS.ADDRESS_ID = AB_ADDRESS.FATHER_ADDRESS_ID
            START WITH AB_ADDRESS.Geograp_Location_Id = 7.FATHER_ADDRESS_ID = 7979-- INUFATHERID; --781199
