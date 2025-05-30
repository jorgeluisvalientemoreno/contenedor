SELECT a.*, a.rowid
  FROM open.MO_Bill_Data_Change a
 WHERE a.motive_id = 110413429;-- a.Package_Id = 226273986;
SELECT a.*, a.rowid
  FROM open.MO_MOTIVE a
 WHERE a.motive_id = 110413429;-- a.Package_Id = 226273986;
 
CURSOR CUPACKAGESBYSUBSCRIPTION(INUSUBSCRIPTIONID IN MO_MOTIVE.SUBSCRIPTION_ID%TYPE, ISBTAGNAME IN MO_PACKAGES.TAG_NAME%TYPE) IS
  SELECT /*+ INDEX (c IDX_MO_BILL_DATA_CHANGE_01)*/
   a.*, a.rowid
    FROM /*+ MO_BCBill_Data_Change.cuPackagesBySubscription */
         Mo_Bill_Data_Change c,
         Mo_Packages         a,
         Ps_Motive_Status    b
   WHERE /*c.New_Subscription = inuSubscriptionId
     AND c.Package_Id = a.Package_Id
     AND a.Tag_Name || '' = isbTagName
     AND */a.Motive_Status_Id = b.Motive_Status_Id
     AND b.Is_Final_Status = GE_BOConstants.csbNO
  
  UNION
  
  SELECT /*+ INDEX (a PK_MO_PACKAGES)
                     INDEX (b PK_PS_MOTIVE_STATUS) */
   a.*, a.rowid
    FROM Mo_Packages a, Ps_Motive_Status b
   WHERE a.Tag_Name = isbTagName
     AND a.Motive_Status_Id = b.Motive_Status_Id
     AND b.Is_Final_Status = GE_BOConstants.csbNO
     AND exists
   (SELECT /*+
                                       INDEX (d IDX_MO_MOTIVE_03)
                                       INDEX (e PK_PS_MOTIVE_STATUS)
                                      */
           'X'
            FROM mo_motive d, Ps_Motive_Status e
           WHERE d.subscription_id = inuSubscriptionId
             AND a.Package_Id = d.package_id
             AND d.Motive_Status_Id = e.Motive_Status_Id
             AND e.Is_Final_Status = GE_BOConstants.csbNO);
