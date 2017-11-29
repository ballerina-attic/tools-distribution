package org.ballerinalang.test.service.http.sample;

import org.ballerinalang.test.context.ServerInstance;
import org.ballerinalang.test.util.HttpClientRequest;
import org.ballerinalang.test.util.HttpResponse;
import org.ballerinalang.test.util.TestConstant;
import org.testng.Assert;
import org.testng.annotations.AfterClass;
import org.testng.annotations.BeforeClass;
import org.testng.annotations.Test;

import java.io.File;
import java.util.HashMap;
import java.util.Map;

/**
 * Test class for HTTP options request's content length and payload handling behavior.
 */
public class HTTPOptionsTestCase {
    private ServerInstance ballerinaServer;

    @BeforeClass
    private void setup() throws Exception {
        ballerinaServer = ServerInstance.initBallerinaServer();
        String relativePath = new File("src" + File.separator + "test" + File.separator + "resources"
                + File.separator + "httpService" + File.separator + "httpEchoService.bal").getAbsolutePath();
        ballerinaServer.startBallerinaServer(relativePath);
    }

    @Test(description = "Test OPTIONS content length header sample test case")
    public void testOptionsContentLengthHeader() throws Exception {
        Map<String, String> headers = new HashMap<>();
        headers.put(TestConstant.HEADER_CONTENT_TYPE, TestConstant.CONTENT_TYPE_JSON);
        String serviceUrl = "http://localhost:9090/echoDummy";
        HttpResponse response = HttpClientRequest.doOptions(serviceUrl, headers);
        Assert.assertNotNull(response);
        Assert.assertEquals(response.getResponseCode(), 200, "Response code mismatched");
        Assert.assertEquals(response.getHeaders().get(TestConstant.CONTENT_LENGTH)
                , "0", "Content-Length mismatched");
        Assert.assertEquals(response.getHeaders().get(TestConstant.ALLOW)
                , "POST, OPTIONS", "Content-Length mismatched");
    }

    @Test(description = "Test OPTIONS content length header sample test case")
    public void testOptionsResourceWithPayload() throws Exception {
        Map<String, String> headers = new HashMap<>();
        headers.put(TestConstant.HEADER_CONTENT_TYPE, TestConstant.CONTENT_TYPE_JSON);
        String serviceUrl = "http://localhost:9090/echoDummy/getOptions";
        HttpResponse response = HttpClientRequest.doOptions(serviceUrl, headers);
        Assert.assertNotNull(response);
        Assert.assertEquals(response.getResponseCode(), 200, "Response code mismatched");
        Assert.assertEquals(response.getHeaders().get(TestConstant.CONTENT_LENGTH)
                , String.valueOf(response.getData().length()), "Content-Length mismatched");
        Assert.assertEquals(response.getHeaders().get(TestConstant.HEADER_CONTENT_TYPE)
                , TestConstant.CONTENT_TYPE_TEXT_PLAIN, "Content-Type mismatched");
        String respMsg = "hello Options";
        Assert.assertEquals(response.getData(), respMsg, "Message content mismatched");
    }

    @AfterClass
    private void cleanup() throws Exception {
        ballerinaServer.stopServer();
    }
}
