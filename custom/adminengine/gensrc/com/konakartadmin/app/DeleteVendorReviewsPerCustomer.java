package com.konakartadmin.app;

import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - DeleteVendorReviewsPerCustomer - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class DeleteVendorReviewsPerCustomer
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public DeleteVendorReviewsPerCustomer(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void deleteVendorReviewsPerCustomer(String sessionId, int customerId) throws KKAdminException
     {
         kkAdminEng.deleteVendorReviewsPerCustomer(sessionId, customerId);
     }
}
