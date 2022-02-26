package com.konakartadmin.app;

import java.util.Calendar;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - SetProductAvailability - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class SetProductAvailability
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public SetProductAvailability(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public void setProductAvailability(String sessionId, String sku, int id, Calendar dateAvailable) throws KKAdminException
     {
         kkAdminEng.setProductAvailability(sessionId, sku, id, dateAvailable);
     }
}
