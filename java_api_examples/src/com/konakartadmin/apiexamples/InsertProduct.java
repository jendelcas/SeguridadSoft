//
// (c) 2004-2015 DS Data Systems UK Ltd, All rights reserved.
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
package com.konakartadmin.apiexamples;

import java.io.File;
import java.math.BigDecimal;
import java.util.Date;

import org.apache.http.HttpEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.entity.ContentType;
import org.apache.http.entity.mime.MultipartEntityBuilder;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.util.EntityUtils;

import com.konakart.util.KKConstants;
import com.konakart.util.Utils;
import com.konakartadmin.app.AdminCategory;
import com.konakartadmin.app.AdminImageOptions;
import com.konakartadmin.app.AdminProduct;
import com.konakartadmin.app.AdminProductAttribute;
import com.konakartadmin.app.AdminProductDescription;

/**
 * This class shows how to call the KonaKart Admin API to insert a product into the database. Before
 * running you may have to edit BaseApiExample.java to change the username and password used to log
 * into the engine. The default values are admin@konakart.com / princess .
 * <p>
 * It demonstrates two ways to add an Image to the product - one using the addImage API call and the
 * other using the FileUpload servlet.
 * <p>
 * 
 */
public class InsertProduct extends BaseApiExample
{
    private static final String usage = "Usage: InsertProduct\n" + COMMON_USAGE;

    private static final int IMG_DIR_DEPTH = 4;

    /**
     * @param args
     */
    public static void main(String[] args)
    {
        try
        {
            /*
             * Parse the command line arguments
             */
            parseArgs(args, usage, 0);

            /*
             * Get an instance of the Admin KonaKart engine and login. The method called can be
             * found in BaseApiExample.java
             */
            init(getEngineMode(), getStoreId(), getEngClassName(), isCustomersShared(),
                    isProductsShared(), isCategoriesShared(), null);

            /*
             * Instantiate an AdminProduct object and set some of its attributes
             */
            AdminProduct prod = new AdminProduct();
            // Assuming we have a manufacturer in the DB with id==1
            prod.setManufacturerId(1);

            // Image that will be used in the application for the product
            // Recommended way of adding images is to use addImage (see below)
            // prod.setImage("test/test.gif");

            // Product model
            prod.setModel("test model");
            // Product price before applying tax
            prod.setPriceExTax(new BigDecimal(55.99).setScale(2, BigDecimal.ROUND_HALF_UP));
            // Quantity of product in stock
            prod.setQuantity(20);
            // Product status: 1=active, 0=inactive
            prod.setStatus((byte) 1);
            // The tax class of the product. Used to determine how much tax to apply.
            prod.setTaxClassId(1);
            // Weight of product. Can be used to calculate shipping cost.
            prod.setWeight(new BigDecimal(5));
            // Defines when the product will be available
            prod.setDateAvailable(new Date());
            // Custom attribute. Can contain custom data.
            prod.setCustom1("custom1");
            // Custom attribute. Can contain custom data.
            prod.setCustom2("custom2");
            // Custom attribute. Can contain custom data.
            prod.setCustom3("custom3");
            // Custom attribute. Can contain custom data.
            prod.setCustom4("custom4");
            // Custom attribute. Can contain custom data.
            prod.setCustom5("custom5");

            // the Product UUID - this is used for creating the directory name for the images
            prod.setUuid(Utils.getUUID());

            /*
             * An Admin Product object has an array of AdminProductDescription objects, each one of
             * which contains a name, description and url for a different language. The url is
             * language dependent since it can point to the home page of the product for the country
             * in question.
             */
            AdminProductDescription[] descriptions = new AdminProductDescription[2];
            descriptions[0] = new AdminProductDescription();
            descriptions[0].setDescription("Test prod - English");
            descriptions[0].setLanguageId(1);
            descriptions[0].setName("Test Prod - E");
            descriptions[0].setUrl("www.testprod.co.uk");
            descriptions[0].setComparison("Comparison - English");
            descriptions[1] = new AdminProductDescription();
            descriptions[1].setDescription("Test prod - German");
            descriptions[1].setLanguageId(2);
            descriptions[1].setName("Test Prod - D");
            descriptions[1].setUrl("www.testprod.de");
            descriptions[1].setComparison("Comparison - German");
            prod.setDescriptions(descriptions);

            /*
             * An Admin Product may belong to one or more categories. We create an array of
             * categories and add one category to the array which we then add to the product.
             */
            AdminCategory cat = new AdminCategory();
            // Assuming we have a category with id==1 in the database
            cat.setId(1);
            AdminCategory[] catArray = new AdminCategory[1];
            catArray[0] = cat;
            prod.setCategories(catArray);

            /*
             * The following Admin Product Attributes are optional. They are used if the product has
             * options which can be selected to configure the product. These options may add or
             * subtract a value from the final price. i.e. Size "extra small" may be -$10.00 from
             * the product price while size "extra large" may be +$10.00.
             */

            // We will add two attributes
            AdminProductAttribute[] attrs = new AdminProductAttribute[2];

            // Attribute 1
            AdminProductAttribute prodAttr1 = new AdminProductAttribute();
            // This points to the option in the products_options table with id = 4 (Memory in demo
            // DB)
            prodAttr1.setOptionId(4);
            // This points to the option value in the products_options_values table with id = 1 (4MB
            // in demo DB)
            prodAttr1.setOptionValueId(1);
            // This option costs an extra 20 if selected
            prodAttr1.setPrice(new BigDecimal(20));
            prodAttr1.setPricePrefix("+");
            attrs[0] = prodAttr1;

            // Attribute 2
            AdminProductAttribute prodAttr2 = new AdminProductAttribute();
            // This points to the option in the products_options table with id = 3 (Model in demo
            // DB)
            prodAttr2.setOptionId(3);
            // This points to the option value in the products_options_values table with id = 5
            // (Value model
            // in demo DB)
            prodAttr2.setOptionValueId(5);
            // The product price is reduced by 10 if this option is selected
            prodAttr2.setPrice(new BigDecimal(10));
            prodAttr2.setPricePrefix("-");
            attrs[1] = prodAttr2;

            // Add the attributes to the product
            prod.setAttributes(attrs);

            // Insert the product and get the product Id
            int prodId = eng.insertProduct(sessionId, prod);

            System.out.println("Product Id of inserted product = " + prodId);

            // Now add an image - only supported in Business or Enterprise mode

            if (getEng().getEngConf().getEngineId().equals(KKConstants.MODE_ENTERPRISE)
                    || getEng().getEngConf().getEngineId().equals(KKConstants.MODE_BUSINESS))
            {
                // This first method uses the addImage API call to add the image

                String imgBasePath = getEng().getConfigurationByKey(sessionId, "IMG_BASE_PATH")
                        .getConfigurationValue();
                String newImgFilename = imgBasePath + "/konakart_tree_logo_60x60.jpg";
                File newImageFile = new File(newImgFilename);

                if (!newImageFile.exists())
                {
                    System.out.println("Couldn't add image because the image didn't exist : "
                            + newImgFilename);
                } else
                {
                    AdminImageOptions options = new AdminImageOptions();
                    options.setId(prodId);
                    options.setSourceFullFilename(newImageFile.getCanonicalPath());
                    options.setSubject(KKConstants.IMG_PRODUCT);

                    getEng().addImage(sessionId, options);
                }
            }

            if (getEng().getEngConf().getEngineId().equals(KKConstants.MODE_BUSINESS)
                    || getEng().getEngConf().getEngineId().equals(KKConstants.MODE_ENTERPRISE))
            {
                // This second method uses the FileUpload servlet to add the image

                String storeUrl = getEng().getConfigurationByKey(sessionId, "KK_BASE_URL")
                        .getConfigurationValue();
                String imgBasePath = getEng().getConfigurationByKey(sessionId, "IMG_BASE_PATH")
                        .getConfigurationValue();
                String adminUrl = storeUrl.replace("/konakart/", "");
                String fileUploadUrl = adminUrl
                        + getEng().getConfigurationByKey(sessionId, "IMG_SERVLET_URL")
                                .getConfigurationValue();

                // This is the value of the fbc.kk_panel_editProduct.images.options property in
                // konakartadmin_gwt.properties.
                String scaledCopiesStr = "big;360;360 medium;150;150 small;80;80 tiny;60;60";
                scaledCopiesStr.replaceAll(";", "%3B").replaceAll(",", "%2C");

                // This is the sub-directory under the images directory where the product images are
                // stored. It is the value of the fbc.kk_panel_editProduct.images.dir.name property
                // in konakartadmin_gwt.properties.
                String prodDir = "prod";

                int imageNum = 2;
                String imageSizeName = "UPLOADED";
                String imgPath = Utils.constructProductImageName(prod.getUuid(), imageNum,
                        imageSizeName, prodDir, IMG_DIR_DEPTH, "PNG");

                CloseableHttpClient httpclient = HttpClients.createDefault();
                try
                {
                    HttpPost httppost = new HttpPost(fileUploadUrl);

                    HttpEntity reqEntity = MultipartEntityBuilder.create()
                            .addPart("bin", new FileBody(new File(imgBasePath + "/red-circle.png")))
                            .addPart("imgBasePath",
                                    new StringBody(imgBasePath, ContentType.TEXT_PLAIN))
                            .addPart("imgPath", new StringBody(imgPath, ContentType.TEXT_PLAIN))
                            .addPart("sessionId",
                                    new StringBody(getSessionId(), ContentType.TEXT_PLAIN))
                            .addPart("scaledCopies",
                                    new StringBody(scaledCopiesStr, ContentType.TEXT_PLAIN))
                            .addPart("storeId",
                                    new StringBody(getStoreId(), ContentType.TEXT_PLAIN))
                            .addPart("engMode",
                                    new StringBody(String.valueOf(getEngineMode()),
                                            ContentType.TEXT_PLAIN))
                            .addPart("customersShared",
                                    new StringBody(String.valueOf(isCustomersShared()),
                                            ContentType.TEXT_PLAIN))
                            .addPart("productsShared",
                                    new StringBody(String.valueOf(isProductsShared()),
                                            ContentType.TEXT_PLAIN))
                            .addPart("categoriesShared",
                                    new StringBody(String.valueOf(isCategoriesShared()),
                                            ContentType.TEXT_PLAIN))
                            .addPart("allowOverwrite",
                                    new StringBody("true", ContentType.TEXT_PLAIN))
                            .addPart("returnStrOnSuccess",
                                    new StringBody("OK", ContentType.TEXT_PLAIN))
                            .build();

                    httppost.setEntity(reqEntity);

                    System.out.println("executing request " + httppost.getRequestLine());
                    CloseableHttpResponse response = httpclient.execute(httppost);
                    try
                    {
                        System.out.println("-------------------------------------------------\n");
                        System.out.println(response.getStatusLine());
                        HttpEntity resEntity = response.getEntity();
                        if (resEntity != null)
                        {
                            System.out.println(
                                    "Response content length: " + resEntity.getContentLength());
                            String responseString = EntityUtils.toString(resEntity, "UTF-8");
                            System.out.println("Response content:        " + responseString);
                        }
                        EntityUtils.consume(resEntity);
                        System.out.println("-------------------------------------------------");
                    } finally
                    {
                        response.close();
                    }
                } finally
                {
                    httpclient.close();
                }
            }

            prod = eng.getProduct(getSessionId(), prodId);

            if (prod != null)
            {
                /*
                 * Note that the name and description of the admin product object are set to null
                 * because they are in the AdminProductDescription array for each language. If the
                 * same product is read through the KonaKart application API, the name and
                 * description will be set to the values defined by the chosen language.
                 */
                System.out.println(prod.toString());

                // Remove the product just inserted
                System.out.println("Remove the product");
                eng.deleteProduct(sessionId, prodId);
            } else
            {
                System.out.println("The product could not be read from the DB");
            }

        } catch (Exception e)
        {
            e.printStackTrace();
        }
    }
}