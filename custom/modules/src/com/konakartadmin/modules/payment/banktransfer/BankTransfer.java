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

package com.konakartadmin.modules.payment.banktransfer;

import java.util.Date;

import com.konakart.util.Utils;
import com.konakartadmin.app.KKConfiguration;
import com.konakartadmin.bl.KKAdminBase;
import com.konakartadmin.modules.PaymentModule;

/**
 * Bank Transfer payment module
 * 
 */
public class BankTransfer extends PaymentModule
{
    /**
     * @return the config key stub
     */
    public String getConfigKeyStub()
    {
        if (configKeyStub == null)
        {
            setConfigKeyStub(super.getConfigKeyStub() + "_BANK_TRANSFER");
        }
        return configKeyStub;
    }

    public String getModuleTitle()
    {
        return getMsgs().getString("MODULE_PAYMENT_BANK_TRANSFER_TEXT_TITLE");
    }

    /**
     * @return the implementation filename
     */
    public String getImplementationFileName()
    {
        return "BankTransfer";
    }

    /**
     * @return the module code
     */
    public String getModuleCode()
    {
        return com.konakart.bl.modules.payment.banktransfer.BankTransfer.code;
    }

    /**
     * @return an array of configuration values for this payment module
     */
    public KKConfiguration[] getConfigs()
    {
        if (configs == null)
        {
            configs = new KKConfiguration[8];
        }

        if (configs[0] != null && !Utils.isBlank(configs[0].getConfigurationKey()))
        {
            return configs;
        }

        Date now = KKAdminBase.getKonakartTimeStampDate();

        int i = 0;
        int groupId = 6;
        
        configs[i] = new KKConfiguration(
                /* title */"Enable Bank Transfer Module",
                /* key */"MODULE_PAYMENT_BANK_TRANSFER_STATUS", 
                /* value */"true",
                /* description */"Do you want to accept Bank Transfer payments?", 
                /* groupId */groupId, 
                /* sortO */i++, 
                /* useFun */"",
                /* setFun */"choice('true'='true','false'='false')", 
                /* dateAdd */now);
       
        configs[i] = new KKConfiguration(
                /* title */"Sort order of display",
                /* key */"MODULE_PAYMENT_BANK_TRANSFER_SORT_ORDER", 
                /* value */"0",
                /* description */"Sort order of display. Lowest is displayed first.", 
                /* groupId */groupId, 
                /* sortO */i++, 
                /* useFun */"", 
                /* setFun */"", 
                /* dateAdd */now);

        configs[i] = new KKConfiguration(
                /* title */"Payment Zone", 
                /* key */"MODULE_PAYMENT_BANK_TRANSFER_ZONE", 
                /* value */"0",
                /* description */"If a zone is selected, only enable this payment method for that zone.", 
                /* groupId */groupId, 
                /* sortO */i++,
                /* useFun */"tep_get_zone_class_title", 
                /* setFun */"tep_cfg_pull_down_zone_classes(", 
                /* dateAdd */now);
        
        configs[i] = new KKConfiguration(
                /* title */"Set Order Status",
                /* key */"MODULE_PAYMENT_BANK_TRANSFER_ORDER_STATUS_ID", 
                /* value */"4",
                /* description */"Set the status of orders made with this payment module to this value", 
                /* groupId */groupId,
                /* sortO */i++,
                /* useFun */"tep_get_order_status_name", 
                /* setFun */"OrderStatuses", 
                /* dateAdd */now);
        
        
        configs[i++] = new KKConfiguration(
        /* title */"IBAN for Bank Transfer",
        /* key */"MODULE_PAYMENT_BANK_TRANSFER_IBAN",
        /* value */"",
        /* description */"The IBAN for the bank transfer",
        /* groupId */groupId,
        /* sort Order */i,
        /* useFun */"",
        /* setFun */"",
        /* dateAdd */now);       
        
        configs[i++] = new KKConfiguration(
        /* title */"Template for Reference",
        /* key */"MODULE_PAYMENT_BANK_TRANSFER_REFERENCE_TEMPLATE",
        /* value */"$orderId-$name",
        /* description */"The template for creating the reference string. Placeholders: $orderId, $orderNum, $name",
        /* groupId */groupId,
        /* sort Order */i,
        /* useFun */"",
        /* setFun */"",
        /* dateAdd */now);       
        
        configs[i++] = new KKConfiguration(
        /* title */"Update Inventory",
        /* key */"MODULE_PAYMENT_BANK_TRANSFER_UPDATE_INVENTORY",
        /* value */"false",
        /* description */"If set to true, the inventory update will be performed as soon as the order is confirmed",
        /* groupId */groupId,
        /* sort Order */i,
        /* useFun */"",
        /* setFun */"choice('true'='true','false'='false')",
        /* dateAdd */now);
        
        configs[i++] = new KKConfiguration(
        /* title */"Send Email",
        /* key */"MODULE_PAYMENT_BANK_TRANSFER_SEND_EMAIL",
        /* value */"false",
        /* description */"If set to true, an email will be sent as soon as the order is confirmed",
        /* groupId */groupId,
        /* sort Order */i,
        /* useFun */"",
        /* setFun */"choice('true'='true','false'='false')",
        /* dateAdd */now);
                
        return configs;
    }
}
