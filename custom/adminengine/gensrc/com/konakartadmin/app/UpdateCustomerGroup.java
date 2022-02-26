package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - UpdateCustomerGroup - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class UpdateCustomerGroup
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public UpdateCustomerGroup(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public int updateCustomerGroup(String sessionId, AdminCustomerGroup custGroup) throws KKAdminException
     {
         return kkAdminEng.updateCustomerGroup(sessionId, custGroup);
     }
}