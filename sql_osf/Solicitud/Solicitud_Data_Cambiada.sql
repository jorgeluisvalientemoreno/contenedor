SELECT a.*, a.rowid
  FROM open.MO_Bill_Data_Change a
 WHERE 1 = 1
   and a.motive_id = 110413429;

SELECT /*+ INDEX (c IDX_MO_BILL_DATA_CHANGE_01)*/
 a.*, a.rowid
  FROM /*+ MO_BCBill_Data_Change.cuPackagesBySubscription */
       open.Mo_Bill_Data_Change c,
       open.Mo_Packages         a,
       open.Ps_Motive_Status    b
 WHERE /*c.New_Subscription = inuSubscriptionId
AND c.Package_Id = a.Package_Id
AND a.Tag_Name || '' = isbTagName
AND */
 a.Motive_Status_Id = b.Motive_Status_Id
 AND b.Is_Final_Status = 'N' --GE_BOConstants.csbNO
UNION
SELECT /*+ INDEX (a PK_MO_PACKAGES)
INDEX (b PK_PS_MOTIVE_STATUS) */
 a.*, a.rowid
  FROM open.Mo_Packages a, open.Ps_Motive_Status b
 WHERE 1 = 1
   --and a.Tag_Name = isbTagName
   AND a.Motive_Status_Id = b.Motive_Status_Id
   AND b.Is_Final_Status = 'N' --GE_BOConstants.csbNO
   AND exists (SELECT /*+
        INDEX (d IDX_MO_MOTIVE_03)
        INDEX (e PK_PS_MOTIVE_STATUS)
        */
         'X'
          FROM open.mo_motive d, open.Ps_Motive_Status e
         WHERE 1 = 1
           --and d.subscription_id = inuSubscriptionId
           AND a.Package_Id = d.package_id
           AND d.Motive_Status_Id = e.Motive_Status_Id
           AND e.Is_Final_Status = 'N'--GE_BOConstants.csbNO
           );
