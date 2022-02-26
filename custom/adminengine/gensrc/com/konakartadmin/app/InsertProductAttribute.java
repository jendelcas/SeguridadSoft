package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - InsertProductAttribute - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class InsertProductAttribute
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public InsertProductAttribute(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public int insertProductAttribute(String sessionId, AdminProductAttribute prodAttr) throws KKAdminException
     {
         return kkAdminEng.insertProductAttribute(sessionId, prodAttr);
     }
}
