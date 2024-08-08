begin
  -- Call the procedure
  ldci_pkservicioschatbot.prverficarsacrp(inususccodi => :inususccodi,
                                          isbcoment => :isbcoment,
                                          isbtelcel => :isbtelcel,
                                          inumediorecep => :inumediorecep,
                                          onupackage_id => :onupackage_id,
                                          onuorder_id => :onuorder_id,
                                          onuerrorcode => :onuerrorcode,
                                          osberrormessage => :osberrormessage);
end;