//
// (c) 2018 DS Data Systems UK Ltd, All rights reserved.
//
// DS Data Systems and KonaKart and their respective logos, are 
// trademarks of DS Data Systems UK Ltd. All rights reserved.
//
// The information in this document is free software; you can redistribute 
// it and/or modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//

package com.konakartadmin.modules.payment.customercard;

import java.util.Date;

import com.konakart.util.Utils;
import com.konakartadmin.app.KKConfiguration;
import com.konakartadmin.bl.KKAdminBase;
import com.konakartadmin.modules.PaymentModule;

/**
 * Customer Card payment module
 * 
 */
public class CustomerCard extends PaymentModule
{
    /**
     * @return the config key stub
     */
    public String getConfigKeyStub()
    {
        if (configKeyStub == null)
        {
            setConfigKeyStub(super.getConfigKeyStub() + "_CUSTOMER_CARD");
        }
        return configKeyStub;
    }

    public String getModuleTitle()
    {
        return getMsgs().getString("MODULE_PAYMENT_CUSTOMER_CARD_TEXT_TITLE");
    }

    /**
     * @return the implementation filename
     */
    public String getImplementationFileName()
    {
        return "CustomerCard";
    }

    /**
     * @return the module code
     */
    public String getModuleCode()
    {
        return "customercard";
    }

    /**
     * @return an array of configuration values for this payment module
     */
    public KKConfiguration[] getConfigs()
    {
        if (configs == null)
        {
            configs = new KKConfiguration[4];
        }

        if (configs[0] != null && !Utils.isBlank(configs[0].getConfigurationKey()))
        {
            return configs;
        }

        Date now = KKAdminBase.getKonakartTimeStampDate();

        int i = 0;
        int groupId = 6;
        
        configs[i] = new KKConfiguration(
                /* title */"Enable Customer Card Module",
                /* key */"MODULE_PAYMENT_CUSTOMER_CARD_STATUS", 
                /* value */"true",
                /* description */"Do you want to accept Customer Card payments?", 
                /* groupId */groupId, 
                /* sortO */i++, 
                /* useFun */"",
                /* setFun */"choice('true'='true','false'='false')", 
                /* dateAdd */now);
       
        configs[i] = new KKConfiguration(
                /* title */"Sort order of display",
                /* key */"MODULE_PAYMENT_CUSTOMER_CARD_SORT_ORDER", 
                /* value */"0",
                /* description */"Sort order of display. Lowest is displayed first.", 
                /* groupId */groupId, 
                /* sortO */i++, 
                /* useFun */"", 
                /* setFun */"", 
                /* dateAdd */now);

        configs[i] = new KKConfiguration(
                /* title */"Payment Zone", 
                /* key */"MODULE_PAYMENT_CUSTOMER_CARD_ZONE", 
                /* value */"0",
                /* description */"If a zone is selected, only enable this payment method for that zone.", 
                /* groupId */groupId, 
                /* sortO */i++,
                /* useFun */"tep_get_zone_class_title", 
                /* setFun */"tep_cfg_pull_down_zone_classes(", 
                /* dateAdd */now);
        
        configs[i] = new KKConfiguration(
                /* title */"Set Order Status",
                /* key */"MODULE_PAYMENT_CUSTOMER_CARD_ORDER_STATUS_ID", 
                /* value */"0",
                /* description */"Set the status of orders made with this payment module to this value", 
                /* groupId */groupId,
                /* sortO */i++,
                /* useFun */"tep_get_order_status_name", 
                /* setFun */"OrderStatuses", 
                /* dateAdd */now);
        
        return configs;
    }
}
