
<%@page import="java.io.ByteArrayInputStream"%>
<%@page import="javax.imageio.ImageIO"%>
<%@page import="java.awt.image.BufferedImage"%>
<%@page import="java.io.OutputStream"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@ page trimDirectiveWhitespaces="true" %>
<%@page import="java.sql.Connection"%>
<%@page import="java.sql.Blob"%>
<%@page import ="java.awt.AlphaComposite,java.awt.Graphics2D,java.awt.RenderingHints,java.awt.image.BufferedImage,java.io.File,java.io.IOException,javax.imageio.ImageIO" %>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
    <% 
				String username = (String)session.getAttribute("username");
				
				String password = (String)request.getAttribute("password");
				if((username=="" || username==null)&&( password=="" || password==null))
				{
					request.setAttribute("next_page", "login.html");
					request.setAttribute("message", "Invalid Access ");
					RequestDispatcher rd = request.getRequestDispatcher("error.jsp");
					rd.forward(request, response);
				}
%>
	<%
	OutputStream oStream = null;
	//byte string for image
	byte[] image = null;//because arrays are implemented as objects
	//to recieve data from mysql
	Blob blob = null;
	//Connection object
	Connection connection = null;
	try{
		String id = request.getParameter("id");
		Class.forName("com.mysql.cj.jdbc.Driver");
		connection = DriverManager.getConnection("jdbc:mysql://localhost:3306/ritik","root","7792075538");
		String sql = String.format("select bookpic from books where id = %s",id);
		Statement statement = connection.createStatement();
		ResultSet rSet = statement.executeQuery(sql);
		if(rSet.next())
		{
			blob = rSet.getBlob(1);
			if(blob!=null)
			{
				image= blob.getBytes(1, (int)blob.length());
				response.setContentType("image/jpg");
				oStream = response.getOutputStream();
				oStream.write(image);
				oStream.flush();
				oStream.close();
				return;
			}
			else
			{
				out.println(id+" has not provided Profile Photo ");
			}
		}
		else{
			out.println("Image Not Found");
		}
	}
	catch(Exception e)
	{
		System.out.println(e.getMessage());
		e.printStackTrace();
	}
	%>
<%-- 	<%!
	

		private static final int IMG_WIDTH = 100;
		private static final int IMG_HEIGHT = 100;
	%>
	<% 		
		try{
				
			BufferedImage originalImage = ImageIO.read(new File("c:\\image\\mkyong.jpg"));
			int type = originalImage.getType() == 0? BufferedImage.TYPE_INT_ARGB : originalImage.getType();
				
			BufferedImage resizeImageJpg = resizeImage(originalImage, type);
			ImageIO.write(resizeImageJpg, "jpg", new File("c:\\image\\mkyong_jpg.jpg")); 
				
			BufferedImage resizeImagePng = resizeImage(originalImage, type);
			ImageIO.write(resizeImagePng, "png", new File("c:\\image\\mkyong_png.jpg")); 
				
			BufferedImage resizeImageHintJpg = resizeImageWithHint(originalImage, type);
			ImageIO.write(resizeImageHintJpg, "jpg", new File("c:\\image\\mkyong_hint_jpg.jpg")); 
				
			BufferedImage resizeImageHintPng = resizeImageWithHint(originalImage, type);
			ImageIO.write(resizeImageHintPng, "png", new File("c:\\image\\mkyong_hint_png.jpg")); 
					
		}catch(IOException e1){
			System.out.println(e1.getMessage());
		}
%>
<%! 	
	    private static BufferedImage resizeImage(BufferedImage originalImage, int type){
		BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
		g.dispose();
			
		return resizedImage;
	    }
		
	    private static BufferedImage resizeImageWithHint(BufferedImage originalImage, int type){
			
		BufferedImage resizedImage = new BufferedImage(IMG_WIDTH, IMG_HEIGHT, type);
		Graphics2D g = resizedImage.createGraphics();
		g.drawImage(originalImage, 0, 0, IMG_WIDTH, IMG_HEIGHT, null);
		g.dispose();	
		g.setComposite(AlphaComposite.Src);

		g.setRenderingHint(RenderingHints.KEY_INTERPOLATION,
		RenderingHints.VALUE_INTERPOLATION_BILINEAR);
		g.setRenderingHint(RenderingHints.KEY_RENDERING,
		RenderingHints.VALUE_RENDER_QUALITY);
		g.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
		RenderingHints.VALUE_ANTIALIAS_ON);
		
		return resizedImage;
	    }	

	%> --%>
</body>
</html>