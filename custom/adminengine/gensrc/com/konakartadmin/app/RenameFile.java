package com.konakartadmin.app;

import com.konakartadmin.bl.KKAdmin;

/**
 *  The KonaKart Custom Engine - RenameFile - Generated by CreateKKAdminCustomEng
 */
@SuppressWarnings("all")
public class RenameFile
{
    KKAdmin kkAdminEng = null;

    /**
     * Constructor
     */
     public RenameFile(KKAdmin _kkAdminEng)
     {
         kkAdminEng = _kkAdminEng;
     }

     public boolean renameFile(String sessionId, String srcFileName, String dstFileName) throws KKAdminException
     {
         return kkAdminEng.renameFile(sessionId, srcFileName, dstFileName);
     }
}