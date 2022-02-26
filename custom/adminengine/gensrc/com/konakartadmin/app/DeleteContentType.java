package com.konakartadmin.app;

import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - DeleteContentType - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class DeleteContentType
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public DeleteContentType(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void deleteContentType(String sessionId, int contentTypeId) throws KKAdminException
     {
         kkAdminEng.deleteContentType(sessionId, contentTypeId);
     }
}