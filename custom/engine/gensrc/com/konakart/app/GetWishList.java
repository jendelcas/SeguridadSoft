package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - GetWishList - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class GetWishList
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public GetWishList(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public WishListIf getWishList(String sessionId, int wishListId) throws KKException
     {
         return kkEng.getWishList(sessionId, wishListId);
     }
}
