import ballerina.net.http;

service<http> sample {
    resource echo (http:Connection con, http:Request req) {
        http:Response res = {};
        http:Response resp = {};
        res.setStringPayload("wso2");
        resp.setStringPayload("Ballerina");
        _ = con.respond(res);
        _ = con.respond(resp);
    }
}
