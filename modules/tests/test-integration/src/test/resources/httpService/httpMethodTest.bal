import ballerina.net.http;

@http:configuration {basePath:"/headQuote"}
service<http> headQuoteService {

    @http:resourceConfig {
        path:"/default"
    }
    resource defaultResource (http:Connection con, http:Request req) {
        endpoint<http:HttpClient> endPoint {
            create http:HttpClient("http://localhost:9090", {});
        }
        string method = req.getMethod();
        http:Response clientResponse;
        clientResponse, _ = endPoint.execute(method, "/getQuote/stocks", req);
        _ = con.respond(clientResponse);
    }

    @http:resourceConfig {
        path:"/forward11"
    }
    resource forwardRes11 (http:Connection con, http:Request req) {
        endpoint<http:HttpClient> endPoint {
              create http:HttpClient("http://localhost:9090", {});
        }
        http:Response clientResponse;
        clientResponse, _ = endPoint.forward("/getQuote/stocks", req);
        _ = con.respond(clientResponse);
    }

    @http:resourceConfig {
        path:"/forward22"
    }
    resource forwardRes22 (http:Connection con, http:Request req) {
        endpoint<http:HttpClient> endPoint {
              create http:HttpClient("http://localhost:9090", {});
        }
        http:Response clientResponse;
        clientResponse, _ = endPoint.forward("/getQuote/stocks", req);
        _ = con.respond(clientResponse);
    }

    @http:resourceConfig {
        path:"/getStock/{method}"
    }
    resource commonResource (http:Connection con, http:Request req, string method) {
        endpoint<http:HttpClient> endPoint {
            create http:HttpClient("http://localhost:9090", {});
        }
        http:Response clientResponse;
        clientResponse, _ = endPoint.execute(method, "/getQuote/stocks", req);
        _ = con.respond(clientResponse);
    }
}

@http:configuration {basePath:"/sampleHead"}
service<http> testClientConHEAD {

    @http:resourceConfig {
        methods:["HEAD"],
        path:"/"
    }
    resource passthrough (http:Connection con, http:Request req) {
        endpoint<http:HttpClient> quoteEP {
            create http:HttpClient("http://localhost:9090", {});
        }
        http:Response clientResponse;
        clientResponse, _ = quoteEP.get("/getQuote/stocks", req);
        _ = con.respond(clientResponse);
    }
}

@http:configuration {basePath:"/getQuote"}
service<http> quoteService {

    @http:resourceConfig {
        methods:["GET"],
        path:"/stocks"
    }
    resource company (http:Connection con, http:Request req) {
        http:Response res = {};
        res.setStringPayload("wso2");
        _ = con.respond(res);
    }

    @http:resourceConfig {
        methods:["POST"],
        path:"/stocks"
    }
    resource product (http:Connection con, http:Request req) {
        http:Response res = {};
        res.setStringPayload("ballerina");
        _ = con.respond(res);
    }

    @http:resourceConfig {
        path:"/stocks"
    }
    resource defaultStock (http:Connection con, http:Request req) {
        http:Response res = {};
        res.setHeader("Method", "any");
        res.setStringPayload("default");
        _ = con.respond(res);
    }
}
