import ballerina.net.http;

@http:configuration {basePath:"/headQuote"}
service<http> headQuoteService {

    @http:resourceConfig {
        path:"/default"
    }
    resource defaultResource (http:Request req, http:Response resp) {
        endpoint<http:HttpClient> endPoint {
            create http:HttpClient("http://localhost:9090", {});
        }
        string method = req.getMethod();
        http:Response clientResponse;
        clientResponse, _ = endPoint.execute(method, "/getQuote/stocks", req);
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        path:"/forward11"
    }
    resource forwardRes11 (http:Request req, http:Response resp) {
        endpoint<http:HttpClient> endPoint {
              create http:HttpClient("http://localhost:9090", {});
        }
        http:Response clientResponse;
        clientResponse, _ = endPoint.forward("/getQuote/stocks", req);
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        path:"/forward22"
    }
    resource forwardRes22 (http:Request req, http:Response resp) {
        endpoint<http:HttpClient> endPoint {
              create http:HttpClient("http://localhost:9090", {});
        }
        http:Response clientResponse;
        clientResponse, _ = endPoint.forward("/getQuote/stocks", req);
        _ = resp.forward(clientResponse);
    }

    @http:resourceConfig {
        path:"/getStock/{method}"
    }
    resource commonResource (http:Request req, http:Response resp, string method) {
        endpoint<http:HttpClient> endPoint {
            create http:HttpClient("http://localhost:9090", {});
        }
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
        path:"/stocks"
    }
    resource defaultStock (http:Request req, http:Response res) {
        res.setHeader("Method", "any");
        res.setStringPayload("default");
        _ = res.send();
    }
}
