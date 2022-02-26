//
// (c) 2017 DS Data Systems UK Ltd, All rights reserved.
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

package com.konakart.actions;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.konakart.al.KKAppEng;

/**
 * It receives a review rating to show only reviews with that rating
 */
public class FilterVendorReviewAction extends BaseAction
{
    private static final long serialVersionUID = 1L;

    public String execute()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();

        try
        {
            int custId;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            custId = this.loggedIn(request, response, kkAppEng, null);

            // Force the user to login if configured to do so
            if (custId < 0 && kkAppEng.isForceLogin())
            {
                return KKLOGIN;
            }

            // Ensure we are using the correct protocol. Redirect if not.
            String redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
            if (redirForward != null)
            {
                setupResponseForSSLRedirect(response, redirForward);
                return null;
            }

            String ratingStr = request.getParameter("rating");
            if (ratingStr == null)
            {
                return WELCOME;
            }

            if (log.isDebugEnabled())
            {
                log.debug("Rating from application = " + ratingStr);
            }

            int rating = -1;
            try
            {
                rating = Integer.parseInt(ratingStr);
            } catch (Exception e)
            {
                return WELCOME;
            }

            // The timestamp which connects the navigation links to a result set
            String timestampStr = request.getParameter("t");
            long timestamp = 0;
            try
            {
                timestamp = Long.parseLong(timestampStr);
            } catch (Exception e)
            {
            }

            kkAppEng.getReviewMgr().filterCurrentVendorReviews(rating, timestamp);
            if (kkAppEng.getReviewMgr().isExpiredResultSet())
            {
                return WELCOME;
            }
            kkAppEng.getReviewMgr().setShowTab(true);

            return SUCCESS;

        } catch (Exception e)
        {
            return super.handleException(request, e);
        }

    }

}
