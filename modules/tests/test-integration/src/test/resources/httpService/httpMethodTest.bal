import ballerina.net.http;

@http:configuration {basePath:"/headQuote"}
service<http> headQuoteService {

    endpoint<http:HttpClient> endPoint {
        create http:HttpClient("http://localhost:9090", {});
    }

    @http:resourceConfig {
        path:"/default"
    }
    resource defaultResource (http:Request req, http:Response resp) {

        string method = req.getMethod();
        http:Response clientResponse;
        clientResponse, _ = endPoint.execute(method, "/getQuote/stocks", req);
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/testPost"
    }
    resource res11 (http:Request req, http:Response resp) {
        endpoint<http:HttpClient> endPoint {}
        http:Options conOptions = {
            enableChunking:false
        };
        endPoint =  create http:HttpClient("http://localhost:9090", conOptions);
        http:Response clientResponse;
        clientResponse, _ = endPoint.post("/getQuote/testLength", {});
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["GET"],
        path:"/testPATCH"
    }
    resource res22 (http:Request req, http:Response resp) {
        http:Response clientResponse;
        clientResponse, _ = endPoint.patch("/getQuote/stocks", {});
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        path:"/forward11"
    }
    resource forwardRes11 (http:Request req, http:Response resp) {
        http:Response clientResponse;
        clientResponse, _ = endPoint.forward("/getQuote/stocks", req);
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        path:"/forward22"
    }
    resource forwardRes22 (http:Request req, http:Response resp) {
        http:Response clientResponse;
        clientResponse, _ = endPoint.forward("/getQuote/stocks", req);
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        path:"/getStock/{method}"
    }
    resource commonResource (http:Request req, http:Response resp, string method) {
        http:Response clientResponse;
        clientResponse, _ = endPoint.execute(method, "/getQuote/stocks", req);
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        methods:["PATCH"]
    }
    resource testPatch (http:Request req, http:Response resp) {
        resp.setJsonPayload({"hello":"wso2"});
        resp.setStatusCode(204);
        _ = resp.send();
    }
}

@http:configuration {basePath:"/sampleHead"}
service<http> testClientConHEAD {

    @http:resourceConfig {
        methods:["HEAD"],
        path:"/"
    }
    resource passthrough (http:Request req, http:Response resp) {
        endpoint<http:HttpClient> quoteEP {
            create http:HttpClient("http://localhost:9090", {});
        }
        http:Response clientResponse;
        clientResponse, _ = quoteEP.get("/getQuote/stocks", req);
        _ = resp.forward(clientResponse);
    }
}

@http:configuration {basePath:"/getQuote"}
service<http> quoteService {

    @http:resourceConfig {
        methods:["GET"],
        path:"/stocks"
    }
    resource company (http:Request req, http:Response res) {
        res.setStringPayload("wso2");
        _ = res.send();
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/stocks"
    }
    resource product (http:Request req, http:Response res) {
        res.setStringPayload("ballerina");
        _ = res.send();
    }

    @http:resourceConfig {
        methods:["PATCH"],
        path:"/stocks"
    }
    resource product11 (http:Request req, http:Response res) {
        res.setStringPayload("dispatched to patch");
        _ = res.send();
    }

    @http:resourceConfig {
        path:"/stocks"
    }
    resource defaultStock (http:Request req, http:Response res) {
        res.setHeader("Method", "any");
        res.setStringPayload("default");
        _ = res.send();
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/testLength"
    }
    resource product22 (http:Request req, http:Response res) {
        int length = req.getContentLength();
        res.setStringPayload(<string>length);
        _ = res.send();
    }
}
