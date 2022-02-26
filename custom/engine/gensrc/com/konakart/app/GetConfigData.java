package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - GetConfigData - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class GetConfigData
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public GetConfigData(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public ConfigDataIf[] getConfigData(String sessionId, String key) throws KKException
     {
         return kkEng.getConfigData(sessionId, key);
     }
}
