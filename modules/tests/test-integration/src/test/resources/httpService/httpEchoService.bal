import ballerina.net.http;

@http:configuration {
    basePath:"/echo",
    port:9094
}
service<http> echo {

    @http:resourceConfig {
        methods:["POST"],
        path:"/"
    }
    resource echo (http:Connection con, http:Request req) {
        http:Response res = {};
        res.setStringPayload("hello world");
        _ = con.respond(res);
    
    }
    
}

@http:configuration {
    basePath:"/echoOne",
    port:9094
}
service<http> echoOne {

    @http:resourceConfig {
        methods:["POST"],
        path:"/abc"
    }
    resource echoAbc (http:Connection con, http:Request req) {
        http:Response res = {};
        res.setStringPayload("hello world");
        _ = con.respond(res);

    }
}

@http:configuration {
    basePath:"/echoDummy"
}
service<http> echoDummy {

    @http:resourceConfig {
        methods:["POST"],
        path:"/"
    }
    resource echoDummy (http:Connection con, http:Request req) {
        http:Response res = {};
        res.setStringPayload("hello world");
        _ = con.respond(res);
    }

    @http:resourceConfig {
        methods:["OPTIONS"],
        path:"/getOptions"
    }
    resource echoOptions (http:Connection con, http:Request req) {
        http:Response res = {};
        res.setStringPayload("hello Options");
        _ = con.respond(res);
    }
}
