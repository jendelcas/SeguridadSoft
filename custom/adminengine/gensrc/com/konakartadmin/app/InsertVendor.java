package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - InsertVendor - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class InsertVendor
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public InsertVendor(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public int insertVendor(String sessionId, AdminVendor vendor) throws KKAdminException
     {
         return kkAdminEng.insertVendor(sessionId, vendor);
     }
}
