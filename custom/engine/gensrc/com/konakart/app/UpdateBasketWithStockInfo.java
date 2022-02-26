package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - UpdateBasketWithStockInfo - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class UpdateBasketWithStockInfo
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public UpdateBasketWithStockInfo(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public BasketIf[] updateBasketWithStockInfo(BasketIf[] basketItems) throws KKException
     {
         return kkEng.updateBasketWithStockInfo(basketItems);
     }
}
