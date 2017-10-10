import ballerina.net.jms;
import ballerina.net.jms.jmsmessage;

function main (string[] args) {
    jmsSender();
}

function jmsSender () (boolean) {
    jms:ClientConnector jmsEP;
    map properties = {"initialContextFactory":"org.apache.activemq.jndi.ActiveMQInitialContextFactory",
                         "providerUrl":"tcp://localhost:61616",
                         "connectionFactoryName":"QueueConnectionFactory",
                         "connectionFactoryType":"queue"};

    jmsEP = create jms:ClientConnector(properties);

    jms:JMSMessage queueMessage = jms:createTextMessage(jmsEP);
    jmsmessage:setTextMessageContent(queueMessage, "Hello from JMS");
    jmsEP.send("MyQueue", queueMessage);

    return true;
}

