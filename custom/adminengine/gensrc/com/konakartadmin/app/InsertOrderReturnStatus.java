package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - InsertOrderReturnStatus - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class InsertOrderReturnStatus
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public InsertOrderReturnStatus(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public int insertOrderReturnStatus(String sessionId, AdminOrderReturnStatus status) throws KKAdminException
     {
         return kkAdminEng.insertOrderReturnStatus(sessionId, status);
     }
}
