import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import java.util.Properties;
import java.util.Random;

public class SendEmailSSL {

    public static void main(String[] args) {

        final String username = "hb.rit345@gmail.com";
        final String password = "7792075538";

        Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        
        Session session = Session.getInstance(prop,
                new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });

        try {

        	Random random = new Random();
        	int rand = random.nextInt(10);
        	System.out.print(rand);
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("hb.rit345@gmail.com"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse("sitesonlyrit@gmail.com")
            );
            message.setSubject("Verification Email");
            String msg = "";
            msg+="<h1>Hello User Thank You For SignUp</h1>";
            msg+="<h3>Your One Time Password Is "+rand+"</h3>";
            message.setContent(msg, "text/html");
            //message.setText(String.valueOf(rand));
            Transport.send(message);

            System.out.println("Done");

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }

}
