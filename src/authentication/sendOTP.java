package authentication;
import java.util.Properties;
import java.util.Random;
import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
public class sendOTP {

	public static int sendOTPto(String nameString,String usernameString,String toemailString ) {
		final String username = "hb.rit345@gmail.com";
        final String password = "7792075538";
        Properties prop = new Properties();
		prop.put("mail.smtp.host", "smtp.gmail.com");
        prop.put("mail.smtp.port", "465");
        prop.put("mail.smtp.auth", "true");
        prop.put("mail.smtp.socketFactory.port", "465");
        prop.put("mail.smtp.socketFactory.class", "javax.net.ssl.SSLSocketFactory");
        
        Session session = Session.getInstance(prop, new javax.mail.Authenticator() {
                    protected PasswordAuthentication getPasswordAuthentication() {
                        return new PasswordAuthentication(username, password);
                    }
                });
        try {
        	Random random = new Random();
        	int otp = random.nextInt((9999 - 1000) + 1) + 1000;
        	System.out.println(otp);
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("hb.rit345@gmail.com"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse(toemailString)
            );
            message.setSubject("Verification Email");
            String msg = "";
            msg+="<h2>Hello "+nameString+"</h2>";
            msg+="<h3>Your One Time Password Is "+"<strong style=\"color:red\">"+otp+"</strong>"+"</h3>";
            msg+="<h2>Kindly Enter The OTP In Required Field</h2>";
            message.setContent(msg, "text/html");
            Transport.send(message);
          return otp;
        } catch (MessagingException e) {
        	return 0;
        }
	}
}