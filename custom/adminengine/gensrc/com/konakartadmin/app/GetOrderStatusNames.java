package com.konakartadmin.app;

import com.konakartadmin.appif.*;
import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - GetOrderStatusNames - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class GetOrderStatusNames
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public GetOrderStatusNames(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public AdminOrderStatusNameSearchResult getOrderStatusNames(AdminOrderStatusNameSearch search) throws KKAdminException
     {
         return kkAdminEng.getOrderStatusNames(search);
     }
}
