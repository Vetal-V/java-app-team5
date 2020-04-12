<%@ page import="java.sql.*, dotenv.*" %>  

<%
if(session.getAttribute("login")!=null) //check login session user not access or back to index.jsp page
{
	response.sendRedirect("welcome.jsp");
}
%>

<%
try
{
	Class.forName("com.mysql.jdbc.Driver"); //load driver
	Connection con=DriverManager
		.getConnection("jdbc:mysql://HOST_IP:3306/dbuser", "USER", "PASSWORD"); //create connection
	
	if(request.getParameter("btn_login")!=null) //check login button click event not null
	{
		String dbemail,dbpassword;
		String email,password;
		
		email=request.getParameter("txt_email"); //txt_email
		password=request.getParameter("txt_password"); //txt_password
		
		PreparedStatement pstmt=null; //create statement
		
		pstmt=con.prepareStatement("select * from login where email=? AND password=?"); //sql select query 
		pstmt.setString(1,email);
		pstmt.setString(2,password);
		
		ResultSet rs=pstmt.executeQuery(); //execute query and store in resultset object rs.
		
		if(rs.next())
		{
			dbemail=rs.getString("email");
			dbpassword=rs.getString("password");
			
			if(email.equals(dbemail) && password.equals(dbpassword))
			{
				session.setAttribute("login",dbemail); //session name is login and store fetchable database email address
				response.sendRedirect("welcome.jsp"); //after login success redirect to welcome.jsp page
			}
		}
		else
		{
			request.setAttribute("errorMsg","invalid email or password"); //invalid error message for email or password wrong
		}
		con.close(); //close connection	
	}
}
catch(Exception e)
{
	out.println(e);
}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>Login</title>
	<link rel="stylesheet" href="css/main.css">
	<link rel="stylesheet" href="css/login-register.css">
	
	<script>
		function validate()
		{
			var email = document.myform.txt_email;
			var password = document.myform.txt_password;
				
			if (email.value == null || email.value == "") //check email textbox not blank
			{
				window.alert("Please enter email"); //alert message
				email.style.background = '#f08080';
				email.focus();
				return false;
			}
			if (password.value == null || password.value == "") //check password textbox not blank
			{
				window.alert("Please enter password"); //alert message
				password.style.background = '#f08080'; 
				password.focus();
				return false;
			}
		}
	</script>
</head>

<body>
    <div class="main-content">
        <form class="form-register" method="post" name="myform" onsubmit="return validate();">
            <div class="form-register-with-email">
                <div class="form-white-background">
                    <div class="form-title-row">
                        <h1>Login</h1>
                    </div>
					<p style="color:red">				   		
					<%
					if(request.getAttribute("errorMsg")!=null)
					{
						out.println(request.getAttribute("errorMsg")); //error message for email or password 
					}
					%>
					</p>
				   </br>
                    <div class="form-row">
                        <label>
                            <span>Email</span>
                            <input type="text" name="txt_email" id="email" placeholder="enter email">
                        </label>
                    </div>
                    <div class="form-row">
                        <label>
                            <span>Password</span>
                            <input type="password" name="txt_password" id="password" placeholder="enter password">
                        </label>
                    </div>
					<input type="submit" name="btn_login" value="Login">
                </div>
				<a href="register.jsp" class="form-log-in-with-existing">You Don't have an account? <b> Register here </b></a>
            </div>
        </form>
    </div>
</body>
</html>
