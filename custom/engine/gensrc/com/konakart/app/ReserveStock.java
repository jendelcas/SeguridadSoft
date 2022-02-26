package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - ReserveStock - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class ReserveStock
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public ReserveStock(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public BasketIf[] reserveStock(String sessionId, BasketIf[] basketItems, StockReservationOptionsIf options) throws KKException
     {
         return kkEng.reserveStock(sessionId, basketItems, options);
     }
}
