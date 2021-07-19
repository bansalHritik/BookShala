import java.io.IOException;
import java.net.PasswordAuthentication;
import java.util.Properties;

import javax.mail.*;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import jdk.internal.net.http.websocket.Transport;
@WebServlet("/sendMessage")
public class SendMessage extends HttpServlet{

	private static final long serialVersionUID = 1L;

	public void doPost(HttpServletRequest req,HttpServletResponse res) throws ServletException, IOException
	{
		System.out.println("I am Here");
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
        	String nameString = req.getParameter("name");
        	String emailString = req.getParameter("email");
        	String messageString = req.getParameter("message");
        	System.out.println(nameString);
        	System.out.println(emailString);
        	System.out.println(messageString);
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress("hb.rit345@gmail.com"));
            message.setRecipients(
                    Message.RecipientType.TO,
                    InternetAddress.parse("sitesonlyrit@gmail.com")
            );
            message.setSubject(nameString+" contacted You from BookShala");
            String msg = "";
            msg+="<h4>Hello Ritik Bansal ,"+nameString+" contacted you from "+emailString+"</h4>";
            msg+="<p>"+messageString+"</p>";
            message.setContent(msg, "text/html");
            Transport.send(message);
            RequestDispatcher rDispatcher = req.getRequestDispatcher("index.html");
            rDispatcher.forward(req, res);
        } catch (MessagingException e) {
        	
        }
	}
}