import ballerina.lang.system;
import ballerina.net.jms;
import ballerina.net.jms.jmsmessage;
import ballerina.net.http;
import ballerina.net.http.response;


@jms:configuration {
    initialContextFactory:"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
    providerUrl:"tcp://localhost:61616",
    connectionFactoryType:"queue",
    connectionFactoryName:"QueueConnectionFactory",
    destination:"MyQueue",
    acknowledgementMode:"AUTO_ACKNOWLEDGE"
}
service<jms> jmsService {
    resource onMessage (jms:JMSMessage m) {
        //Process the message
        string msgType = jmsmessage:getStringProperty(m, "JMS_MESSAGE_TYPE");
        string stringPayload = jmsmessage:getTextMessageContent(m);
        system:println("message type : " + msgType);
        system:println(stringPayload);
    }
}



@http:configuration {
    basePath:"/echo"
}
service<http> echo {

    @http:resourceConfig {
        methods:["POST"],
        path:"/"
    }
    resource echo (http:Request req, http:Response res) {
        response:setStringPayload(res, "hello world");
        response:send(res);
    }
}
