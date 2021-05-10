<%@ page import="java.io.*,java.util.*,javax.mail.*"%>
<%@ page import="javax.mail.internet.*,javax.activation.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<%    
    String result;
    //Recipient's email ID needs to be mentioned.
    String to = "phuoclh1@scb.com.vn";
    InternetAddress[] parse = InternetAddress.parse(to , true);        

    // Sender's email ID needs to be mentioned
    String from = "phuoclh1@scb.com.vn";
    final String username = "phuoclh1@scb.com.vn";
    final String password = "Scb999!!!";

    // Assuming you are sending email through relay.jangosmtp.net
    String host = "mail1.scb.com.vn";

    Properties props = new Properties();
    props.put("mail.smtp.auth", "true");
    props.put("mail.smtp.starttls.enable", "true");
    props.put("mail.smtp.host", host);
    props.put("mail.smtp.port", "587");

    //Get the Session object.
    Session mailSession = Session.getInstance(props,
            new javax.mail.Authenticator() {
        protected PasswordAuthentication getPasswordAuthentication() {
            return new PasswordAuthentication(username,
                    password);
        }
    });

    try {
        // Create a default MimeMessage object.
        Message message = new MimeMessage(mailSession);

        // Set From: header field of the header.
        message.setFrom(new InternetAddress(from));

        // Set To: header field of the header.
        message.setRecipients(Message.RecipientType.TO, parse);
        

        // Set Subject: header field
        message.setSubject("Testing Subject");

        // Now set the actual message
        message.setText("Hello, this is sample for to check send "
                + "email using JavaMailAPI in JSP ");

        // Send message
        Transport.send(message);

        System.out.println("Sent message successfully....");
        result = "Sent message successfully....";

    } catch (MessagingException e) {
        e.printStackTrace();
        result = "Error: unable to send message....";

    }
%>
<html>
    <head>
        <title>Send Email using JSP</title>
    </head>
    <body>
    <center>
        <h1>Send Email using JSP</h1>
    </center>
    <p align="center">
        <%
            out.println("Result: " + result + "\n");
        %>
    </p>
</body>
</html>