begin
  -- Call the function
  :result := ld_bogassalevalue.fnugetsalevalueform(inucommplanid => :inucommplanid,
                                                   inucategoryid => :inucategoryid,
                                                   inusubcategoryid => :inusubcategoryid,
                                                   inuaddressid => :inuaddressid,
                                                   inucycleid => :inucycleid,
                                                   inupersonid => :inupersonid,
                                                   inupos_id => :inupos_id,
                                                   idtdate => :idtdate,
                                                   inuidenttype => :inuidenttype,
                                                   inuidentification => :inuidentification,
                                                   inusubscribertype => :inusubscribertype,
                                                   isbpromotionlist => :isbpromotionlist);
                                                  
  ROLLBACK; 
end;