/*
*  Copyright (c) 2017, WSO2 Inc. (http://www.wso2.org) All Rights Reserved.
*
*  WSO2 Inc. licenses this file to you under the Apache License,
*  Version 2.0 (the "License"); you may not use this file except
*  in compliance with the License.
*  You may obtain a copy of the License at
*
*  http://www.apache.org/licenses/LICENSE-2.0
*
*  Unless required by applicable law or agreed to in writing,
*  software distributed under the License is distributed on an
*  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
*  KIND, either express or implied.  See the License for the
*  specific language governing permissions and limitations
*  under the License.
*/
package org.ballerinalang.test.service.http.sample;

import org.ballerinalang.test.IntegrationTestCase;
import org.ballerinalang.test.context.ServerInstance;
import org.ballerinalang.test.util.HttpClientRequest;
import org.ballerinalang.test.util.HttpResponse;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * Testing the HTTP server connection I/O operations.
 */
public class ServerConnectorIOTestCase extends IntegrationTestCase {
    private ServerInstance ballerinaServer;

    @BeforeClass
    private void setup() throws Exception {
        ballerinaServer = ServerInstance.initBallerinaServer();
        String relativePath = new File("src" + File.separator + "test" + File.separator + "resources"
                + File.separator + "httpService" + File.separator + "serverIoTest.bal").getAbsolutePath();
        ballerinaServer.startBallerinaServer(relativePath);
    }

    @Test(description = "test declaration of two response method. Error is shown in the console")
    public void testMultipleRespond() throws Exception {
        Map<String, String> headers = new HashMap<>();
        String serviceUrl = "http://localhost:9090/sample/echo";
        HttpResponse response = HttpClientRequest.doOptions(serviceUrl, headers);
        Assert.assertNotNull(response);
        Assert.assertEquals(response.getResponseCode(), 200, "Response code mismatched");
        String respMsg = "wso2";
        Assert.assertEquals(response.getData(), respMsg, "Message content mismatched");
    }

    @AfterClass
    private void cleanup() throws Exception {
        ballerinaServer.stopServer();
    }
}
