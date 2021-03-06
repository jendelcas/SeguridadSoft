package com.konakart.app;

import com.konakart.appif.*;

/**
 *  The KonaKart Custom Engine - GetSuggestions - Generated by CreateKKCustomEng
 */
@SuppressWarnings("all")
public class GetSuggestions
{
    KKEng kkEng = null;

    /**
     * Constructor
     */
     public GetSuggestions(KKEng _kkEng)
     {
         kkEng = _kkEng;
     }

     public SuggestionIf[] getSuggestions(String sessionId, SuggestionIf suggestion, DataDescriptorIf dataDesc) throws KKException
     {
         return kkEng.getSuggestions(sessionId, suggestion, dataDesc);
     }
}
