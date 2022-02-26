package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - GetVendorReview - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class GetVendorReview
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public GetVendorReview(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public AdminReview getVendorReview(String sessionId, int reviewId) throws KKAdminException
     {
         return kkAdminEng.getVendorReview(sessionId, reviewId);
     }
}
