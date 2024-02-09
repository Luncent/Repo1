<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
<link href="css_styles/LoginPage.css" rel="stylesheet">
<title>Registration</title>
</head>
<body>
	<div class="container1">
		<div class="container2">
		<form method="post" action="Register">
  			<div class="form-group">   
				<label class="lb1" for="Sign in">BuildWise</label>
   				<input type="text" class="form-control" name="login" placeholder="Enter your login">
  			</div>
  			<div class="form-group">
	   			<input type="text" class="form-control" name="password1" placeholder="Enter your password">
  			</div>
  			<div class="form-group">
	   			<input type="text" class="form-control" name="password2" placeholder="Repeat your password">
  			</div>
  			<div class="btn1">
	  		<button type="submit" class="btn btn-primary">Register</button>
	  		</div>
	  		<a class="link" href="LoginPage.html">Страница входа</a>
		</form>
		</div>
	</div>
</body>
</html>