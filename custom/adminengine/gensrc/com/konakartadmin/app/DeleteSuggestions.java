package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - DeleteSuggestions - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class DeleteSuggestions
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public DeleteSuggestions(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void deleteSuggestions(String sessionId, AdminSuggestion suggestion) throws KKAdminException
     {
         kkAdminEng.deleteSuggestions(sessionId, suggestion);
     }
}
