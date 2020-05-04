<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Welcome : <%=session.getAttribute("login")%></title>
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/login-register.css">
  </head>
  <body>
    <div class="main-content">
      <center>
        <%
        if(session.getAttribute("login")!=null || session.getAttribute("login")==" ") //check condition unauthorize user not direct access welcome.jsp page
        {
          response.sendRedirect("index.jsp"); 
        }
        %>
        <h1> Welcome, <%=session.getAttribute("login")%> </h1>
        <h2><a href="logout.jsp">Logout</a></h2>
      </center>
    </div>
  </body>
</html>
