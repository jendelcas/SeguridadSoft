package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - PublishProducts - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class PublishProducts
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public PublishProducts(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

      @Deprecated
     public void publishProducts(String sessionId, AdminPublishConfig adminPublishConfig) throws KKAdminException
     {
         kkAdminEng.publishProducts(sessionId, adminPublishConfig);
     }
}
